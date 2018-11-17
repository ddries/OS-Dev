
; Reset device controller

reset_device:
xor ax, ax
int 13h
ret

; Read sectors routine

load_shell:
mov bx, 0x7DF6 ; Real address 0x7E000 - A = 0x7DF60
push bx

mov ah, 02h
mov al, 0x1
mov ch, 0x0
mov cl, 0x3
mov dh, 0x0
int 13h

jc dsk_error

cmp al, 0x1
jne dsk_error
ret

load_second_boot:
mov bx, 0x1000 ; Real address 0x10000 ( 0x1000 << 4 = *16 (segment = 0x0))
	       ; ES:BX = 0x0:0x1000
push bx

mov ah, 02h
mov al, 0x1
mov ch, 0x0
mov cl, 0x2
mov dh, 0x0
; DL is already set by BIOS

int 13h

cmp al, 0x1 ; Check sector read
jne dsk_error
ret

load_sector: ; 1st = ES, 2nd = BX, 3rd = AX, 4th = CX
pop cx ; Get sector number
pop ax ; Get sector to read number
pop bx ; get offset
pop es ; get segment

push ax ; save sector number
int 13h

jc $

pop cx ; get sector number
;and dx, 0Fh ; only DL (sector number)

cmp al, cl
jne $
push es
push bx
ret

dsk_error:
mov ah, 0Ah
mov cx, 1
xor bx, bx
mov al, 'L'
int 10h

jmp $
