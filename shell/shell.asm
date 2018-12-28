org 0x8e00
 
; Main Loop

jmp mstart

mstart:

mov si, sloaded
call print_str

mov si, nl
call print_str

mloop:

.read_input:
xor ax, ax
int 16h ; Read key

cmp ah, 0Eh
je .backspace

.print_c:
mov ah, 0Ah
mov [char], al ; Get char
mov si, char
call print_str
jmp .read_input

.backspace:
pusha
mov ah, 03h ; Get cursor position
xor bx, bx
int 10h

mov ah, 02h
dec dl ; Move cursor
int 10h

mov ah, 0Ah
mov al, '' ; Remove last character
mov cx, 1
int 10h

jmp .read_input ; Next key press

cli
jmp $

%include "screen.inc"

sloaded: db "Shell loaded", 13, 0
nl: db "", 13, 0
cstart: db "$ ", 0

char:
