org 0x7E00
bits 16

start:
; Check 2nd bootloader loaded
mov si, loaded
call print_str

; Load kernel?

mov si, lkernel
call print_str

menu: ; Menu
xor ax, ax 
int 16h ; Read keyboard

cmp ah, 3Bh ; F1
je load_kernel

cmp ah, 3Ch ; F2
je .load_shell

.load_shell:
mov bx, 0x8e00

mov ah, 02h
mov al, 0x1
mov ch, 0x0
mov cl, 0x3
mov dh, 0x0
mov dl, [0x7C24]

int 13h

jc dsk_error

cmp al, 0x1
jne dsk_error

xor ax, ax ; Reset driver
int 13h

jmp bx ; Jump to shell

cli
hlt

dsk_error:
mov ah, 0Ah
mov cx, 1
xor bx, bx
mov al, 'Q'
int 10h

cli
hlt

%include "screen.asm"
%include "32b.asm"

loaded: db "Second bootloader has been loaded successfully.", 13, 0
lkernel: db "F1 - Load 32-bit Kernel.", 13, "F2 - 16-bit Shell.", 13, 0
