
; Menu

menu:
xor ax, ax 
int 16h ; Read keyboard

cmp ah, 3Bh ; F1
je .ld_kernel

cmp ah, 3Ch ; F2
je .load_shell

.load_shell:
call load_shell

jmp bx ; Jump to shell

cli
hlt

.ld_kernel:
;call video_mode_config  ; Clear screen by reseting video mode configuration
jmp load_kernel ; Jump to kernel

hlt

%include "disk.inc"
%include "32b.asm"


