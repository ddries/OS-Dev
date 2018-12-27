
; Video mode config

video_mode_config:
pusha
mov ah, 00h
mov al, 02h ; 80x25 16 bit color mode
int 10h
popa
ret

; Cursor config

cursor_config:
pusha
mov ah, 00h
mov al, 02h
int 10h

mov ah, 02h
mov bh, 0x00
xor dx, dx
int 10h
popa
ret

; Print string routine

print_str:
pusha
mov ah, 0Ah
xor bx, bx
mov cx, 1

.print_ch:
mov al, [si]
cmp al, 0
je .end
cmp al, 13
je .nwln
int 10h
call .move_cursor
inc si
jmp .print_ch

.end:
popa
ret

.move_cursor:
pusha
mov ah, 03h ; Read cursor position
xor bx, bx
int 10h

mov ah, 02h ; Move cursor
xor bx, bx
inc dl

int 10h

popa
ret

.nwln:
pusha
mov ah, 03h
xor bx, bx ; Get cursor
int 10h

mov ah, 02h
xor bx, bx
inc dh
mov dl, 0x0 ; New line
int 10h
popa
inc si
jmp .print_ch


; Prints the value of DX as hex.
print_hex:
  pusha             ; save the register values to the stack for later

  mov cx,4          ; Start the counter: we want to print 4 characters
                    ; 4 bits per char, so we're printing a total of 16 bits

char_loop:
  dec cx            ; Decrement the counter

  mov ax,dx         ; copy bx into ax so we can mask it for the last chars
  shr dx,4          ; shift bx 4 bits to the right
  and ax,0xf        ; mask ah to get the last 4 bits

  mov bx, HEX_OUT   ; set bx to the memory address of our string
  add bx, 2         ; skip the '0x'
  add bx, cx        ; add the current counter to the address

  cmp ax,0xa        ; Check to see if it's a letter or number
  jl set_letter     ; If it's a number, go straight to setting the value
  add al, 0x27      ; If it's a letter, add 0x27, and plus 0x30 down below
                    ; ASCII letters start 0x61 for "a" characters after 
                    ; decimal numbers. We need to cover that distance. 
  jl set_letter

set_letter:
  add al, 0x30      ; For and ASCII number, add 0x30
  mov byte [bx],al  ; Add the value of the byte to the char at bx

  cmp cx,0          ; check the counter, compare with 0
  je print_hex_done ; if the counter is 0, finish
  jmp char_loop     ; otherwise, loop again

print_hex_done:
  mov bx, HEX_OUT   ; print the string pointed to by bx
  call print_string

  popa              ; pop the initial register values back from the stack
  ret               ; return the function

print_string:     ; Push registers onto the stack
  pusha

string_loop:
  mov al, [bx]    ; Set al to the value at bx
  cmp al, 0       ; Compare the value in al to 0 (check for null terminator)
  jne print_char  ; If it's not null, print the character at al
                  ; Otherwise the string is done, and the function is ending
  popa            ; Pop all the registers back onto the stack
  ret             ; return execution to where we were

print_char:
  mov ah, 0x0e    ; Linefeed printing
  int 0x10        ; Print character
  add bx, 1       ; Shift bx to the next character
  jmp string_loop ; go back to the beginning of our loop

HEX_OUT: db '0x0000', 0
