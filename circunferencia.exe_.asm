.model small
.data
x db 160,156,144,127,104,80,55,32,15,3,0,3,15,32,55,80,104,127,144,156,160,156,144,127,104,80,55,32,15,3,0
y db 80,104,127,144,156,160,156,144,127,104,80,55,32,15,3,0,3,15,32,55,80,104,127,144,156,160,156,144,127,104,80

color equ 15

.code

inicio:
lea ax,data
mov ds,ax

mov ah,0
mov al,12h
int 10h

mov bx,0

pixel macro x,y             ;macro para mostrar pixel
mov cl,x
mov dl,y
mov al,color
mov ah,0Ch

int 10h
endm

grafico:
pixel x[bx],y[bx]
inc bx                  ;se incrementa el indice
cmp bx,20               ;comparo hasta que bx sea 80
jnz grafico

fin:
mov ah,4Ch
int 21h

ret







; [SOURCE]: C:\Users\ximgv\Downloads\circunferencia.asm
