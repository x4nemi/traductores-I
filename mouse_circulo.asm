    org 100h   
    jmp config    

    x dw 20,19,18,15,13,10,6,4,1,0,0,0,1,4,6,10,13,15,18,19,20,19,18,15,13,10,6,4,1,0,0
    y dw 10,13,15,18,19,20,19,18,15,13,10,6,4,1,0,0,0,1,4,6,10,13,15,18,19,20,19,18,15,13,10
            
    circx dw 0
    circy dw 0   

    cenx dw 0
    ceny dw 0

    color equ 1010b  

    i dw 0
                
    pixel macro r,c             ;macro para mostrar pixel
        mov cx,r
        mov dx,c
        mov al,color
        mov ah,0Ch

        int 10h
    endm            
            
config:
    mov ah,00
    mov al,12h
    int 10h

inicio:
    mov ax, 0000h ; Restaura driver y lee estado
    INT 33h ; X = Estado
    ; 0000h hardware/driver no instalado
    ; FFFFh hardware/driver instalado
    ; BX = Numero de botones
    ; = 0000h Distinto de dos
    ; = 0002h Dos botones (muchos drivers)
    ; = 0003h Tres botones Sistemas/Logitech
    ; = FFFFh Dos botones
    repite: mov ax, 0003h ; Obtiene la posicion y el estado del puntero
    INT 33h ; BX = Estado del ratón
    ; Bit Descripcion
    ; 0 Boton izquierdo pulsado si 1
    ; 1 Boton derecho pulsado si 1
    ; 2 Boton central pulsado si 1
    ; CX Columna
    ; DX Fila    
    cmp bx, 0 
    
    jne grafico:  ; si es bx es 1, se grafica
    jz nada:      ; si no, no se grafica nada
    

grafico:   
    shr cx,1
    pixel cx, dx
    
    ciclo:     
        mov si, i        
        mov circx, cx
        mov circy, dx 
        
        mov ax,x[si]
        
        mov bx,y[si]
        
        sub circx,ax
        sub circy,bx
        pixel circx,circy
        inc i   
        cmp i,20
        jnz ciclo
        
    

nada: 
    NOP

jmp repite  

ret