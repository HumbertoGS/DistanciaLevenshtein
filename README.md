# DistanciaLevenshtein
-------------------------------------------------------------------------------
```
Explicacion
Si no se ingresa DatoA, la distancia es Longitud(DatoB)\n
Si no se ingresa DatoB, la distancia es Longitud(DAtoA).
Si no se ingresa Datos, la distancia es 0.
Si se ingresa DatoA y DatoB...
Se recorre cada caracter de ambos datos, comparando su valores similares.
Y se cuenta los valores que no coincidan.
```
-------------------------------------------------------------------------------
Ejm:
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
-------------------------------------------------------------------------------
Ejm2:
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
Ejm3:  
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
