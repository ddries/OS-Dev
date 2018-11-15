
; Reset device controller

reset_device:
xor ax, ax
int 13h
ret

; Read sectors routine

load_second_boot:
mov ax, 0x0
mov es, ax
mov bx, 0x1000 ; Real address 0x10000 ( 0x1000 << 4 = *16 (segment = 0x0))
	       ; ES:BX = 0x0:0x1000
push es
push bx

mov ah, 02h
mov al, 0x1
mov ch, 0x0
mov cl, 0x2
mov dh, 0x0
; DL is already set by BIOS

int 13h

cmp al, 0x1 ; Check sector read
jne $
ret
