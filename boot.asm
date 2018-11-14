bits 16

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
volumeLabel:       db    "NO NAME    "
fileSysType:       db    "FAT12   "

; System preparation
main:

cli
mov ax, 0x7C0
mov ds, ax ; Set up segmentation

mov bx, 0x8000
mov bp, bx ; Set up stack
mov sp, bp
mov ss, ax
sti

; Cursor config

mov ah, 00h
mov al, 02h
int 10h

mov ah, 02h
mov bh, 0x00
xor dx, dx
int 10h

; Video Mode config

mov ah, 00h
mov al, 02h
int 10h

; Main code

mov si, loading_str
call print_str

jmp $ ; halt computer

; End of main code

; Print routine

print_str:
pusha
mov ah, 0Ah
xor bx, bx
mov cx, 1

.print_ch:
mov al, [si]
cmp al, 0
je .end
cmp al, 13
je .nwln
int 10h
call .move_cursor
inc si
jmp .print_ch

.end:
popa
ret

.move_cursor:
pusha
mov ah, 03h ; Read cursor position
xor bx, bx
int 10h

mov ah, 02h ; Move cursor
xor bx, bx
inc dl

int 10h

popa
ret

.nwln:
pusha
mov ah, 03h
xor bx, bx
int 10h

mov ah, 02h
xor bx, bx
inc dh
mov dl, 0x0
int 10h
popa 
ret

; Data

loading_str: db "Bootloader running.", 13, 0

times 510 - ($ - $$) db 0
dw 0xAA55
