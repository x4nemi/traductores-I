;Programa que tiene menú, doble, mitad y el cuadrado de un número

    org 100h
    jmp start
    
    opc db "Dame un numero: ", "$$"
    
    opc1 db "1. Calcular el doble de un número entero.", "$$$"    
    opc2 db "2. Calcular la mitad de un número entero.", "$$$"
    opc3 db "3. Calcular el cuadrado de un número entero.", "$$$"
    opc4 db "4. Salir.", "$$$"
    
    otra db "Opcion incorrecta", "$$"
    
    bye db "Has salido", "$$"
    
    salto db 13, 10, "", "$$$$$"  
    resultado db "Resultado: ", "$$"
    
    ;Opcion 1
    var db 0  
    
    opcion db 0

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

pedirNUM MACRO num
    mov ah, 01h
    int 21h
    mov num, al
endm

menu MACRO
    printMSG opc1 
    printMSG salto
    printMSG opc2 
    printMSG salto
    printMSG opc3 
    printMSG salto
    printMSG opc4
    printMSG salto 
    printMSG opc
    
endm

start:  
    printMSG salto  
    printMSG salto
    menu
    pedirNUM opcion 
    printMSG salto
    printMSG salto
    
    cmp opcion, 48
    je salir
    
    cmp opcion,49
    je opcion1   
    
    cmp opcion,50
    je opcion2  
    
    cmp opcion, 51
    je opcion3
    
    
otraOpcion:
    printMSG otra
    jmp start

opcion1:
    printMSG opc
    pedirNUM var
    
    printMSG salto
    
    mov al, var 
    sub al, 30h 
    mov cl, 2
    
    mul cl
    
    mov var, al 
               
    printMSG resultado
    printNUM var
    
    jmp start

opcion2:
    printMSG opc
    pedirNUM var 
    
    printMSG salto
    
    mov al, var
    sub al,30h
    
    shr al,1
        
    mov var, al 
    
    printMSG resultado
    printNUM var
    jmp start   
    
opcion3:
    printMSG opc
    pedirNUM var
    
    printMSG salto
    
    mov al, var
    sub al,30h
    mul al
    mov var, al 
    
    printMSG resultado
    printNUM al
    jmp start  

salir:
    printMSG bye
    ret
