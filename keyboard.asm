
; Menu

menu:
pusha
xor ax, ax 
int 16h ; Read keyboard

cmp ah, 3Bh ; F1
je .ld_kernel ; load_kernel routine is defined in external file "32b.asm"

cmp ah, 3Ch ; F2
je .load_shell

popa
ret

.load_shell:
call reset_device
call load_shell

pop bx
jmp bx ; Jump to shell

.ld_kernel:
call video_mode_config  ; Clear screen by reseting video mode configuration
jmp load_kernel ; Jump to kernel

%include "disk.asm"
%include "32b.asm"


