'''CHR Extractor by VincentNL 21/10/2023'''

import struct
import os
from tkinter import Tk, filedialog

root = Tk()
root.withdraw()

chr_files = filedialog.askopenfilenames(title="Select .chr Files", filetypes=(("CHR Files", "*.chr"), ("All Files", "*.*")))
extraction_folder = filedialog.askdirectory(title="Select Extraction Folder")

def read_uint32(file):
    return struct.unpack("<L", file.read(4))[0]

def save_pvr(A, bin, chr):
    bin.seek(PVR_start)
    PVR_size_val = PVR_size + 0x8
    MEMORY_FILE = bytearray(b'PVRT')
    MEMORY_FILE += struct.pack("<L", PVR_size_val)
    MEMORY_FILE += struct.pack("<L", pixel_type)
    MEMORY_FILE += struct.pack("<L", tex_size)
    MEMORY_FILE += bin.read(PVR_size)

    if not os.path.exists(f"{extraction_folder}\{name}\Textures"):
        os.makedirs(f"{extraction_folder}\{name}\Textures")
    with open(f"{extraction_folder}\{name}\Textures\TexID_{str(A).zfill(3)}.PVR", "wb") as f:
        f.write(MEMORY_FILE)

def textures_loop():
    global PVR_start,PVR_size,pixel_type,tex_size
    with open(pvr_container, "rb") as bin:
        binsize = len(bin.read())

        with open(chr_file, "rb") as chr:
            chr.seek(0x10)     # where total textures are specified
            total_tex = read_uint32(chr)
            chr.seek(0x8)      # pointer of texture headers chunk
            PVR_header_offset = read_uint32(chr)
            chr.seek(PVR_header_offset + 0x8)     # First texture RAM offset, which is also base address
            base_address = read_uint32(chr)
            chr.seek(PVR_header_offset)    # Get to the beginning of first texture header

            # Textures loop
            # tex_size --> pixel_type --> PVR_start --> PVR_end ( next PVR_start or if last tex, total size of .bin)

            for A in range(total_tex):
                if A < total_tex - 1:
                    tex_size = read_uint32(chr)
                    pixel_type = read_uint32(chr)
                    PVR_start = read_uint32(chr) - base_address
                    nextpos = chr.tell() + 0x8
                    chr.seek(nextpos)
                    PVR_end = read_uint32(chr) - base_address
                    PVR_size = PVR_end - PVR_start
                    nextpos -= 0x8
                    chr.seek(nextpos)
                else:
                    tex_size = read_uint32(chr)
                    pixel_type = read_uint32(chr)
                    PVR_start = read_uint32(chr) - base_address
                    PVR_end = binsize
                    PVR_size = PVR_end - PVR_start

                save_pvr(A, bin, chr)

def models_loop():
    with open(chr_file, "rb") as chr:
        chr.seek(0xc)      # where the number of models is specified
        total_models = read_uint32(chr)
        chr.seek(0x4)       # where model pointers chunk is specified
        models_pointers = read_uint32(chr)
        chr.seek(models_pointers)
        base_address = read_uint32(chr)     # First model RAM offset, which is also base address
        model_offset_ptr = models_pointers      # First model offset in .chr file

        # Models loop
        # model_offset_ptr --> model_start --> model_end ( next model_start or if last one, models_pointers - 0x8)

        for A in range(total_models):
            chr.seek(model_offset_ptr)
            model_start = (read_uint32(chr) - base_address) + 0x18    # 0x18 is a fixed header size

            if A < total_models - 1:
                next_offset = read_uint32(chr)
                model_end = (next_offset - base_address) + 0x18       # 0x18 is a fixed header size
            else:
                model_end = models_pointers - 0x8       # Last model end is always at -0x8 from model_pointers chunk

            model_size = model_end - model_start

            chr.seek(model_start)
            if not os.path.exists(f"{extraction_folder}\{name}"):
                os.makedirs(f"{extraction_folder}\{name}")
            with open(rf"{extraction_folder}\{name}\model_{name}_{str(A).zfill(3)}.bin", "wb") as f:
                f.write(chr.read(model_size))

            model_offset_ptr += 0x4

for i, chr_file_path in enumerate(chr_files):
    name = os.path.splitext(os.path.basename(chr_file_path))[0]  # Take base filename
    chr_file = name + ".chr"
    pvr_container = name + ".bin"
    textures_loop()
    models_loop()
    
