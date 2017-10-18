//.include "RobotKit/RobotKit.h"

.extern pinMode
.extern analogWrite
.extern digitalWrite

.global setup
.global loop

setup:
  .equ  DDRB,   0x04
  .equ  PORTB,  0x05
  .equ  PORTD,  0x0B
  .equ  DDRD,   0x0A

  .equ LEFTDIR, 0x02
  .equ RIGHTDIR, 0x03
  .equ LEFTSPEED, 0x05
  .equ RIGHTSPEED, 0x06

  sbi DDRB, LEFTDIR
  sbi DDRB, RIGHTDIR
  sbi DDRD, LEFTSPEED
  sbi DDRD, RIGHTSPEED

  cbi PORTB, LEFTDIR
  cbi PORTB, RIGHTDIR

loop:
  cbi PORTB, LEFTDIR
  cbi PORTB, RIGHTDIR

  sbi DDRD, LEFTSPEED
  sbi DDRD, RIGHTSPEED
  

  
