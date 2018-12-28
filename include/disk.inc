

section .bss

BOOTDRIVE: resb 1

; Initial config

section .code

reset_device:
pusha
xor ax, ax ; Reset driver
int 13h
popa
ret

; Read sectors routine

load_shell:
mov bx, 0x7FFF
push bx

mov dl, [BOOTDRIVE]
call print_hex

mov ah, 02h
mov al, 0x1
mov ch, 0x0
mov cl, 0x3
mov dh, 0x0

call print_hex

int 13h

jc dsk_error

cmp al, 0x1
jne dsk_error

call reset_device
ret

load_sectkernel:
mov bx, 0x1000
push bx

mov ah, 02h
mov al, 0x1
mov ch, 0x0
mov cl, 0x4
mov dh, 0x0
mov dl, [BOOTDRIVE]

int 13h

jc dsk_error

cmp al, 0x1
jne dsk_error

call reset_device
ret

dsk_error:
mov ah, 0Ah
mov cx, 1
xor bx, bx
mov al, 'Q'
int 10h

cli
hlt

