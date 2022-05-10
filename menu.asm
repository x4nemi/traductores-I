;Menú con tres cifras

    org 100h
    jmp start
    
    opc db "Dame un numero: ", "$$"
    
    opc1 db "1. Calcular el doble de un numero entero.", "$$$"    
    opc2 db "2. Calcular la mitad de un numero entero.", "$$$"
    opc3 db "3. Calcular el cuadrado de un numero entero.", "$$$"
    opc4 db "4. Salir.", "$$$"
    
    otra db "Opcion incorrecta", "$$"
    
    bye db "Has salido", "$$"
    
    salto db 13, 10, "", "$$$$$"  
    resultado db "Resultado: ", "$$"
    
    var db 0    
    
    u db 0
    d db 0
    c db 0
    vardec db 0
    varuni db 0
    
    opcion db 0

printMSG MACRO msg  
    mov ah,09h
    lea dx,msg
    int 21h       
endm

printNUM MACRO num 
    mov al,num                                         
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
endm   

pedirNUM MACRO num
    mov ah, 01h
    int 21h    
    sub al, 30h
    mov d, al
    
     
    mov ah, 01h
    int 21h 
    sub al, 30h  
    mov u, al
    
    mov al,d
    mov bl,10
    mul bl
    add al,u
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
    mov ah, 01h
    int 21h  
    mov opcion, al 
    printMSG salto
    printMSG salto
    
    cmp opcion, 52
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
    add al, al
    
    mov var, al 
               
    printMSG resultado
    printNUM var
    
    jmp start

opcion2:
    printMSG opc
    pedirNUM var 
    
    printMSG salto
    
    mov al, var
    
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
    mov bl, al
    mul bl
    mov var, al 
    
    printMSG resultado
    printNUM var
    jmp start  

salir:
    printMSG bye
    ret
