bits 32
;org 0x7fff
[extern kmain]

global _start

_start:

; Jump to kernel
call kmain

hlt
