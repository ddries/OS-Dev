bits 32
;org 0x7fff

[extern kmain]

; Jump to kernel
call kmain

hlt
