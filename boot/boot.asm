bits 16
org 0x7c00

; BPB ( USB Floppy disk emulation)

boot:
jmp main
TIMES 3 - ($ - $$) db 0x90 ; Support 2 or 3 byte encoded JMPs before BPB

; DOS 4.0 EBPB 1.44MB floppy

OEMname:           db 	 "mkfs.fat"
bytesPerSector:    dw 	 512
sectPerCluster:    db 	 1
reservedSectors:   dw    1
numFAT:            db    2
numRootDirEntries: dw    224
numSectors:        dw    2880
mediaType:         db    0xf0
numFATsectors:     dw    9
sectorsPerTrack:   dw    18
numHeads:          dw    2
numHiddenSectors:  dd    0
numSectorsHuge:    dd    0
driveNum:          db    0
reserved:          db    0
signature:         db    0x29
volumeID:          dd    0x2d7e5a1a
volumeLabel:       db    "DRIES OS    "
fileSysType:       db    "FAT12   "

; System preparation
main:

cli
xor ax, ax
mov ss, ax ; Set stack start at 0x0000:0x8000
mov ds, ax ; Neutralize data segment
mov es, ax

mov bx, 0x9000
mov bp, bx ; Set up stack
mov sp, bp
sti

; Main code

call disk_init ; Setup disk

call video_mode_config ; Video Mode configuration
call cursor_config ; Cursor configuration

mov si, boot_loading_str
call print_str

mov si, second_boot_loading_str
call print_str

; Loading second stage bootloader into RAM
call load_second_boot

; ===========================
;  JUMP TO SECOND BOOTLOADER
; ===========================

pop bx
jmp bx ; Set by 'load_second_boot' (es:bx)

cli
hlt ; halt computer

; End of main code

%include "disk.asm"   ; Disk related routines
%include "screen.asm" ; Screen-related routines

disk_error:
mov si, derror
call print_str

; Data

boot_loading_str: db "Bootloader running.", 13, 0
second_boot_loading_str: db "Trying to load second stage bootloader...", 13, 0
derror: db "Error reading from disk...", 13, 0

times 510 - ($ - $$) db 0
dw 0xAA55
