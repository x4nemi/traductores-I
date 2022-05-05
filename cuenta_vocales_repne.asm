;Cuenta las vocales de una cadena haciendo uso
;de repne
    org 100h   
    jmp start
    msg db "Hola, soy ximena", "$$$$" 
           ;12345678901234567890 
    
    salto db 13, 10, 13, 10, "", "$$$$$" 
    
    msgA db "a: ", "$"
    msgE db "e: ", "$"
    msgI db "i: ", "$"
    msgO db "o: ", "$"
    msgU db "u: ", "$"
    
    iA db 0  
    iE db 0
    iI db 0
    iO db 0
    iU db 0
    
    
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

inicio MACRO char 
    cld
    xor cx,cx
    lea di, msg 
    mov al, char
    mov cl, 16
endm    


incA:
    inc iA
    jmp letraA 

incE:
    inc iE 
    jmp letraE

incI:
    inc iI  
    jmp letraI

incO:
    inc iO 
    jmp letraO

incU:
    inc iU  
    jmp letraU 

start:  
    inicio "a"

letraA:  
    repne scasb
    je incA 
    inicio "e"    
 
letraE:        
    repne scasb
    je incE  
    inicio "i"
            
letraI:
    mov ax, 'i'
    repne scasb
    je incI    
    inicio 'o'
    
    
letraO:
    repne scasb
    je incO   
    inicio 'u'
            

letraU:
    repne scasb
    je incU
          

resultados:   
    printMSG msg
    printMSG salto
      
    printMSG msgA
    printNUM iA
    printMSG salto
     
    printMSG msgE
    printNUM iE   
    printMSG salto  

    printMSG msgI
    printNUM iI   
    printMSG salto 

    printMSG msgO
    printNUM iO   
    printMSG salto 

    printMSG msgU
    printNUM iU
    
ret




