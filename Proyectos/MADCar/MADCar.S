.extern analogWrite

.global setup
.global loop

setup:
  .equ  PORTA,  0x1B
  .equ  DDRA,   0x1A
  .equ  PINA,   0x19
  .equ  PORTB,  0x18
  .equ  DDRB,   0x17
  .equ  PINB,   0x16
  .equ  PORTD,  0x12
  .equ  DDRD,   0x11
  .equ  PIND,   0x10

  sbi DDRB, 2 ;LEFTDIR
  sbi DDRB, 3 ;RIGHTDIR

  sbi DDRD, 5 ;LEFTSPEED
  sbi DDRD, 6 ;RIGHTSPEED

  cbi PORTB, 2
  cbi PORTB, 3
  
  ret

loop:
    cbi PORTB, 2
    cbi PORTB, 3
  ret
