org 0x8e00
 
; Main Loop

jmp mstart

mstart:

mov si, sloaded
call print_str

mloop: ; Main loop

xor cx, cx

mov si, nl
call print_str

mov si, cstart
call print_str

.read_input:
xor ax, ax
int 16h ; Read key AH = Keyboard scan code // AL = ASCII code

cmp ah, 0Eh
je .backspace

cmp ah, 1Ch
je execute_command

.print_c:
mov ah, 0Ah
push bx
xor bx, bx
mov bx, cmd
add bx, cx
mov [bx], al
mov [char], al
pop bx
mov si, char
call print_str
inc cx
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


; Execute command routine
execute_command:
pusha
mov si, cmd

.compare_command:
call print_str

jmp mloop


halt:
cli
hlt

%include "screen.asm"

sloaded: db "Shell loaded", 13, 0
nl: db "", 13, 0
cstart: db "$ ", 0

char: dw 0

cmd: db 0 ; CMD -> Address to first char of command
