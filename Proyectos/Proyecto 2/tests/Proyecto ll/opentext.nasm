a 100
mov ah ,3d
mov al ,00
mov dx ,150
int 21
mov si ,ax
mov ah ,3f
mov bx ,si
mov cx ,A
mov dx ,200
int 21
mov ah ,09
mov dx ,200
int 21
int 20

a 150
db 'file.txt', 00
a 200
db 00,00,00,00,00,00,00,00,00,00,24
rcx
