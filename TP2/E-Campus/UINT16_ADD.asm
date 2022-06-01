;-----------------------------------------------------------------------------
$include (c8051f020.inc)               ; Include register definition file.
;-----------------------------------------------------------------------------
;******************************************************************************
; UINT16_ADD - SOUS-PROGRAMME Addition de 2 nombres 16 bits
;
; Description: Sous-programme charg� d'additionner 2 nombres de 16 bits non sign�s
;              argument1 + argument2 = R�sultat
;
; Param�tres d'entr�e:  R6-R7: argument1  (R6 poids fort, R7 poids faible)
;                       R4-R5: argument2  (R4 poids fort, R5 poids faible)
;						
;     
; Param�tres de sortie: R�sultat sur R6-R7 (R6 poids fort, R7 poids faible)
; Registres modifi�s:  ?
; Pile: ? octets 
;******************************************************************************
UINT16_ADD:
       push  PSW ; Sauvegarde en pile des registres utilis�s (hors param�tres pass�s) 
	   push  ACC
	
       mov A,R7
	   add A,R5 ;Somme Pds faibles R7 + R5
                ; = R�sultat:  1 octet stock� en R7 + 1 bit de retenue (Carry) 
	   mov R7,A
	   mov A,R6
	   addc A,R4 ;Somme R6 + R4 + Retenue
                 ; = R�sultat:  1 octet stock� en R6 + 1 bit de retenue (Carry) non utilis� 
	   mov R6,A

       pop ACC    ; Restauration des registres sauvegard�s
	   pop PSW
	   RET
; FIN UINT16_ADD
;******************************************************************************