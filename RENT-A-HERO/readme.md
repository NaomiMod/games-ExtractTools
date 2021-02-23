#  .SNR SCENARIO Text format struct

SNR is the text format used by Rent-a-Hero No.1 for Dreamcast, `TEXT DATA` are text sentences composed by chars (uint short).
`PARAMETER DATA` is a list of floats for positioning chars / camera location on each scene.

*Please note (+ `0x40`) is a relative value to add in order to get actual offset!

|Address|Length (hex)|Description|
|-------|------------|-----------|
|0x00|	08|	MAGIC HEADER: `x53/x43/x45/x4E/x41/x52/x49/x4F`|         
|0x08|	04|	TEXT DATA / END OFFSET (+ `0x40`)|
|0x0C|	04|	PARAMETER DATA SIZE| 
|0x10|	04|	TEXT SENTENCES TOTAL NUMBER|
|0x14|	04|	PARAMETER TOTAL ENTRIES|
|0x18|	04|	UNK|
|0x1C|	04|	UNK|
|0x20|	04|	UNK|
|0x24|	04|	PARAMETER DATA / START OFFSET (+ 0x40`)|
|0x28|	04|	TEXT_POINTERS / START OFFSET (+ `0x40`)|
|0x2C|	04|	UNK|
|0x30|	04|	UNK|
|0x34|	04|	UNK|
|0x38|	08|	HEADER END: `xFF/xFF/xFF/xFF/xFF/xFF/xFF/xFF` |




