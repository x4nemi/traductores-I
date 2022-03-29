    .model small
    .data
    
    x db 80,78,72,63,52,40,27,16,7,1,0,1,7,16,27,40,52,63,72,78,80,78,72,63,52,40,27,16,7,1,0
    y db 40,52,63,72,78,80,78,72,63,52,40,27,16,7,1,0,1,7,16,27,40,52,63,72,78,80,78,72,63,52,40
    cenx db 0
    ceny db 0

    color equ 1010b  

    i dw 0 

.code
                
pixel macro r,c             ;macro para mostrar pixel
    mov cl,r
    mov dl,c
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
    ;pixel cl, dl        ;se dibuja el pixel seleccionado
    
    mov al,1010b
    mov ah,0ch
    int 10h
     
    mov cenx,cl         ;centro constante
    mov ceny,dl
     
    mov i,0
    ciclo:     
        mov si, i       ;le pasamos el valor de i 
        ;mov circx, cx   ;constante = x
        ;mov circy, dx   ;constante = y
        
        mov al,x[si]    ;al = una parte del arreglo
        mov bl,y[si]    ;bl = una parte del arreglo
        
        add al,cenx     ;al = al - centrox 
        sub bl,ceny     ;bl = bl - centroy
        
        
        
        
        mov cl,al       ;cl = al (x)
        mov dl,bl       ;dl = bl (y) 
        
        
        mov al,color    ;color
        mov ah,0ch      
        int 10h         ;se dibuja cx y dx
        
        inc i           ;se incrementa i
        cmp i,20        ;compara si i == 20
        jnz ciclo       ;si no es, se repite ciclo
        
        
    

nada: 
    NOP

jmp repite  

ret