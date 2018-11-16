org 0x1000

start:
; Check 2nd bootloader loaded
mov si, loaded
call print_str

; Load kernel?

mov si, lkernel
call print_str

call menu ; Enter menu

cli
jmp $ ; Halt computer


%include "screen.asm"
%include "keyboard.asm"

loaded: db "Second bootloader has been loaded successfully. (0x0:0x1000)", 13, 0
lkernel: db "F1 - Load 32-bit Kernel.", 13, "F2 - 16-bit Shell.", 13, 0
