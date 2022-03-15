org 100h
jmp start
msg1 db 13,10,13,10,"Letra a: ","$"
msg2 db 13,10,13,10,"Letra r: ","$"
frase db "El perro se comio mi tarea$"
char1 db "a"
char2 db "r"
n dw 0  ;indice en frase
i db 0  ;contador para a
j db 0  ;contador para r

printMSG MACRO msg
mov ah,09h
lea dx,msg
int 21h
endm

printNUM MACRO num
mov al,num
AAM
mov bx,ax
mov ah,02h
mov dl,bh
add dl,30h
int 21h ; imprime decena

mov ah,02h
mov dl,bl
add dl,30h
int 21h ; imprime unidad
endm

start:
printMSG frase
compara char1,char2,frase   ;compara la frase con letra "a"
jmp final



compara MACRO letra1,letra2,msg
ciclo:
mov si,n
mov al,msg[si]

cmp letra1,al
jz indiceI:

cmp letra2,al
jz indiceJ:

cmp frase[si],"$"
jz fin:

inc n
loop ciclo

indiceI:
inc i
inc n
jmp ciclo

indiceJ:
inc j
inc n
jmp ciclo

fin:
printMSG msg1
printNUM i
printMSG msg2
printNUM j
endm



final:
ret



; [SOURCE]: C:\emu8086\MySource\comparardosletras.asm
