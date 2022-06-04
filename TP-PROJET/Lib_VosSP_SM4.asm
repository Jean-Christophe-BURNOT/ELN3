;-----------------------------------------------------------------------------
;
;  FILE NAME   :  LIB_VOSSP_SM4.ASM 
;  TARGET MCU  :  C8051F020 
;  

;-----------------------------------------------------------------------------
$include (c8051f020.inc)               ; Include register definition file. 
;-----------------------------------------------------------------------------
;******************************************************************************
;Declaration des variables et fonctions publiques
;******************************************************************************
PUBLIC   _Read_code
PUBLIC   _Read_Park_IN
PUBLIC   _Read_Park_OUT
PUBLIC   _Decod_BIN_to_BCD
PUBLIC   _Display
PUBLIC   _Test_Code
PUBLIC   _Stockage_Code

;-----------------------------------------------------------------------------
; EQUATES
;-----------------------------------------------------------------------------
GREEN_LED      	equ   	P1.6             ; Port I/O pin connected to Green LED.

;-----------------------------------------------------------------------------
; CODE SEGMENT
;-----------------------------------------------------------------------------
ProgSP_base      segment  CODE

               rseg     ProgSP_base      ; Switch to this code segment.
               using    0              ; Specify register bank for the following
                                       ; program code.
;------------------------------------------------------------------------------
;******************************************************************************                
; _Read_code
;
; Description: 
;
; Param�tres d'entr�e:  R6 (MSB)- R7 (LSB) � Adresse du p�riph�rique d�entr�e
; Valeur retourn�e: R7 : contient la valeur du code lu (sur les 6 bits de poids faible). 
; Registres modifi�s: aucun
;******************************************************************************    

_Read_code:
              ; ins�rez le code du sous-programme ici
              RET
;******************************************************************************    			  
			  
;******************************************************************************                
; _Read_Park_IN
;
; Description: 
;
; Param�tres d'entr�e:  R6 (MSB)- R7 (LSB) � Adresse du p�riph�rique d�entr�e
; Valeur retourn�e: Bit Carry  0: pas de d�tection / 1: v�hicule d�tect� 
; Registres modifi�s: aucun
;******************************************************************************    

_Read_Park_IN:
              ; ins�rez le code du sous-programme ici
              RET
;******************************************************************************    						  
			  
;******************************************************************************                
; _Read_Park_OUT
;
; Description: 
;
; Param�tres d'entr�e:  R6 (MSB)- R7 (LSB) � Adresse du p�riph�rique d�entr�e
; Valeur retourn�e: Bit Carry  0: pas de d�tection / 1: v�hicule d�tect� 
; Registres modifi�s: aucun
;******************************************************************************    

_Read_Park_OUT:
              ; ins�rez le code du sous-programme ici
              RET
;****************************************************************************** 

;******************************************************************************                
; _Decod_BIN_to_BCD 
;
; Description: 
;
; Param�tres d'entr�e:  R6 (MSB)- R7 (LSB) � Adresse CODE de la table de conversion
;                                            "Display_7S"
; Param�tres d'entr�e:  R5  � Valeur 4 bits � convertir (4bits de poids faible)
; Valeur retourn�e: R7 - Code 7 segments (Bit 0-Segment a __ Bit6-Segment g)
; Registres modifi�s: aucun
;******************************************************************************    

_Decod_BIN_to_BCD:
              ; ins�rez le code du sous-programme ici
              RET

;****************************************************************************** 

;******************************************************************************                
; _Display  
;
; Description: 
;
; Param�tres d'entr�e:  R6 (MSB)- R7 (LSB) � Adresse du p�riph�rique de sortie
; Param�tre d�entr�e :  R5 � Code 7 segments (les 7 bits de poids faible)
; Param�tre d�entr�e :  R3 � Code LED : si 0, LED �teinte, si non nul : LED allum�e
; Valeur retourn�e: R7 : contient une recopie de la valeur envoy�e au p�riph�rique de sortie. 
; Registres modifi�s: aucun
;******************************************************************************    

_Display:
              ; ins�rez le code du sous-programme ici
              RET
;****************************************************************************** 

;******************************************************************************                
; _Test_Code  
;
; Description: 
;
; Param�tres d'entr�e:  R6 (MSB)- R7 (LSB) � Adresse de Tab_code
; Param�tre d�entr�e :  R5  � Code � v�rifier (sur 6 bits)
; Valeur retourn�e: R7 : non nul, il retourne la position du code trouv� dans la table,
;                        nul, il indique que le code n�a pas �t� trouv� dans la table.
; Registres modifi�s: aucun
;******************************************************************************    

_Test_Code:
              ; ins�rez le code du sous-programme ici
              RET
;****************************************************************************** 

;******************************************************************************                
; _Stockage_Code 
;
; Description: 
;
; Param�tres d'entr�e:  R6 (MSB)- R7 (LSB) � Adresse de Tab_histo
; Param�tre d�entr�e :  R5 � Code � enregistrer
; Valeur retourn�e: R7 : R7 : non nul, il retourne le nombre d�enregistrements,
;                             nul, il indique que la table est pleine (100 enregistrements). 
; Registres modifi�s: aucun
;******************************************************************************    

_Stockage_Code:
              ; ins�rez le code du sous-programme ici
              RET
;****************************************************************************** 


END



