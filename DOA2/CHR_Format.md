# Dead or Alive 2 (Dreamcast) .CHR archive

DOA2 use `.CHR` archives to store model and partial PVR header data. Actual image data is located in the corresponding `.BIN` file.

# Header data

|Address	|Length|	Description|
|---------|------------|---------------|
|0x00	|0x04|	HEADER SIZE|
|0x00	|0x18|	HEADER DATA|
|0x04	|0x04|	TEXTURE POINTERS|
|0x08	|0x04|	MODEL POINTERS|
|0x0C	|0x04|	TOTAL MODELS|
|0x10	|0x04|	TOTAL TEXTURES|
|0x14	|0x04|	PADDING|


# Model pointers

|Address	|Length (hex)|	Description|
|---------|------------|---------------|
|0x00	|0x04|	SPECIFIED OFFSET - BASE ADDRESS `+0x18`|

* Please note base address is always the first model pointer.
i.e.
First pointer value is `0x0000400C` , the real address is calculated:
(`0x0000400C - 0x0000400C`) + `0x18`

# Texture pointers

They refer to a corresponding .BIN file, which is an headerless PVR data archive.
Each texture header is split in 3 chunks 0x4 bytes long each:

|Address	|Length|	Description|
|---------|------------|---------------|
|0x00|	0x04| PVR Image size |
|0x04|	0x04| PVR Pixel type |
|0x08|	0x04| SPECIFIED OFFSET - BASE ADDRESS|

* Please note base address is always the first texture pointer
i.e.
First pointer value is `0x0000400C` , the real address is calculated:
`0x0000400C - 0x0000400C`
