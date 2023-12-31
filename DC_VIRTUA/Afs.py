import os

def pad(value):
    remainder = value % 2048
    if remainder != 0:
        padding = 2048 - remainder
        value += padding

    return value


def pack_afs(output_filename, input_files):
    afs_header = bytearray()
    afs_data = bytearray()

    # AFS Header
    afs_header += b'\x41\x46\x53\x00'  # Placeholder for magic number
    afs_header += len(input_files).to_bytes(4, 'little')
    base_off = 0x8 * len(input_files) + 0x8
    padded_start = pad(base_off)
    pad_size = padded_start - base_off


    # Iterate through input files for both header and data
    for input_file in input_files:

        # Header
        file_start_offset = padded_start
        afs_header += file_start_offset.to_bytes(4, 'little')  # Placeholder for file start offset
        file_size = os.path.getsize(input_file)
        afs_header += file_size.to_bytes(4, 'little')
        padded_start += file_size

        # Data
        with open(input_file, 'rb') as input_file_handle:
            afs_data += input_file_handle.read()

        # Calculate remaining padding needed for the data and align to 2048 bytes
        remaining_padding = pad(padded_start) - padded_start
        afs_data += b'\0' * remaining_padding  # Padding using b'\0'
        padded_start += remaining_padding

    # Add padding to header
    afs_header += b'\0' * pad_size

    # Merge header and data
    merged_data = afs_header + afs_data

    # Write to output file
    with open(output_filename, 'wb') as output_file:
        output_file.write(merged_data)


def unpack_afs(input_filename,out_dir):
    with open(input_filename, 'rb') as file:
        # Read NAME
        name = os.path.basename(input_filename[:-3])
        filename = ""

        # Initialize variables
        magic = int.from_bytes(file.read(4), 'little')

        if magic == 5457473:
            files_number, names_offset = int.from_bytes(file.read(4), 'little'), int.from_bytes(file.read(4), 'little') - 0x8
            ext = 'bin'

            # Set file pointer to NAMES_OFFSET
            file.seek(names_offset)

            # Get NAMES_OFFSET again
            names_offset = int.from_bytes(file.read(4), 'little')

            use_names = names_offset != 0

            # Set file pointer to 0x8
            file.seek(0x8)

            # Save file pointer position
            file_pointer = file.tell()

            # Loop through files
            for a in range(files_number):
                # Set file pointer to FILE_POINTER
                file.seek(file_pointer)
                file_start, file_size = int.from_bytes(file.read(4), 'little'), int.from_bytes(file.read(4), 'little')

                if use_names:
                    # Set file pointer to NAMES_OFFSET
                    file.seek(names_offset)

                    # Get FILENAME
                    filename = file.read(0x30).rstrip(b'\x00').decode('latin-1')
                else:
                    # Check MAGIC
                    file.seek(file_start)
                    ftype = int.from_bytes(file.read(2), 'little')


                    # Adx
                    if ftype == 128:
                        cri_off = int.from_bytes(file.read(2), 'big')
                        file.seek(file_start+cri_off)
                        cri = int.from_bytes(file.read(4), 'little')

                        ext = 'adx' if cri == 1230127913 else 'bin'
                    else:
                        ext = 'bin'

                    filename = f"{out_dir}/{name}/{str(a).zfill(4)}.{ext}"

                # Create directories if they don't exist
                output_directory = os.path.join(os.getcwd(), os.path.dirname(filename))
                os.makedirs(output_directory, exist_ok=True)

                # Save file
                with open(filename, 'wb') as output_file:
                    file.seek(file_start)
                    output_file.write(file.read(file_size))

                # Update offsets and counters
                names_offset += 0x30
                file_pointer += 0x8
        else:
            print('Invalid AFS type!')

        print("Unpacking complete.")

# Usage
# input_filename = r".\SND_BGM.AFS"
# out_dir = r"C:\BackupPersonali"

# unpack_afs(input_filename,out_dir)


# input_directory = r".\SND_BGM"
# input_files = [os.path.join(input_directory, filename) for filename in os.listdir(input_directory)]
# output_filename = r".\TEST.AFS"

# pack_afs(input_files,output_filename)
