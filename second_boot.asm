org 0x1000

start:
; Check 2nd bootloader loaded
mov si, loaded
call print_str

; Load kernel?

mov si, lkernel
call print_str

; Enter menu

call menu


cli
jmp $ ; Halt computer


%include "screen.asm"
%include "keyboard.asm"

loaded: db "Second bootloader has been loaded successfully...", 13, 0
lkernel: db "Load kernel? F1 - Yes. F2 - Remain 16 bit RM", 0
