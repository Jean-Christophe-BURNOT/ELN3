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
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse du périphérique d’entrée
; Valeur retournée: R7 : contient la valeur du code lu (sur les 6 bits de poids faible). 
; Registres modifiés: aucun
;******************************************************************************    

_Read_code:
              ; insérez le code du sous-programme ici
              RET
;******************************************************************************    			  
			  
;******************************************************************************                
; _Read_Park_IN
;
; Description: 
;
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse du périphérique d’entrée
; Valeur retournée: Bit Carry  0: pas de détection / 1: véhicule détecté 
; Registres modifiés: aucun
;******************************************************************************    

_Read_Park_IN:
              ; insérez le code du sous-programme ici
              RET
;******************************************************************************    						  
			  
;******************************************************************************                
; _Read_Park_OUT
;
; Description: 
;
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse du périphérique d’entrée
; Valeur retournée: Bit Carry  0: pas de détection / 1: véhicule détecté 
; Registres modifiés: aucun
;******************************************************************************    

_Read_Park_OUT:
              ; insérez le code du sous-programme ici
              RET
;****************************************************************************** 

;******************************************************************************                
; _Decod_BIN_to_BCD 
;
; Description: 
;
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse CODE de la table de conversion
;                                            "Display_7S"
; Paramètres d'entrée:  R5  – Valeur 4 bits à convertir (4bits de poids faible)
; Valeur retournée: R7 - Code 7 segments (Bit 0-Segment a __ Bit6-Segment g)
; Registres modifiés: aucun
;******************************************************************************    

_Decod_BIN_to_BCD:
              ; insérez le code du sous-programme ici
              RET

;****************************************************************************** 

;******************************************************************************                
; _Display  
;
; Description: 
;
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse du périphérique de sortie
; Paramètre d’entrée :  R5 – Code 7 segments (les 7 bits de poids faible)
; Paramètre d’entrée :  R3 – Code LED : si 0, LED éteinte, si non nul : LED allumée
; Valeur retournée: R7 : contient une recopie de la valeur envoyée au périphérique de sortie. 
; Registres modifiés: aucun
;******************************************************************************    

_Display:
              ; insérez le code du sous-programme ici
              RET
;****************************************************************************** 

;******************************************************************************                
; _Test_Code  
;
; Description: 
;
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse de Tab_code
; Paramètre d’entrée :  R5  – Code à vérifier (sur 6 bits)
; Valeur retournée: R7 : non nul, il retourne la position du code trouvé dans la table,
;                        nul, il indique que le code n’a pas été trouvé dans la table.
; Registres modifiés: aucun
;******************************************************************************    

_Test_Code:
              ; insérez le code du sous-programme ici
              RET
;****************************************************************************** 

;******************************************************************************                
; _Stockage_Code 
;
; Description: 
;
; Paramètres d'entrée:  R6 (MSB)- R7 (LSB) – Adresse de Tab_histo
; Paramètre d’entrée :  R5 – Code à enregistrer
; Valeur retournée: R7 : R7 : non nul, il retourne le nombre d’enregistrements,
;                             nul, il indique que la table est pleine (100 enregistrements). 
; Registres modifiés: aucun
;******************************************************************************    

_Stockage_Code:
              ; insérez le code du sous-programme ici
              RET
;****************************************************************************** 


END



