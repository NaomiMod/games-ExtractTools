# Virtua Fighter 3tb (US) DC - POL / TEX model extractor
# 
# 2026 by VincentNL
# --------------------------
# ♥  ko-fi.com/vincentnl 
# ♥  patreon.com/vincentnl
# --------------------------

import os
import sys
import struct
import tkinter as tk
from tkinter import filedialog, messagebox
import threading


def make_pvr(raw_pixels: bytes, width: int, height: int,
             px_format: int = 1, tex_format: int = 1) -> bytes:
    pad  = (4 - (len(raw_pixels) % 4)) % 4
    data = raw_pixels + b'\x00' * pad
    pvrt_data_size = len(data) + 8
    return (
        b'PVRT' +
        struct.pack('<I', pvrt_data_size) +
        bytes([px_format, tex_format, 0x00, 0x00]) +
        struct.pack('<HH', width, height) +
        data
    )


def parse_pol(pol: bytes) -> dict:
    num_nl_slots    = struct.unpack_from('<H', pol, 0x0C)[0]
    num_tex_descs   = struct.unpack_from('<H', pol, 0x0E)[0]
    ptr_slot_table  = struct.unpack_from('<I', pol, 0x10)[0]
    ptr_model_block = struct.unpack_from('<I', pol, 0x14)[0]

    slots = []
    for i in range(num_nl_slots):
        raw = struct.unpack_from('<I', pol, ptr_slot_table + i * 4)[0]
        slots.append((raw & 1, raw & ~1))

    pol_slot_offsets = sorted(off for (flag, off) in slots if flag == 1)

    tex_descs = []
    for i in range(num_tex_descs):
        off = ptr_model_block + i * 16
        dim_word, flags, tex_off, _ = struct.unpack_from('<IIII', pol, off)
        tex_descs.append({
            'w':        dim_word & 0xFFFF,
            'h':        (dim_word >> 16) & 0xFFFF,
            'fmt_type': flags & 0xFF,
            'fmt_flag': (flags >> 8) & 0xFF,
            'tex_off':  tex_off,
        })

    big_model_start  = ptr_model_block + num_tex_descs * 16
    big_model_end    = pol_slot_offsets[0] if pol_slot_offsets else len(pol)
    NL_SIZE_PTR      = 0x48E8
    NL_SIZE_CNT      = 0x5488
    NL_PTR_THRESHOLD = 0x1000

    big_model_offsets = []
    pos = big_model_start
    while pos < big_model_end:
        big_model_offsets.append(pos)
        pch = struct.unpack_from('<I', pol, pos + 0x18)[0]
        pos += NL_SIZE_PTR if pch >= NL_PTR_THRESHOLD else NL_SIZE_CNT

    return {
        'tex_descs':         tex_descs,
        'big_model_offsets': big_model_offsets,
        'big_model_end':     big_model_end,
        'pol_slot_offsets':  pol_slot_offsets,
    }


def extract(pol_path: str, out_root: str) -> bool:
    pol_path  = os.path.abspath(pol_path)
    src_dir   = os.path.dirname(pol_path)
    base_name = os.path.splitext(os.path.basename(pol_path))[0]

    tex_path = None
    for fname in os.listdir(src_dir):
        if fname.upper() == base_name.upper() + '.TEX':
            tex_path = os.path.join(src_dir, fname)
            break
    if tex_path is None:
        return False

    pol = open(pol_path, 'rb').read()
    tex = open(tex_path, 'rb').read()

    try:
        info = parse_pol(pol)
    except Exception:
        return False

    out_dir      = os.path.join(out_root, base_name)
    out_textures = os.path.join(out_dir, 'Textures')
    os.makedirs(out_textures, exist_ok=True)

    big_offsets = info['big_model_offsets']
    big_end     = info['big_model_end']
    tex_descs   = info['tex_descs']
    pol_slots   = info['pol_slot_offsets']

    for i, off in enumerate(big_offsets):
        end = big_offsets[i + 1] if i + 1 < len(big_offsets) else big_end
        open(os.path.join(out_dir, f'model_{i:03d}.unk'), 'wb').write(pol[off:end])

    for i, td in enumerate(tex_descs):
        w, h    = td['w'], td['h']
        tex_off = td['tex_off']
        size    = w * h * 2
        raw     = tex[tex_off: tex_off + size]
        if len(raw) < size:
            raw = raw + b'\x00' * (size - len(raw))
        pvr = make_pvr(raw, w, h, px_format=td['fmt_type'], tex_format=td['fmt_flag'])
        open(os.path.join(out_textures, f'TexID_{i:03d}.PVR'), 'wb').write(pvr)

    for i, off in enumerate(pol_slots):
        end = pol_slots[i + 1] if i + 1 < len(pol_slots) else len(pol)
        open(os.path.join(out_dir, f'model_{i:03d}.bin'), 'wb').write(pol[off:end])

    return True


def find_pol_files(root_dir: str) -> list:
    found = []
    for dirpath, _, filenames in os.walk(root_dir):
        for fname in filenames:
            if fname.upper().endswith('.POL'):
                found.append(os.path.join(dirpath, fname))
    return sorted(found)


def run_extraction(gdi_dir: str, out_root: str):
    pol_files = find_pol_files(gdi_dir)
    if not pol_files:
        messagebox.showwarning('Nothing found', 'No .POL files found in the selected folder.')
        return

    ok = err = 0
    for pol_path in pol_files:
        if extract(pol_path, out_root):
            ok += 1
        else:
            err += 1

    if err == 0:
        messagebox.showinfo('Done', f'Extracted {ok} file(s).\n\nOutput:\n{out_root}')
    else:
        messagebox.showwarning('Done with errors', f'{ok} extracted, {err} errors.')


class App(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title('Virtua Fighter 3tb [DC] Model Extractor')
        self.withdraw()

        script_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
        out_root   = os.path.join(script_dir, 'Extracted')

        gdi_dir = filedialog.askdirectory(title='Select Extracted GDI folder')
        if not gdi_dir:
            self.destroy()
            return

        threading.Thread(
            target=lambda: (run_extraction(gdi_dir, out_root), self.destroy()),
            daemon=True
        ).start()

        self.mainloop()


if __name__ == '__main__':
    App()