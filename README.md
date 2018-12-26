# arduino-low-programming-opcodes

Many people try to understand how avr microcontrollers working!
And many for them ... think to modify or create programs in low mode.
For this i create this page to explain that is not easy, is a complicated mode.
So...i have blinking led.c file.For title you know what make it.
This file is write in c avr asm... that is low language possible known by all programmers...
but yet is not very low!

The low language is opcode (click here for see table of opcodes), is impossible working in this mode! The microprocessor can read only this numbers... so ... for this in arduino is load a hex file, language that microprocessor understand!



First try to load a mini program in arduino with minimal components.
The popular program is avrdude .
You need download these files in your folder that use for your test.
When you upload a file to microcontroller (arduino nano has a atmega32 microcontroller) , you can use avrdude for example for upload, will begin write by adress 0.
But in microcontroller memory begin with interrupts, that mean is allocates adress for type of interrupts and after this begin the code.Any type of microcontrollers have divers interrupts.
 for example the 
-----------------------------------------------------
arduino pins
arduino grbl
Arduino nano

0x03 PINB
0x04 DDRB
0x05 PORTB
0x06 PINC
0x07 DDRC
0x08 PORTC
0x09 PIND
0x0A DDRD
0x0B PORTD

        PB5 led onboard 
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
https://github.com/Protoneer/grbl-master

Grbl v0.8  v0.9
D8   PB0   stepper enable/disable
D7   PD7  direction Z
D6   PD6   direction Y
D5   PD5   direction X
D4   PD4   step Z
D3   PD3   step Y
D2   PD2   step X

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
test.bat  create hex from asm

avra test.asm




test1.bat upload to microcontroller

mode com3 BAUD=9600 PARITY=n DATA=8  
avrdude -p m328p -b 57600 -P com3 -c arduino -U flash:w:test.hex 
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
test.asm

.device ATmega32

.equ PORTD = 0x0B
.equ DDRD  = 0x0A
.equ PORTB = 0x05
.equ DDRB  = 0x04

.org 0x0000
    jmp main
.org 0x0060

main:
;PD5 grbl direction pin

;ldi r24, 1 ;PB0 enable x
;out DDRB,r24
;out PORTB,r24


ldi r24, 0b100100 ;PD5 direction x and PD2 step x
out DDRD,r24
loop:
ldi r24, 0b100000 ; STEP (PD2) HIGH
out PORTD,r24

      ldi  r18, 2
    ldi  r19, 160
    ldi  r20, 147
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18


ldi r24, 0 ; STEP (PD2) LOW
out PORTD,r24


  ldi  r18, 2
    ldi  r19, 160
    ldi  r20, 147
L1x: dec  r20
    brne L1x
    dec  r19
    brne L1x
    dec  r18
rjmp loop
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
AVR Delay Loop Calculator
http://www.bretmulvey.com/avrdelay.html
------------------------------------------------------

PB5 ( D13 ) Led
Register
$4 DDRB
$5 PORTB

0000:
2FC0

00-$54 vector intrerupere
incepem cu $60

:$60

DDRB = 0xFF; //Nakes PORTC as Output
  8f ef       	ldi	r24, 0xFF	
  84 b9       	out	4, r24	 

	PORTB = 0xFF; //Turns ON All LEDs
  8f ef       	ldi	r24, 0xFF
  85 b9       	out	5, r24     
-----------------------------------------------

PORTB = 0; //Turns OFF All LEDs
  80 e0       	ldi	r24, 0    
  85 b9       	out	5, r24  

---------------------------------------------

<__stop_program>:
  ff cf       	rjmp	.-2 

avr assembler 
http://avra.sourceforge.net/README.html
de terminat 
link to google drive unde am salvat avrdude minimal
contiene avra.exe che compila asm:
https://drive.google.com/open?id=0BzDuTPB5XlKOMm1jM29wUk1EQWc
contiene avra.exe ma anche bin2hex e disavr
https://drive.google.com/open?id=0BzDuTPB5XlKOalVhMkI2VkQzWUE

http://www.atmel.com/images/doc1022.pdf

http://www.alberti-porro.gov.it/wordpress/wp-content/uploads/2014/01/ProgrammareArduino.pdf

http://blog.zakkemble.net/avr-gcc-builds/
