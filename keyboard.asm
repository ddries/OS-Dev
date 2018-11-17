
; Menu

menu:
pusha
xor ax, ax 
int 16h ; Read keyboard

cmp ah, 3Bh ; F1
je .load_kernel

cmp ah, 3Ch ; F2
je .load_shell

popa
ret

.load_kernel:
jmp $

.load_shell:
call reset_device
call load_shell

pop bx
jmp bx ; Jump to shell


%include "disk.asm"



