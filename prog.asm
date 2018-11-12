[bits 16]
[org 0x7c00]

call start

mov si, hello_str
call print_str

call read_key ; wait for user input (" MENU ")

jmp $ ; Halt computer

; Initial config

start:
xor bx, bx
mov ds, bx ; Neutralize data segment
mov es, bx

mov bx, 0x8000 ; Setup stack
mov ss, bx
mov sp, bx
ret

; PRINT_STR ROUTINE

print_str:
pusha
mov ah, 0Eh
xor bx, bx

.print_ch:
mov al, [si]
cmp al, 0
jz .end
int 10h
inc si
jmp .print_ch

.end:
popa
ret

; END OF PRINT_STR ROUTINE


; READ_KEY ROUTINE

read_key:
pusha
xor ax, ax ; mov ah, 0x0 / mov al, 0x0
int 16h
cmp ah, 3Bh
je reboot
cmp ah, 3Ch
je .sys_info
cmp ah, 3Dh
je .help
cmp ah, 3Eh
je .cursor_game

.default:
mov si, key_default
call print_str
jmp read_key

.sys_info:
mov si, info
call print_str
jmp read_key

.help:
mov si, key_info
call print_str
jmp read_key

.cursor_game:
xor ax, ax
int 16h
cmp ah, 4Bh
je .left
cmp ah, 4Dh
je .right
cmp ah, 48h
je .up
cmp ah, 50h
je .down
jmp read_key

.left:
mov ah, 03h
mov bx, 0
int 10h
dec dl
mov ah, 02h
int 10h
jmp .cursor_game

.right:
mov ah, 03h
mov bx, 0
int 10h
inc dl
mov ah, 02h
int 10h
jmp .cursor_game

.up:
mov ah, 03h
mov bx, 0
int 10h
dec dh
mov ah, 02h
int 10h
jmp .cursor_game

.down:
mov ah, 03h
mov bx, 0
int 10h
inc dh
mov ah, 02h
int 10h
jmp .cursor_game

; END OF READ_KEY ROUTINE


; REBOOT ROUTINE

reboot:
db 0x0ea
dw 0x0000
dw 0xffff

; END OF REBOOT ROUTINE


; DATA

hello_str: db `$ Programa iniciado\n\r`, 0
key_default: db `$ Tecla no reconocida\n\r`, 0
info: db "$ Este programa esta siendo desarrollado por Adrian Escalona / 16 bits RM / Version: 0.0.1", 13, 10, 0
key_info: db `$ F1 -> Reiniciar ordenador\n\r$ F2 -> Informacion del programa\n\r$ F3 -> Ayuda\n\r$ F4 -> Juego cursor`, 13, 10, 0
shell_symb: db "% ", 0

times 510-($-$$) db 0
dw 0xaa55
