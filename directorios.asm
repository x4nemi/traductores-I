;Actividad 6, manejo de directorios y archivos
            org 100h
            jmp inicio
            directorio db "C:\emu8086\MyBuild\actividad6", 0   ;ascii del nombre del  
            directori1 db "C:\emu8086\MyBuild", 0   ;ascii del nombre del
            nombre     db "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$",0
            
            archivo db "C:\emu8086\MyBuild\actividad6\prueba.txt",0
            file db "prueba.txt",0 
            
            cadena db "Ximena Garcia Vega 23$$$$$$$$","$"  
                      ;123456789123456789123         
                                                                                                       ;directorio 
inicio:                                             
            mov dx, offset directorio   
            mov ah, 39h                  ; Se crea un directorio
            int 21h                     
            
            mov dx, offset directorio    
            mov ah, 3Bh                  ; Se cambia de directorio al creado 
            int 21h  
             
            mov dx,offset nombre
            mov ah, 47h                  ; Se confirma que se cambio de lugar                                                          
            int 21h  
            
            mov cx,0                     ; atributos de fichero normal
            mov dx,offset archivo
            mov ah,3ch                   ; Crea archivo
            int 21h    
            
            mov bx,ax
            mov ah,3eh                   ; Se cierra el archivo 
                                         ; para que pueda eliminarse
            int 21h   
            
            ;mov ah,41h                   ; Se elimina el archivo
            ;mov dx, offset archivo
            ;int 21h  
            
            mov ah,3dh                   ; Se abre el archivo en
            mov al,1h                    ; modo escritura
            mov dx,offset archivo
            int 21h
            
            mov bx,ax                    ; numero de caracteres a escrbir
            mov cx,15h                   ; 21 caracteres = 15h 
            mov dx,offset cadena 
            mov ah,40h
            int 21h  
            
            mov ah,3eh  ;Cierre de archivo
            int 21h
                
            mov dx, offset directori1    
            mov ah, 3Bh                  ; Se cambia de directorio original                                             
            int 21h                     
            
            mov dl,0  
            mov si,offset nombre
            mov ah, 47h                  ; Se confirma que se cambio de lugar                                                          
            int 21h  
            
            
            ret