    org 100h
    jmp start
    msg1 db 13,10,13,10,"Letra a: ","$"
    msg2 db 13,10,13,10,"Letra r: ","$" 
    file db "C:\emu8086\MyBuild\holo.txt",0
    renglon db 100 dup("$"),"$"  
    char1 db "a"
    char2 db "r"
    n dw 0  ;indice en frase 
    i db 0  ;contador para a
    j db 0  ;contador para r   
    
    handle dw 0

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
    leer renglon
    printMSG renglon  
    compara char1,char2,renglon   ;compara la frase con letra "a"
    jmp final
                 
                 
leer MACRO leido
    ; Abrir
    mov ah,3dh
    mov al,0h
    mov dx,offset file
    int 21h
    
    mov bx,ax
    
    ; Leer archivo
    mov ah,3fh
    mov cx,50 ;50 caracteres
    mov dx,offset leido
    int 21h
    
    ; Cierre de archivo
    mov ah,3eh
    int 21h
    endm                   
   

compara MACRO letra1,letra2,msg  
    ciclo:
    mov si,n
    mov al,msg[si] 
    
    cmp letra1,al 
    jz indiceI:
    
    cmp letra2,al 
    jz indiceJ:
    
    cmp msg[si],"$"
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