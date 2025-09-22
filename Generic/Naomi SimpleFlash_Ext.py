import struct
import sys
import os

''' By VincentNL 2025 
Full credits to almendaz for simpleflash.bms
'''

def main():
    if len(sys.argv) < 2:
        print("Usage: SimpleFlash_Ext.py <ROM file>")
        sys.exit(1)

    rom_path = sys.argv[1]
    if not os.path.isfile(rom_path):
        print(f"File not found: {rom_path}")
        sys.exit(1)

    # MAGIC: "SimpleFlashFS" + 19 bytes padding
    search_bytes = b"SimpleFlashFS" + bytes(19)

    with open(rom_path, "rb") as f:
        rom_data = f.read()

    base_offset = rom_data.find(search_bytes)
    if base_offset == -1:
        print("Base offset signature not found!")
        sys.exit(1)

    # start_pos = base_offset + stored offset at 0x38
    start_pos = base_offset + struct.unpack_from("<I", rom_data, base_offset + 0x38)[0]

    print(f"Base offset: 0x{base_offset:X}")
    print(f"Header table start (start_pos): 0x{start_pos:X}")

    extract_folder = "Extracted"
    os.makedirs(extract_folder, exist_ok=True)

    header_pos = start_pos

    while True:
        # DISTANCE is at header_pos + 4
        dist_off = header_pos + 4
        if dist_off + 4 > len(rom_data):
            break
        distance = struct.unpack_from("<I", rom_data, dist_off)[0]
        if distance == 0xFFFFFFFF:
            break

        # FILESIZE is at header_pos + 0xC
        filesize_off = header_pos + 0xC
        if filesize_off + 4 > len(rom_data):
            break
        filesize = struct.unpack_from("<I", rom_data, filesize_off)[0]

        # FILENAME is at header_pos + 0x80
        filename_off = header_pos + 0x80
        filename_bytes = rom_data[filename_off : min(filename_off + 0x40, len(rom_data))]
        filename = filename_bytes.split(b'\x00', 1)[0].decode('ascii', errors='ignore')
        if filename == "rom":
            filename = "rom/_"

        file_start = header_pos + 0x100
        file_end = file_start + filesize

        if file_start < 0 or file_start > len(rom_data):
            print(f"Invalid file_start for {filename}: 0x{file_start:X}")
            break
        if file_end > len(rom_data):
            print(f"Warning: {filename} filesize extends past ROM end; clamping.")
            file_end = len(rom_data)

        print(f"Extracting: {filename}, Header: 0x{header_pos:X}, FileStart: 0x{file_start:X}, SIZE: {filesize}")

        output_path = os.path.join(extract_folder, filename)
        os.makedirs(os.path.dirname(output_path), exist_ok=True)

        # write the files!
        with open(output_path, "wb") as out_file:
            out_file.write(rom_data[file_start:file_end])

        header_pos += distance

if __name__ == "__main__":
    main()