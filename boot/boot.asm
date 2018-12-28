bits 16
org 0x7c00

; BPB ( USB Floppy disk emulation)

section .text

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
driveNum:          db    0 ; Address 0x7C24 = Offset 0x24 from origin
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

; Disk init

mov [driveNum], dl ; Store drive Num

pusha

call reset_disk ; Reset disk

; Video config
mov ah, 00h
mov al, 02h ; 80x25 16 bit color mode
int 10h

; Cursor config

mov ah, 00h
mov al, 02h
int 10h

mov ah, 02h
mov bh, 0x00
xor dx, dx
int 10h

popa

mov si, boot_loading_str
call print_str

mov si, second_boot_loading_str
call print_str

; Loading second stage bootloader into RAM

mov bx, 0x7e00 ; Second bootloader address

mov dl, [driveNum]
call print_hex

mov ah, 02h
mov al, 0x1
mov ch, 0x0
mov cl, 0x2
mov dh, 0x0

call print_hex

int 13h

jc disk_error

cmp al, 0x1
jne disk_error

; ===========================
;  JUMP TO SECOND BOOTLOADER
; ===========================

jmp bx ; Set by 'load_second_boot' (es:bx)

cli
hlt ; halt computer

reset_disk:
pusha
xor ax, ax ; Reset driver
int 13h
popa
ret

disk_error:
mov si, derror
call print_str

cli
hlt

%include "screen.inc"

; End of main code

section .data ; Data

boot_loading_str: db "Bootloader running.", 13, 0
second_boot_loading_str: db "Trying to load second stage bootloader...", 13, 0
derror: db "Error reading from disk...", 13, 0

section .bootsig start=0x7C00+510 ;times 510 - ($ - $$) db 0
dw 0xAA55
