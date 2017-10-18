/* 
    Sparkar asm
    
    (c) E. Adrian Garro Sanchez,
        Randy M. Morales Gamboa,
        Jason A. Barrantes Arce,
        David Vargas Rosales,
        Instituto Tecnológico de Costa Rica.

    Conexiones:
        - Motor izquierdo = 5 y 6   -> patas derechas del puente h = 3 y 6
        - Motor derecho   = 9 y 10  -> patas izquierdas del puente h = 3 y 6
        - Luces (leds)    = 2 y 3   -> 2 (verde) y 3 (roja)
        - Ultrasonico     = 12 y 13 -> 12 trigger y 13 echo
 */

.extern pinMode
.extern analogWrite

.global loop
.global setup

setup:
    // pinMode(derB, OUTPUT)
    lds r24, 0x0106
    ldi r22, 0x01
    call pinMode
    // pinMode(izqA, OUTPUT)
    lds r24, 0x0100
    ldi r22, 0x01
    call pinMode
    // pinMode(izqB, OUTPUT)
    lds r24, 0x0102
    ldi r22, 0x01
    call pinMode
    // pinMode(derA, OUTPUT)
    lds r24, 0x0104
    ldi r22, 0x01
    call pinMode
loop:
    // Turn on engines analogWrite(pins, input, vel)
    lds r24, 0x0100
    ldi r22, 0x00
    ldi r23, 0x00
    call analogWrite
