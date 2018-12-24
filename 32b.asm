

load_kernel: ; Routine to load 32 bit mode with kernel
cli ; Clear BIOS interrupts
; Load GDT
lgdt [gdt_descriptor]
; Turn up first bit of CR0 register
mov eax, cr0
or eax, 0x1
mov cr0, eax

;; ===============================
;;
;;  JUMP TO 32-BIT PROTECTED MODE
;;
;; ===============================

jmp CODE_SEG:init_protected_mode







; 32-bit protected mode

BITS 32

init_protected_mode:
mov ax, DATA_SEG ; Point address segments to valid data segment
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

mov ebp, 0x90000 ; Update stack position ( On top of free space )
mov esp, ebp 

test_pm:
pusha
mov al, 'A'
mov ah, 0x0f

mov edx, 0xb8000

mov [edx], ax

hlt


; End of 32-bit protected mode











; GDT ( 2 segments : 1 code / 1 data ) 
; Intel's flat model

gdt_start: ; Start of GDT

gdt_null:
times 2 dd 0x0 ; Null reference

gdt_code: ; Code segment setup
; Base: 0x0 / Limit: 0xfffff
dw 0xffff ; Limit (bits 0-15)
dw 0x0 ; Base (bits 0-15)  2 bytes 16 bits
db 0x0 ; Base (bits 16-23) 1 byte 8 bits
; First flags: Present = 1 ; Privilege = 00 ; Descriptor type = 1 ----> 1001b
; Type flags: Code = 1 ; Conforming = 0 ; Readable = 1 ; Accesed = 0 ----> 1010b
db 10011010b ; First flags + Type flags
; Second flags: Granularity = 1 ; 32b default = 1 ; 64b segment = 0 ; AVL = 0 ----> 1100b
db 11001111b ; Second flags + Limit (16 - 19)
db 0x0 ; Base (bits 24 - 31)

gdt_data: ; Data segment setup
; Same as code segment except for the type flags
; Type flags: Code = 0 ; Expand down = 0 ; Writable = 1 ; Accessed = 0 ----> 0010b
dw 0xffff ; Limit (bits 0 - 15)
dw 0x0 ; Base (bits 0 - 15)
db 0x0 ; Base (bits 16 - 23)
db 10010010b ; First flags (same as code) + Type flags (new)
db 11001111b ; Second flags (same as code) + Limit (16 - 23bits) (same as code)
db 0x0 ; Base (bits 24 - 31)

gdt_end: ; End of GDT

gdt_descriptor: ; GDT descriptor
dw gdt_end - gdt_start - 1 ; Size of GDT (always 1 less than true size)
dd gdt_start ; Start address of GDT

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
