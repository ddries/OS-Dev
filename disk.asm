
; Read sectors routine

load_second_boot:
mov ax, 0x0
mov es, ax
mov bx, 0x1000 ; Real address 0x10000 ( 0x1000 << 4 = *16 (segment = 0x0))
	       ; ES:BX = 0x0:0x1000

mov ah, 02h
mov al, 0x1
mov ch, 0x0
mov cl, 0x2
mov dh, 0x0
; DL is already set by BIOS

int 13h
ret
