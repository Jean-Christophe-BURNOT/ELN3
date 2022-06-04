;-----------------------------------------------------------------------------
;
;  FILE NAME   :  MAIN_SM4.ASM 
;  TARGET MCU  :  C8051F020 
;  

;-----------------------------------------------------------------------------
$include (c8051f020.inc)               ; Include register definition file. 
;-----------------------------------------------------------------------------
;Declarations Externes
EXTRN code (__tempo,Config_Timer3_BT,Init_pgm)
EXTRN code ( _Read_code_CO,_Read_Park_IN,_Read_Park_OUT,_Decod_BIN_to_BCD_CO,_Display_CO,_Test_Code_CO,_Stockage_Code_CO)
;-----------------------------------------------------------------------------
; EQUATES
;-----------------------------------------------------------------------------
GREEN_LED      	equ   	P1.6             ; Port I/O pin connected to Green LED.

; Put the STACK segment in the main module.
;------------------------------------------------------------------------------
?STACK          SEGMENT IDATA           ; ?STACK goes into IDATA RAM.
                RSEG    ?STACK          ; switch to ?STACK segment.
                DS      30              ; reserve your stack space
                                        ; 30 bytes in this example.
;-----------------------------------------------------------------------------
; XDATA SEGMENT
;-----------------------------------------------------------------------------
Ram_externe    SEGMENT XDATA     ; Reservation de 50 octets en XRAM
               RSEG    Ram_externe  
Tab_histo:     DS      150
;-----------------------------------------------------------------------------
; RESET and INTERRUPT VECTORS
;-----------------------------------------------------------------------------
               ; Reset Vector
               cseg AT 0          ; SEGMENT Absolu
               ljmp Start_pgm     ; Locate a jump to the start of code at 
                                  ; the reset vector.
								  
								  ; Timer3 Interrupt Vector
               cseg AT 073H         ; SEGMENT Absolu
               ljmp ISR_Timer3     ; Locate a jump to the start of code at 
                                  ; the reset vector.
;-----------------------------------------------------------------------------
; CODE SEGMENT
;-----------------------------------------------------------------------------
Prog_base      segment  CODE

               rseg     Prog_base      ; Switch to this code segment.
               using    0              ; Specify register bank for the following
                                       ; program code.
									   
Tab_code: DB 0Ah,01h,02h,04h,08h,10h,20h,03h,06h,0CH,18H,30H,07h,0Eh,1CH,38H									   
Display_7S: DB 040h,079h,024h,030h,019h,012h,002h,078h,000h,010h,008h,003h,046h,021h,006h,00Eh
;******************************************************************************
;Initialisations de périphériques - Fonctionnalités Microcontroleur
;******************************************************************************
Start_pgm:
        mov   sp,#?STACK-1   ; Initialisation de la pile
        call Init_pgm        ; Appel SP de configuration du processeur
		mov  R6,#0B7H        ; Passage des paramètres pour l'appel de  Config_Timer3_BT
		mov  R7,#0EDH;       ; Valeur passée: 0B7EDH pour un période timer3 de 10mS 
		CALL Config_Timer3_BT ; Configuration du timer 3
		
        clr   GREEN_LED       ; Initialize LED to OFF
		setb EA               ; Validation globale des interruptions
		
;******************************************************************************
; Programme Principal
;******************************************************************************
Main:
      ; Vous pouvez insérer ici du code de l'application
	 mov r1, 0
	 mov r2, 0
	 mov r3, 0
	 cjne @r1, 1, _Read_code_CO
	 call	_Test_Code_CO
	 cjne	R7, 1
	 cjne r3, 8h
	 jc sp8
     jmp   	Main
;******************************************************************************
; Programme d'interruption Timer3
;******************************************************************************
ISR_Timer3:
       PUSH PSW
	   PUSH ACC
       MOV A,TMR3CN
	   CLR ACC.7
	   MOV TMR3CN,A
	   
	   call _Read_Park_IN
	   jc 
	   mov R1, 1
	   
	   call _Read_Park_OUT
	   jc
	   mov R2, 1
	   ; Vous pouvez insérer ici du code de l'application 
		
	   POP ACC
	   POP PSW
	   reti
;-----------------------------------------------------------------------------
; End of file.

END



