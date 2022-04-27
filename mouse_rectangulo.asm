; Programa: haces click en la consola y se dibuja
; un rectángulo alrededor. 

; Programa: haces click en la consola y se dibuja
; un rectángulo alrededor. 

    .model small
    .data
    
    cenx db 0
    ceny db 0   
    
    linX db 0
    linY db 0    
    
    altura db 10
    ancho db 20

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

; LÍNEA HORIZONTAL 
                    ;recibe el centro
horizontal macro r, c ;se mueve en x de iz a der
    LOCAL ciclo
    mov i, 0   
    
    mov linX, r
    
    ciclo:        
        pixel linX, c
        
        add linX,4
        inc i            
        
        cmp i, 11   ;se repetira diez veces
                    ;o sea, ancho = 40
        jnz ciclo 
    ;pixel al, bl     
        
endm   
       
; LÍNEA VERTICAL      
vertical macro r, c ;se mueve en y arriba abajo
    LOCAL linea
    mov i, 0
    mov linY, c
    
    linea:   
        add linY, 5   ;se mueve en el eje y         
        pixel r, linY ;eje x se queda constante
         
        inc i
        cmp i, 4   ;se repetira cuatro veces
                    ;o sea, altura = 20
        jnz linea 

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

    sub cl, ancho
    sub dl, altura
    
    horizontal cl, dl
    
    mov cl, cenx         ;centro constante
    mov dl, ceny

    sub cl, ancho
    sub dl, altura
     
    vertical cl, dl 
    
    mov cl, cenx
    mov dl, ceny
    
    sub cl, ancho
    add dl, altura
    
    horizontal cl, dl
    
    mov cl, cenx         ;centro constante
    mov dl, ceny

    add cl, ancho
    sub dl, altura
     
    vertical cl, dl 
            
        
    

nada: 
    NOP

jmp repite  

ret