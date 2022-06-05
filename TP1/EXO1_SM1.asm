;-----------------------------------------------------------------------------
;  FILE NAME   :  EXO_SM1.asm
;  TARGET MCU  :  C8051F020 
;  DESCRIPTION :  Cette suite d'exercices de base est destin�e � faire
;                 d�couvrir le jeu d'instruction de la famille 8051.
;                 Ins�rez votre code sous chaque exercice.
;                 A la fin de la s�ance, vous rendrez ce fichier via E-campus
;                 ou par Email � l'adresse que l'on vous communiquera
;                 
;******************************************************************************
;******************************************************************************
; NE PAS MODIFIER LES DIRECTIVES et INSTRUCTIONS SUIVANTES:
;******************************************************************************
$include (c8051f020.inc)               ; Include register definition file.
;-----------------------------------------------------------------------------
; EQUATES
;-----------------------------------------------------------------------------
GREEN_LED      equ   P1.6              ; Port I/O pin connected to Green LED.
;-----------------------------------------------------------------------------
; RESET and INTERRUPT VECTORS
;-----------------------------------------------------------------------------

               ; Reset Vector
               cseg AT 0
               ljmp Main               ; Locate a jump to the start of code at 
                                       ; the reset vector.

;-----------------------------------------------------------------------------
; CODE SEGMENT
;-----------------------------------------------------------------------------
Blink          segment  CODE

               rseg     Blink        ; Switch to this code segment.
               using    0            ; Specify register bank for the following
                                     ; program code.

Table_ex:          db  'VOILA UN EXEMPLE DE CHAINE A COPIER!!!'

;Initialisations de p�riph�riques - Fonctionnalit�s Microcontroleur

Main:          ; Disable the WDT. (IRQs not enabled at this point.)
               ; If interrupts were enabled, we would need to explicitly disable
               ; them so that the 2nd move to WDTCN occurs no more than four clock 
               ; cycles after the first move to WDTCN.
               mov   WDTCN, #0DEh
               mov   WDTCN, #0ADh
               ; Enable the Port I/O Crossbar
               mov   XBR2, #40h
               ; Set P1.6 (LED) as digital output in push-pull mode.  
               orl   P1MDIN, #40h	 
               orl   P1MDOUT,#40h 
; Programme Principal
;******************************************************************************
;******************************************************************************
; VOUS POUVEZ FAIRE des MODIFICATIONS A PARTIR D'ICI
;******************************************************************************


;EXO 1 : INSTRUCTIONS DE TRANSFERT DE DONNEES
;1.	Initialiser l'accumulateur � 0 (coder les 3 solutions possibles), le registre R0 � FFh et la case d'adresse m�moire 40h de la m�moire RAM interne � 55h.
mov A, #00H
mov 0E0H, #00H
clr A
;2.	Copier le contenu de l'accumulateur dans le registre R1.
mov R1, A
;3.	Copier le contenu de la m�moire 40h de la RAM interne dans la case 42h de la RAM Interne.
mov 42H, 40H
;4.	Copier le contenu de la m�moire 40h de la RAM interne dans la case D0h de la RAM Interne � acc�s indirect. Que se passe-t-il si on utilise par erreur l'adressage direct sur D0h?
mov R1, #0D0H
mov @R1, 40H


;EXO 2 : MANIPULATION DES ESPACES MEMOIRES
;1.	Copier le contenu de 20h (DATA) dans la case m�moire 2FFh en m�moire RAM externe (XDATA).
mov 20H, #69H
mov A, 20H
mov DPTR, #2FFH
movx @DPTR, A
;2.	Copier le contenu de 0000h (CODE) dans la case m�moire 82h en m�moire RAM interne.
clr A
mov DPTR, #00H
movc A, @A+DPTR
mov 82H, A
;3.	Copier le contenu de la m�moire 0100h de la XDATA dans la case 43h de la RAM Interne.
mov DPTR, #0100H
movx A, @DPTR
mov 43H, A
;4.	Copier le contenu de la m�moire 1234h de la m�moire CODE dans la case 0102h de la m�moire XDATA.
clr A
mov DPTR, #1234H
movc A, @A+DPTR
mov DPTR, #0102H
movx @DPTR, A


;EXO 3 : INSTRUCTIONS ARITHMETIQUES - ARITHMETIQUE NON SIGNEE
;1.	Incr�menter l'accumulateur de 1.
inc A
;2.	D�cr�menter de 1 l'octet d'adresse 33h de la RAM Interne.
dec 33H
;3.	Echanger le contenu de B avec le contenu de la m�moire 07FFh en m�moire externe (XDATA).
mov R1, B
mov DPTR, #07FFH
movx A, @DPTR

mov B, A
mov R1, A
movx @DPTR, A
;4.	En une ligne de code, �changer le contenu de A avec le contenu de la m�moire 60h.
xch A,60H


;EXO 4 : INSTRUCTIONS LOGIQUES - MANIPULATION de BITS
;1.	Compl�menter le bit d'adresse 10h. Ou se trouve-t-il ? (c'est le bit X de l'octet d'adresse YY dans la m�moire DATA).
mov a, 10h
cpl a
mov 10h,a
;2.	Mettre � 1, les bits 0 et 7  de l'octet d'adresse 22h de la RAM interne (sans changer les autres bits).
SETB 17h
SETB 10h
;3.	Mettre � 1, les bits 0 et 7 du registre R0 (sans changer les autres bits).
;Solution par d�placement dans un registre accessible bit � bit
mov A,R0
SETB ACC.0
SETB ACC.7
mov R0, A
;4.	Mettre � 1, les bits 0 et 7 de l'octet d'adresse 07ffh de la XDATA (sans changer les autres bits)
mov DPTR, #07FFH
movx A, @DPTR
SETB ACC.0
SETB ACC.7
movx @DPTR, A


;EXO 5 : INSTRUCTIONS DE SAUT CONDITIONNEL ET INCONDITIONNE
;1.	Placez une valeur quelconque dans R3, incr�mentez la jusqu'� ce qu'elle atteigne la valeur B6h (pensez � initialiser R3).
mov R3, #0B0h
BCL_EX05_1:    
	inc R3
	CJNE R3, #0B6H, BCL_EX05_1
;2.	Remplir la m�moire RAM interne de l'adresse 20h � 40h avec des codes ASCII �grainant l'alphabet.
mov A,#'A'
mov R0, #20H
BCL_EX05_2:	
	MOV  @R0,A
	INC  R0
	INC A
	CJNE A,#'Z'+1,BCL_EX05_2b
	MOV  A,#'A'
BCL_EX05_2b:	
	CJNE R0,#41H,BCL_EX05_2
;3.	Lire le contenu de l'adresse 0000h � 0002h dans l'espace code et le copier � l'adresse 0000h � 0002h de l'espace XDATA.
MOV DPTR,#0000H
	MOV R3,#03H
BCL_EX05_3:
    CLR A
	;Le DPTR est sur 0 en fonction du mode d'adressage on modifie des zones m�moires diff�rentes
	MOVC A,@A+DPTR
	MOVX @DPTR,A
	INC  DPTR
	DJNZ R3,BCL_EX05_3
    

;EXO 6 : MANIPULATION DES BANCS de REGISTRES R0-R7
;1.	Commuter le banc de registres R0-R7 sur le banc 2 et copier le contenu de A dans le registre R4 sans utiliser "R4" dans l'instruction.

;2.	Mettre � z�ro la case d'adresse 08h de la ram interne en utilisant un adressage par registre (utiliser un registre R0...R7).



;EXO 7 : INSTRUCTIONS LOGIQUES - MANIPULATION de BITS - 2 
;1.	D�caler le registre B d'une case vers la gauche, le bit6 devient bit7, le bit5 devient bit6, etc. le bit7 devient bit0.

;2.	Ex�cuter une rotation logique gauche sur le DPTR, le bit 15 devient le bit 0. (Initialiser auparavant le DPTR avec la valeur 0F0Fh).


;EXO 8 : INSTRUCTIONS ARITHMETIQUES - Arithm�tique non sign�e - 2 
;1.	Incr�menter de 2 la case m�moire RAM externe d'adresse 100h.

;2.	Multiplier les donn�es en RAM interne d'adresse 22h et 23h. Placer le r�sultat en 24h(LSB) et 25h(MSB).



;EXO 9 : INSTRUCTIONS DE SAUT CONDITIONNEL ET INCONDITIONNEL - 2 
;1.	Remplir la m�moire RAM externe (XDATA) de l'adresse 120h � 140h avec des codes ASCII �grainant l'alphabet.

;2.	Incr�mentez le DPTR initialis� avec une valeur quelconque jusqu'� la valeur de A B C D h.



;EXO 10 : Exercices d'approfondissement - FACULTATIF
;1.	Additionner les registres R6 et R7, stocker le r�sultat dans R5. Quelles sont les limitations ? Pour s'affranchir des limitations pr�c�dentes, refaire la m�me op�ration mais stocker le r�sultat dans R4 (LSB) et R5(MSB).

;2.	Faire l'op�ration R0 moins R1 et placer le r�sultat dans R7. Que se passe t'il si R1>R0 ?

;3.	Compl�menter le demi-octet de pds faible de l'adresse 2Ah de la RAM interne.

;4.	Placez une valeur quelconque dans R3, d�cr�mentez la, jusqu'� ce qu'elle atteigne une valeur contenue dans R6 (pensez � initialiser R3 et R6).

;5.	Initialiser les registres R4 et R5 respectivement avec les valeurs 0Fh et F5h. Faites un OU Exclusif entre ces deux registres et placez le r�sultat dans l'accumulateur.

;6.	Stocker le demi-octet de poids faible de la case m�moire d'adresse 44h de la RAM interne dans les deux demi-octets du registre R4 (si la case 44h contient 17h, alors R4 devra contenir 77h).

;7.	Elever au carr� le contenu de l'octet 12h, placer le r�sultat dans R0 (pds fort) et R1 (pds faible).

;8.	Soit 2 nombres BCD de 16 bits (valeur 0 � 9999) stock�s respectivement dans R0(MSB)-R1(LSB) et R2(MSB)-R3(LSB). Faire l'addition BCD de ces deux nombres, et stocker le r�sultat dans R4(MSB)-R5(LSB). La retenue sera dans le bit Carry du registre PSW.

;9.	Compter le nombre de bits � 1 dans le registre B et stocker le r�sultat dans R5.

;10. Diviser le contenu du registre R7 par le nombre 10, placer le quotient dans R5 et le reste dans R6.




;******************************************************************************
;******************************************************************************
; NE PAS MODIFIER LES DIRECTIVES et INSTRUCTIONS SUIVANTES:
;******************************************************************************
  
bcl:   jmp bcl
;-----------------------------------------------------------------------------
; End of file.

END



