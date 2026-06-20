"""
nl_scan.py  -  Heuristic scanner/extractor for NaomiLib NL1/NL2 model meshes

NL1  objFormat in {0,1}
     [0x00] objFormat         uint32  0 or 1
     [0x04] all_global_flag   uint32  PSTA bits 0-4, bit0 set
     [0x08] centroid xyz      float32 x3
     [0x14] bound_radius      float32 >= 0
     [0x64] mesh_end_offset   uint32  mesh = value + 0x70

NL2  format_flag == 0x00000100
     [0x00] format_flag       uint32  must be 0x100
     [0x04] global_status     uint32  PSTA bits 0-4, bit0 set
     [0x08] centroid xyz      float32 x3
     [0x14] radius            float32 >= 0
     [0x18] all_size          uint32  total mesh byte length

Usage
-----
  python nl_scan.py                        (file picker)
  python nl_scan.py a.bin b.bin ...
  python nl_scan.py a.bin --out <dir> --min-size <bytes>
"""

import math
import os
import struct
import sys
from concurrent.futures import ThreadPoolExecutor, as_completed


NL2_FORMAT_FLAG  = 0x00000100
NL1_OBJ_FORMATS  = (0, 1)
PSTA_KNOWN_BITS  = 0x1F          # only bits 0-4 defined
PSTA_VALID_BIT   = 0x01          # bit0 must be set (non-empty model)
NL2_OBJTAG_SIZE  = 96
NL2_ALL_SIZE_OFF = 0x18
NL1_HDR_MIN      = 0x68
NL1_MESH_OFF     = 0x64
MIN_MESH_BYTES   = 0xD8          # importer floor
MAX_MESH_BYTES   = 32 * 1024 * 1024


def u32le(buf, off):
    if off + 4 > len(buf):
        return None
    return struct.unpack_from("<I", buf, off)[0]


def f32le(buf, off):
    if off + 4 > len(buf):
        return None
    return struct.unpack_from("<f", buf, off)[0]


def is_finite_coord(v):
    return math.isfinite(v) and -1e7 <= v <= 1e7


def is_valid_radius(v):
    return math.isfinite(v) and 0.0 <= v <= 1e7


def try_nl2(buf, off):
    if off + NL2_OBJTAG_SIZE > len(buf):
        return False, 0
    if u32le(buf, off) != NL2_FORMAT_FLAG:
        return False, 0
    # global status: only PSTA bits, bit0 required
    gflag = u32le(buf, off + 0x04)
    if gflag & ~PSTA_KNOWN_BITS or not (gflag & PSTA_VALID_BIT):
        return False, 0
    # bounding sphere centroid
    for foff in (0x08, 0x0C, 0x10):
        fv = f32le(buf, off + foff)
        if fv is None or not is_finite_coord(fv):
            return False, 0
    cr = f32le(buf, off + 0x14)
    if cr is None or not is_valid_radius(cr):
        return False, 0
    # all_size: total mesh length, 4-byte aligned
    all_size = u32le(buf, off + NL2_ALL_SIZE_OFF)
    if all_size is None or all_size & 3:
        return False, 0
    if not (MIN_MESH_BYTES <= all_size <= MAX_MESH_BYTES):
        return False, 0
    if off + all_size > len(buf):
        return False, 0
    # opq/trs offsets: zero, file-relative, or SH4 RAM pointer
    for foff in (0x40, 0x48):
        v = u32le(buf, off + foff)
        if v is None or not (v == 0 or v < all_size or v >= 0x8C000000):
            return False, 0
    return True, all_size


def try_nl1(buf, off):
    if off + NL1_HDR_MIN > len(buf):
        return False, 0
    if u32le(buf, off) not in NL1_OBJ_FORMATS:
        return False, 0
    # global flag: only PSTA bits, bit0 required
    gflag = u32le(buf, off + 0x04)
    if gflag is None or gflag & ~PSTA_KNOWN_BITS or not (gflag & PSTA_VALID_BIT):
        return False, 0
    # bounding sphere centroid
    for foff in (0x08, 0x0C, 0x10):
        fv = f32le(buf, off + foff)
        if fv is None or not is_finite_coord(fv):
            return False, 0
    br = f32le(buf, off + 0x14)
    if br is None or not is_valid_radius(br):
        return False, 0
    # derive total size from mesh_end_offset
    mesh_end_rel = u32le(buf, off + NL1_MESH_OFF)
    if mesh_end_rel is None:
        return False, 0
    all_size = mesh_end_rel + NL1_MESH_OFF + 0xC
    if all_size & 3 or not (MIN_MESH_BYTES <= all_size <= MAX_MESH_BYTES):
        return False, 0
    if off + all_size > len(buf) or all_size < 0x28:
        return False, 0
    # first mesh param: para_type bits[31:29] must be 4, 5, or 7
    mp0 = u32le(buf, off + 0x18)
    if mp0 is None or (mp0 >> 29) & 7 not in (4, 5, 7):
        return False, 0
    return True, all_size


class ScanResult:
    __slots__ = ("offset", "fmt", "size")
    def __init__(self, offset, fmt, size):
        self.offset = offset
        self.fmt    = fmt
        self.size   = size


def scan(buf):
    results  = []
    end      = len(buf)
    pos      = 0
    last_end = 0  # prevent overlapping matches

    while pos + 4 <= end:
        w = u32le(buf, pos)

        if w == NL2_FORMAT_FLAG:
            ok, size = try_nl2(buf, pos)
            if ok and pos >= last_end:
                results.append(ScanResult(pos, "NL2", size))
                last_end = pos + size
                pos += size
                continue

        elif w in NL1_OBJ_FORMATS:
            ok, size = try_nl1(buf, pos)
            if ok and pos >= last_end:
                results.append(ScanResult(pos, "NL1", size))
                last_end = pos + size
                pos += size
                continue

        pos += 4

    return results


def process_file(archive_path, out_dir, min_size):
    with open(archive_path, "rb") as fh:
        buf = fh.read()

    results = scan(buf)
    os.makedirs(out_dir, exist_ok=True)

    extracted = 0
    for idx, r in enumerate(results):
        if r.size < min_size:
            continue
        mesh = buf[r.offset : r.offset + r.size]
        out_path = os.path.join(out_dir, "{:05d}.bin".format(idx))
        with open(out_path, "wb") as fh:
            fh.write(mesh)
        extracted += 1

    return archive_path, len(results), extracted


def pick_files():
    import tkinter as tk
    from tkinter import filedialog
    root = tk.Tk()
    root.withdraw()
    paths = filedialog.askopenfilenames(
        title="Select archive(s) to scan",
        filetypes=[("All files", "*.*")]
    )
    root.destroy()
    return list(paths)


def show_results(lines):
    import tkinter as tk
    root = tk.Tk()
    root.withdraw()
    win = tk.Toplevel(root)
    win.title("nl_scan results")
    win.resizable(False, False)
    msg = tk.Message(win, text="\n".join(lines), width=480, padx=16, pady=12)
    msg.pack()
    btn = tk.Button(win, text="OK", width=10, command=win.destroy)
    btn.pack(pady=(0, 12))
    win.grab_set()
    win.wait_window()
    root.destroy()


def main():
    import argparse

    ap = argparse.ArgumentParser()
    ap.add_argument("archives", nargs="*")
    ap.add_argument("--out", default=None)
    ap.add_argument("--min-size", default=MIN_MESH_BYTES, type=int)
    args = ap.parse_args()

    archives = args.archives or pick_files()
    if not archives:
        sys.exit(0)

    archives = [p for p in archives if os.path.isfile(p)]
    if not archives:
        sys.exit(1)

    lines      = []
    script_dir = os.path.dirname(os.path.abspath(__file__))

    with ThreadPoolExecutor() as executor:
        futures = {}
        for path in archives:
            stem    = os.path.splitext(os.path.basename(path))[0]
            out_dir = args.out or os.path.join(script_dir, stem)
            futures[executor.submit(process_file, path, out_dir, args.min_size)] = path

        for future in as_completed(futures):
            path, found, extracted = future.result()
            lines.append("{}: {} found, {} extracted".format(
                os.path.basename(path), found, extracted))

    show_results(sorted(lines))


if __name__ == "__main__":
    main()
