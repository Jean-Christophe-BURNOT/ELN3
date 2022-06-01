;-----------------------------------------------------------------------------
;
;  FILE NAME   :  BASE_TP3.ASM 
;  TARGET MCU  :  C8051F020 
;  
;-----------------------------------------------------------------------------
$include (c8051f020.inc)               ; Include register definition file. 
;-----------------------------------------------------------------------------
;Declarations Externes
EXTRN code (__tempo,Init_pgm,__tempo_20US,__tempo_100US) ; Source Lib_TP_SM
EXTRN code (Test_IO)	
;-----------------------------------------------------------------------------
; EQUATES
;-----------------------------------------------------------------------------
BRD_GREEN_LED      	equ   	P1.6             ; Port I/O pin connected to Green LED
LEDV_ON__LEDR_OFF SET 0FH
LEDV_OFF__LEDR_ON SET 0F0H	
Ctrl_LED SET 05000H
	
; STACK segment.
;------------------------------------------------------------------------------
?STACK          SEGMENT IDATA           ; ?STACK goes into IDATA RAM.
                RSEG    ?STACK          ; switch to ?STACK segment.
                DS      20              ; reserve your stack space
                                        ; 20 bytes in this example.
;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
; DATA SEGMENT
;-----------------------------------------------------------------------------
Ram_interne      SEGMENT DATA    
                 RSEG    Ram_interne  
Cmd_LED:          DS 	1
;-----------------------------------------------------------------------------
; BIT SEGMENT
;-----------------------------------------------------------------------------
Bit_zone      SEGMENT BIT     
              RSEG    Bit_zone 
Bit_Test:     DBIT 	  1			  
;-----------------------------------------------------------------------------
; RESET and INTERRUPT VECTORS
;-----------------------------------------------------------------------------
               ; Reset Vector
               cseg AT 0          ; SEGMENT Absolu
               ljmp Main ; Locate a jump to the start of code at 
                                  ; the reset vector.
						
;-----------------------------------------------------------------------------
; CODE SEGMENT
;-----------------------------------------------------------------------------
Prog_base      segment  CODE

               rseg     Prog_base      ; Switch to this code segment.
               using    0              ; Specify register bank for the following
                                       ; program code.
;******************************************************************************
;Initialisations de périphériques - Fonctionnalités Microcontroleur
;******************************************************************************
Main:
        MOV   sp,#?STACK-1
		; Initialisations globales du microcontrôleur
        call Init_pgm  
		
;******************************************************************************
; Programme Principal
;******************************************************************************
        MOV Cmd_LED,#01H
Main_Bcl:
		MOV A,Cmd_LED
		CJNE A,#LEDV_ON__LEDR_OFF,TRT_LED1
		MOV A,#LEDV_OFF__LEDR_ON
		JMP Suit_Main1 
TRT_LED1:	
        MOV A,#LEDV_ON__LEDR_OFF
Suit_Main1:
        
	    MOV Cmd_LED,A
	    MOV DPTR,#Ctrl_LED
	    MOVX @DPTR,A
		MOV    	R7,#50H ; Passage de paramètres avant l'appel de __tempo
 		MOV    	R6,#0C3H
		CALL   	__tempo
		
		CPL BRD_GREEN_LED
		
fin_pg: jmp   	Main_Bcl

;-----------------------------------------------------------------------------
; End of file.

END



