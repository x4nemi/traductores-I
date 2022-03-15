.model small
.stack 100
.data
u db 0
d db 0
c db 0
n1 db 0
n2 db 0
suma db 0

msg db 10,13,17,'SUMA---------------','$'
msg1 db 10,13,17,'Ingrese un numero:','$'
msg2 db 10,13,17,'Ingrese otro numero:','$'
msg3 db 10,13,17,'Resultado:','$'

.code
mov ax,data
mov ds,ax

mov ah,09h
lea dx,msg
int 21h

mov ah,09h
lea dx,msg1   ;impresion mensaje1
int 21h
mov ah,01h
int 21h

sub al,30h   ;decenas
mov d,al
mov ah,01h
int 21h

sub al,30h   ;unidades
mov u,al
mov al,d
mov bl,10
mul bl
add al,u
mov n1,al


mov ax,data
mov ds,ax
mov ah,09h
lea dx,msg2   ;impresion mensaje2
int 21h

mov ah,01h
int 21h
sub al,30h
mov d,al
mov ah,01h
int 21h

sub al,30h
mov u,al
mov al,d
mov bl,10
mul bl
add al,u
mov n2,al

;Suma
mov al, n1
add al, n2
mov suma, al

mov ah,09h
lea dx,msg3
int 21h

mov al,suma
aam
mov u,al
mov al,ah
aam
mov c,ah
mov d,al


mov ah,02h
mov dl,c
add dl,30h
int 21h
mov dl,d
add dl,30h
int 21h
mov dl,u
add dl,30h
int 21h

;Termina programa
mov ah,04ch
int 21h
end

