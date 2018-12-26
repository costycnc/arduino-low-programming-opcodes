.device ATmega32

.equ PORTB = 0x05
.equ DDRB  = 0x04

.org 0x0000
    jmp main
.org 0x0060

main:

ldi r24, 255
out ddrb,r24
out portb,r24
loop:
rjmp loop

