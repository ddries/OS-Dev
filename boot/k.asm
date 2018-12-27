BITS 32
ORG 0x1000

VIDEO_MEM equ 0xb8000
ATRIB equ 0x0f

mov ax, 0x10 ; Update segment pointers
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

mov ebp, 0x90000 ; Update stack position
mov esp, ebp

mov edx, VIDEO_MEM
mov al, 'A'
mov ah, ATRIB

mov [edx], ax

hlt
