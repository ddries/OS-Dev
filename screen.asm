
; Video mode

video_mode_config:
pusha
mov ah, 00h
mov al, 02h ; 80x25 16 bit color mode
int 10h
popa
ret

; Cursor config

cursor_config:
pusha
mov ah, 00h
mov al, 02h
int 10h

mov ah, 02h
mov bh, 0x00
xor dx, dx
int 10h
popa
ret

; Print string routine

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
