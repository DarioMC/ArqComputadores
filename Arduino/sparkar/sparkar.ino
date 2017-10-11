/*
    Sparkar C++

    (c) E. Adrian Garro Sanchez,
        Randy M. Morales Gamboa,
        Jason A. Barrantes Arce,
        David Vargas Rosales,
        Instituto Tecnológico de Costa Rica.

    Conexiones:
        - Motor izquierdo = 5 y 6   -> patas derechas del puente h = 3 y 6
        - Motor derecho   = 9 y 10  -> patas izquierdas del puente h = 3 y 6
        - LEDs            = 2 y 3   -> 2 (verde) y 3 (roja)
        - Ultrasonico     = 12 y 13 -> 12 trigger y 13 echo
 */

#include "Ultrasonic.h"

int izqA = 5;
int izqB = 6;
int derA = 9;
int derB = 10;
int max_speed = 255;
int red_light = 3;
int yellow_light = 2;

Ultrasonic ultrasonic(12, 13); // (Trig PIN, Echo PIN)

void setup()
{
    pinMode(derA, OUTPUT);
    pinMode(derB, OUTPUT);
    pinMode(izqA, OUTPUT);
    pinMode(izqB, OUTPUT);
    pinMode(red_light, OUTPUT);
    pinMode(yellow_light, OUTPUT);
}

void loop()
{
    if (ultrasonic.Ranging(CM) >= 20) {
        // turn off yellow led
        digitalWrite(yellow_light, LOW);
        // turn off reverse engines
        analogWrite(derA, 0);
        analogWrite(izqA, 0);
        // turn on red led
        digitalWrite(red_light, HIGH);
        // turn on engines
        analogWrite(derB, max_speed);
        analogWrite(izqB, max_speed);
    }
    else {
        // turn off red led
        digitalWrite(red_light, LOW);
        // turn off engines
        analogWrite(derB, 0);
        analogWrite(izqB, 0);
        // turn on yellow led
        digitalWrite(yellow_light, HIGH);
        // turn on reverse engines
        analogWrite(derA, max_speed);
        analogWrite(izqA, max_speed);
        delay(300);
        // go to left
        analogWrite(derA, max_speed);
        analogWrite(izqA, 0);
        delay(300);
        // go to right
        analogWrite(derA, 0);
        analogWrite(izqA, max_speed);
        delay(300);
    }
}

