;-----------------------------------------------------------------------------
$include (c8051f020.inc)               ; Include register definition file.
;-----------------------------------------------------------------------------
;******************************************************************************
; UINT16_ADD - SOUS-PROGRAMME Addition de 2 nombres 16 bits
;
; Description: Sous-programme chargé d'additionner 2 nombres de 16 bits non signés
;              argument1 + argument2 = Résultat
;
; Paramètres d'entrée:  R6-R7: argument1  (R6 poids fort, R7 poids faible)
;                       R4-R5: argument2  (R4 poids fort, R5 poids faible)
;						
;     
; Paramètres de sortie: Résultat sur R6-R7 (R6 poids fort, R7 poids faible)
; Registres modifiés:  ?
; Pile: ? octets 
;******************************************************************************
UINT16_ADD:
       push  PSW ; Sauvegarde en pile des registres utilisés (hors paramètres passés) 
	   push  ACC
	
       mov A,R7
	   add A,R5 ;Somme Pds faibles R7 + R5
                ; = Résultat:  1 octet stocké en R7 + 1 bit de retenue (Carry) 
	   mov R7,A
	   mov A,R6
	   addc A,R4 ;Somme R6 + R4 + Retenue
                 ; = Résultat:  1 octet stocké en R6 + 1 bit de retenue (Carry) non utilisé 
	   mov R6,A

       pop ACC    ; Restauration des registres sauvegardés
	   pop PSW
	   RET
; FIN UINT16_ADD
;******************************************************************************