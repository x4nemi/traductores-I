    .model small
    .data
    
    x db 40,38,32,23,12,0,-13,-24,-33,-39,-40,-39,-33,-24,-13,-1,12,23,32,38,40,38,32,23,12,0,-13,-24,-33,-39,-40
    y db 0,12,23,32,38,40,38,32,23,12,0,-13,-24,-33,-39,-40,-39,-33,-24,-13,-1,12,23,32,38,40,38,32,23,12,0
    
    cenx db 0
    ceny db 0

    color equ 1010b  

    i dw 0 

.code
                
pixel macro r,c    ;macro para mostrar pixel
    mov cl,r       ;x
    mov dl,c       ;y
    mov al,color
    mov ah,0Ch

    int 10h
endm 
         
config:   
    lea ax,data
    mov ds,ax

    mov ah,00
    mov al,13h
    int 10h

    mov ax, 0000h ; Restaura driver y lee estado
    INT 33h ; X = Estado
    ; 0000h hardware/driver no instalado
    ; FFFFh hardware/driver instalado
    ; BX = Numero de botones
    ; = 0000h Distinto de dos
    ; = 0002h Dos botones (muchos drivers)
    ; = 0003h Tres botones Sistemas/Logitech
    ; = FFFFh Dos botones
repite: 
    mov ax, 0003h ; Obtiene la posicion y el estado del puntero
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
    shr cl,1            ;cx = cx / 2
    pixel cl, dl        ;se dibuja el pixel seleccionado
     
    mov cenx,cl         ;centro constante
    mov ceny,dl
     
    mov i,0             ;inicializamos i = 0
    ciclo:     
        mov si, i       ;le pasamos el valor de i 
        
        mov al,x[si]    ;al = una parte del arreglo
        mov bl,y[si]    ;bl = una parte del arreglo
        
        add al,cenx     ;al = al + centrox 
        add bl,ceny     ;bl = bl + centroy
                
        pixel al,bl
        
        inc i           ;se incrementa i
        cmp i,20        ;compara si i == 20
        jnz ciclo       ;si no es, se repite ciclo
        
        
    

nada: 
    NOP

jmp repite  

ret