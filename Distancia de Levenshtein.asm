Imprimir macro texto
    mov ah,9h
    mov dx, offset texto
    int 21h
    
endm

Longitud macro texto
    add texto,30h
    mov ah,9h
    lea dx,texto
    int 21h
    jmp salir
    
    
endm


Leer macro texto
    mov ah, 1
    xor si, si
    capturar:
        int 21h
        cmp al, 13
        jz salida
        mov texto[si],al
        inc si
        inc uno  ;Incrementa uno
        jmp capturar
        
    salida:
    
    
endm 

Leer2 macro texto
    mov ah, 1
    xor si, si
    capturar2:
        int 21h
        cmp al, 13
        jz salida2
        mov texto[si],al
        inc si
        inc dos  ;Incrementa dos
        jmp capturar2
        
    salida2:
    
    
endm

.model small
.data
    msg db 20 dup('$') 
    msg2 db 20 dup('$')  
    Dstan db 10,13,'La Distancia Levenshtein es: ','$' 
    contador db 0,'$'     
    msa1 db 10,13,'Ingrese una palabra: ','$' 
    msa2 db 10,13,'Ingrese otra palabra: ','$'
    uno db 0 ,'$'
    dos db 0 ,'$'
.code 
inicio:
    mov ax,@data
    mov ds,ax 
    
    Imprimir msa1
    Leer msg
    
    Imprimir msa2
    Leer2 msg2
    
    
    cmp uno,0    ;Comparar, si el valor de uno es 0
    je CasoC     ;Presenta el valor de dos como distancia de levenshtein
    jne CalDist  ;Si uno no es 0, entonces pasamos a calcular su valor


CasoC:
    Imprimir Dstan
    Longitud dos
    jmp salir


CalDist:    
    mov si,0
    mov ah,dos
    cmp uno,ah
    jl CasoB
    jg CasoA


CasoA:
    comienzo:
        cmp msg[si],'$' ;si es el fin de la cadena ir a resultado
        jz resultado
    
    
    comprobar:
        mov al, msg2[si] ;copiar msg2 con su posicion di a al
        cmp msg[si],'$' ;si es el fin de la cadena ir a resultado
        jz resultado
        
        cmp msg[si], al ;comparar msg con su posicion si con el valor de al
        jz seguir ;si ambos caracteres son iguales, va a seguir:
        
        inc contador ;si ambos caracteres son diferentes, suma contador
        inc si ;incrementar si para avanzar de caracter
        loop comprobar ;bucle para recorrer
    
    seguir: 
        inc si ;incrementar si para avanzar de caracter
        loop comienzo ;bucle principal para recorrer palabra


CasoB:
    comienzoB:
        cmp msg2[si],'$' ;si es el fin de la cadena ir a resultado
        jz resultado
    
    
    comprobarB:
        mov al, msg[si] ;copiar msg con su posicion si a al
        cmp msg2[si],'$' ;si es el fin de la cadena ir a resultado
        jz resultado
        
        cmp msg2[si], al ;comparar msg2 con su posicion si con el valor de al
        jz seguirB ;si ambos caracteres son iguales, va a seguirB:
        
        inc contador ;si ambos caracteres son diferentes, suma contador
        inc si ;incrementar si para avanzar de caracter
        loop comprobarB ;bucle para recorrer
    
    seguirB: 
        inc si ;incrementar si para avanzar de caracter
        loop comienzoB ;bucle principal para recorrer palabra




resultado:
    add contador,30h   ;pasamos a decimal el valor de contador
    Imprimir Dstan     ;Mandar Dstan para presentar
    Imprimir contador  ;Mandar el valor de contador para presentar
    jmp salir


salir:
.exit
  
end 



;Explicacion
;Si no se ingresa DatoA, la distancia es Longitud(DatoB)
;Si no se ingresa DatoB, la distancia es Longitud(DAtoA) 
;Si no se ingresa Datos, la distancia es 0
;Si se ingresa DatoA y DatoB...
; Se recorre cada caracter de ambos datos, comparando su valores similares
; Y se cuenta los valores que no coincidan
;
;Ejm:
;       DatoA = Camaron
;       DatoB = Cozador
;
;       DatoA[] = [0] [1] [2] [3] [4] [5] [6]
;                  C   a   m   a   r   o   n
;
;       DatoB[] = [0] [1] [2] [3] [4] [5] [6]
;                  C   a   z   a   d   o   r
;
;      Contador =  0   0   1   0   1   0   1   =  3 
;
;      Distancia de Levenshtein es 3  
;
;Ejm2:
;       DatoA = Camarones
;       DatoB = Cozador
;
;       DatoA[] = [0] [1] [2] [3] [4] [5] [6] [7] [8]
;                  C   a   m   a   r   o   n   e   s
;
;       DatoB[] = [0] [1] [2] [3] [4] [5] [6]
;                  C   a   z   a   d   o   r
;
;      Contador =  0   0   1   0   1   0   1   1   1  =  5 
;
;      Distancia de Levenshtein es 5 
;
;En el caso del DatoA ser menor longitud, se empieza con el DatoB
;
;Ejm3:  
;       DatoA = Pan
;       DatoB = Pablo
;
;       DatoB[] = [0] [1] [2] [3] [4] 
;                  P   a   b   l   o  
;
;       DatoA[] = [0] [1] [2] 
;                  P   a   n    
;
;      Contador =  0   0   1   1   1    =  3 
;
;      Distancia de Levenshtein es 3
;