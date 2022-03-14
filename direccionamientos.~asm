.model small
.data

seno dw 127h, 167h, 202h, 231h, 248h, 253h, 246h, 226h, 296h, 159h, 119h, 79h
;0     1     2     3     4     5     6     7     8     9     10    11    12
.code
mov ax,@data    ;inicializar los datos del arreglo
mov ds,ax

mov bx,[4]
mov cx,bx       ;direccionamiento de registro

xor cx,cx       ;limpiamos registros
xor bx,bx

mov bx,0127h    ;direccionamiento inmediato

xor bx,bx

mov si,5
mov bx,[8]      ;direccionamiento directo

xor bx,bx
xor si,si

mov bx,5
mov ax,[bx]     ;direccionamiento indirecto por registro

xor bx,cx
xor ax,ax

mov si,5
mov bx,5
mov ax,[bx+si]  ;direccionamiento de base mas indice

xor ax,ax
xor bx,bx
xor si,si

mov si,6
mov ax,seno[si]  ;direccionamiento de base relativa mas indice
;ax = onda[3] porque es de dw
xor ax,ax
xor si,si

mov ax,0127h
mov bx,0100h
mov si,2
mov (BX+1*SI),ax ;direccionamiento de indice escalado

ret



; [SOURCE]: C:\emu8086\MySource\coso.asm
