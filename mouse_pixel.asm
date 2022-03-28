; dibujo de raton
                    ; presione el boton izquierdo del raton para dibujar.
                    ; para una prueba real, haga clic en 
                    ; externo->ejecutar desde el menú del emulador.
                    name "mouse2"
                    org 100h
                    jmp start
                    oldX dw -1
                    oldY dw 0   
                    msg db " presiona cualquier tecla....     $"
start:              mov ah, 00
                    mov al, 13h     ; configurar la pantalla a 256 colores
                                    ; , 320x200 pixeles. 
                    int 10h

                    mov ax, 0       ; reinicie el mouse y obtenga su estado 
                                    ; ax>0 si hay raton, ax=0 si no hay
                    int 33h
                    cmp ax, 0 
                    
check_mouse_button: mov ax, 3       ; Leer el estado de los botones y la posicion
                                    ; del cursor (Devuelve la posición del cursor 
                                    ; y el estado de sus botones)      
                                    ; cx = posicion columna (H) y dx = posicion fila (V)
                    int 33h 
                    shr cx, 1       ; x/2 - en este modo se reduce el valor de CX a la mitad.
                    cmp bx, 1
                    jne xor_cursor:
                    mov al, 1010b   ; color de pixel (Verde Claro)
                    jmp draw_pixel
xor_cursor:         cmp oldX, -1
                    je not_required
                    push cx
                    push dx
                    mov cx, oldX
                    mov dx, oldY
                    mov ah, 0dh     ; Lectura de un punto   
                                    ; DX = numero de region
                                    ; CX = numero de columna
                                    ; AL = punto leido
                    int 10h
                    xor al, 1111b   ; Color del pixel Blanco Brillante
                    mov ah, 0ch     ; pon pixel
                    int 10h
                    pop dx
                    pop cx
not_required:       mov ah, 0dh     ; Lectura de un punto   
                                    ; DX = numero de region
                                    ; CX = numero de columna
                                    ; AL = punto leido
                    int 10h                         
                    xor al, 1111b   ; Color del pixel Blanco Brillante
                    mov oldX, cx
                    mov oldY, dx
draw_pixel:         mov ah, 0ch     ; pone pixel
                    int 10h         ; DX = numero de renglon  (fila)
                                    ; CX = numero de columna
                                    ; AL = color
check_esc_key:      mov dl, 255
                    mov ah, 6       ; I/O directo de consola
                    int 21h         ; Espera hasta recibir un carácter 
                                    ; proveniente del teclado
                    cmp al, 27      ; esc?
                    jne check_mouse_button

stop:
                    mov ax, 3       ; back to text mode: 80x25 
                                    ; AL= 3-80 x 25 caracteres color,
                    int 10h
                                    ; mostrar el cursor de texto parpadeante
                                    ; en forma de cuadro-->
                    mov ah, 1       ; Seleccion de tipo de cursor 
                                    ; Esta opcion utiliza los registros CH y CL. 
                                    ; Los bits 4 a 0 de CH indican la linea donde
                                    ; comienzan el cursos mientras que 
                                    ; los bits 4 a 0 de CL senalan donde termina. 
                                    ; Los demás bits deben ponerse en cero 
                                    ; con el fin de evitar comportamientos erraticos.
                    mov ch, 0
                    mov cl, 8
                    int 10h     
                    
                    mov dx, offset msg
                    mov ah, 9
                    int 21h
                    mov ah, 0
                    int 16h
                    ret