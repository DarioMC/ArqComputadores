 ************************************************
 * Blink LED Arduino Uno
 ************************************************
 * Autores:
 *    Elberth Adrian Garro Sanchez (2014088081)
 *    Randy Mauricio Morales Gamboa (2015085446)
 *    Jason Andres Barrantes Arce (2015048456)
 *    David Vargas Rosales (2015128043)
 ************************************************
 * Copyright 2016 TEC
 ************************************************
 */
 

/*
 **************************************************
 * Pines:
 *    Pin D (digital), posiciones de 0 a 7
 *    Pin C (analogico)
 *    Pin B (digital), posiciones de 8 a 13 (0 a 5)
 **************************************************
 * Registros:
 *    DDRX, inicializa pines I/O
 *    PINX, recibe información de un pin
 *    PORTX, envia información a un pin
 * Nota:
 *    Los registros desde r0 a r15 son reservados 
 *    del Arduino y poseen un valor de 255.
 **************************************************
 */

.global setup
.global loop

setup:
  /* constantes simbolicas */
  .equ PORTD, 0x0b
  .equ DDRD,  0x0a
  .equ PIND,  0x09
  .equ PORTC, 0x08
  .equ DDRC,  0x07
  .equ PINC,  0x06
  .equ PORTB, 0x05
  .equ DDRB,  0x04
  .equ PINB,  0x03
  
  sbi DDRB, 5  /* permite inicializar el pin 13 */
  ret

loop:
  /* enciende LED */
  sbi PORTB, 5  /* activar pin 13 */
  ldi r16, 100  /* carga imediato 100 a registro 16 */
  rcall delay   /* llama al delay */
  /* apaga LED */
  cbi PORTB, 5  /* desactivar pin */
  ldi r16, 100  /* carga imediato 100 a registro 16 */
  rcall delay   /* llama al delay */

delay:
  /* ciclo de operaciones para realizar un retardo */
  dec r8      /* decrementa r8 */
  brne delay  /* salte a delay si r8 != 0 */
  dec r9      /* decrementa r9 */
  brne delay  /* salte a delay si r9 != 0 */
  dec r16     /* decrementa r16 */
  brne delay  /* salte a delay si r16 != 0 */
  ret
