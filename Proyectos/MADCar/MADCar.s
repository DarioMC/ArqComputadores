; DDRB       = 0x04
; PORTB      = 0x05
; TCCROB     = 0x25
; TCNT0      = 0x26
; 0b00000000 = OFF
; 0b00100000 = ON

setup:
    ldi r16, 0b00100000     ; Set r16 to LED ON value
    out 0x04, r16           ; Set DDRB to output
    out 0x05, r16           ; Set PORTB to ON
    ldi r16, 0b00000101     ; Set r16 with prescaler 1024 value
    out 0x25, r16           ; Set the TCCROB to 1024
    ldi r20, 0              ; Reset r20
    ldi r21, 1              ; Hold value 1 to increment r20
loop:
    in r17, 0x26            ; Read the timer 
    cpi r17, 128            ; Check to see if the timer is halfway done (1/2 second, max 255 value)
    brbc 0, increment       ; If r17 <= 128 (max 255 val before resets to 0), invert current LED state
    rjmp loop
increment:
    adc r20, r21            ; Add r21 (1) to r20 (with carry)
    brbs 0, reset           ; If the carry branch is set, reset the register
    rjmp loop               ; Otherwise, run the clock
reset:
    ldi r20, 0              ; Reset the delay register
    cpi r16, 0b00000000     ; Check if r16 is set to LED OFF
    brbs 1, switchon        ; If it is, change it to ON
    ldi r16, 0b00000000     ; Otherwise, change it to OFF
    out 0x05, r16           ; Set the LED to the new state
    rjmp loop               ; Run the clock
switchon:
    ldi r16, 0b00100000     ; Set r16 to LED ON value
    out 0x05, r16           ; Set the LED to the new state
    rjmp loop               ; Run the clock
