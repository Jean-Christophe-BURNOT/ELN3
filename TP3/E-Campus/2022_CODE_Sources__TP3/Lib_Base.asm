;******************************************************************************
;Lib_Baser.asm

;   Ce fichier contient des d�finitions et des routines utiles au TP SM
;   Aucune modification n'est n�cessaire.
;   Il suffit d'ajouter ce fichier � votre Projet
;   TARGET MCU  :  C8051F020 
;******************************************************************************
$INCLUDE(C8051F020.INC)	; Register definition file.
;******************************************************************************
;Declaration des variables et fonctions publiques
;******************************************************************************
PUBLIC   __tempo
PUBLIC   __tempo_20US
PUBLIC   __tempo_100US
PUBLIC   Init_pgm

;******************************************************************************
;D�clarations de p�riph�riques

BRD_GREEN_LED      EQU       P1.6
BP                 EQU       P3.7

;******************************************************************************
;Consignes de segmentation
;******************************************************************************
zone_data     segment  DATA
              rseg     zone_data
tampon:       ds       6

Lib_TP_SM     segment  CODE
			  rseg     Lib_TP_SM     ; Switch to this code segment.
              using    0             ; Specify register bank for the following
                                     ; program code.

;******************************************************************************
;Initialisations de la m�moire code - Stockage de constante
;******************************************************************************

;******************************************************************************
;Init_pgm
;
; Description: Initialisations de p�riph�riques
;              Fonctionnalit�s Microcontroleur
;              Configuration acc�s m�moire sur P4,5,6 et 7
;              Acces en mode multiplex�.
;              Sorties en Push-Pull sauf pour P4 en Drain ouvert
;              Config SYSCLK:  Quartz externe
;              

; Param�tres d'entr�e: Aucun
; Param�tres de sortie: Aucun
; Registres modifi�s: Beaucoup!!!  En fait les registres de config du
;                                  circuit 
;                                 
; Pile: 0 octet (sauf pour l'appel de la sous -routine)
;******************************************************************************
Init_pgm:
         mov WDTCN, #0DEh    ; Disable WDT
         mov WDTCN, #0ADh
; Configure the XBRn Registers
         mov XBR0, #004h     ; UART0 rout�e sur P0.0 et P0.1
         mov XBR1, #094h     ; INT0 rout�e sur P0.2, INT1 sur P0.3 et Sysclock rout�e sur P0.4
         mov XBR2, #040h     ; Crossbar valid�

; Port configuration (1 = Push Pull Output)
         mov P0MDOUT,#011h   ; Output configuration for P0 
         mov P1MDOUT,#0FFh   ; Output configuration for P1 - Tout en Push-Pull
         mov P2MDOUT,#000h   ; Output configuration for P2 
         mov P3MDOUT,#000h   ; Output configuration for P3 
         mov P74OUT,#0FFh    ; P4, P5, P6 et P7 configur�s en Push Pull
         mov P1MDIN,#0FFh    ; Pas d'entr�e analogique sur P1
         mov P4,#0DFh        ; ALE=0, /RD=1, /WR=1 en dehors des cycles m�moires
		 setb P0.2           ; Broche P0.2 - INT0 Configur�e en entr�e
         setb P0.3		     ; Broche P0.3 - INT1 Configur�e en entr�e
		 setb P3.7           ; Broche P3.7 - INT7 Configur�e en entr�e
		 clr P1.6

; Configure External Memory Configuration
         mov EMI0CF, #026h   ; External Memory Configuration Register
         mov EMI0TC, #0BAh   ; External Memory Configuration Register

; Oscillator Configuration
         mov OSCXCN, #067h   ; External Oscillator Control Register	
         clr A               ;osc
         djnz ACC, $         ;wait for
         djnz ACC, $         ;at least 1ms
OX_WAIT:
         mov A, OSCXCN
         jnb ACC.7, OX_WAIT  ;poll XTLVLD
         mov OSCICN, #008h   ; Internal Oscillator Control Register
                             ; On bascule sur l'oscillateur externe 
                             ; � 22118400            
         mov RSTSRC, #000h   ; Reset Source Register
        
; FIN de Init_Pgm		 
		 ret
		 
;******************************************************************************
; Gestion du Timer 3
; Routines permettant de mettre en oeuvre le timer 3
;
;******************************************************************************

;******************************************************************************                
; Config_Timer3_BT
;
; Description: Sous-programme configurant le Timer3 pour fonctionner en
;              Re-chargement automatique. Le timer va g�n�rer un overflow 
;              toutes les ((65535-N) * 0.542) micro-secondes. 
;
; Param�tres d'entr�e:  N dans R6(MSB) et R7(LSB)
; Param�tres de sortie: aucun
; Registres modifi�s: TMR3RLL,TMR3RLH,TMR3H,TMR3L,TMR3CN
; Pile: 0 octet (sauf pour l'appel de la sous -routine)
;******************************************************************************
; ATTENTION!!!   Il est imp�ratif de remettre � z�ro, par programme, le 
;*************   Timer3 Overflow Flag.  
;******************************************************************************

Config_Timer3_BT:


         mov TMR3RLL, R7   ; Timer 3 Reload Register Low Byte
         mov TMR3RLH, R6   ; Timer 3 Reload Register High Byte
         mov TMR3H, R6     ; Ti mer 3 High Byte
         mov TMR3L, R7     ; Timer 3 Low Byte
         mov TMR3CN, #006h ; Timer 3 Control Register
         ret

;******************************************************************************
;******************************************************************************
; __tempo
;
; Description: Sous-programme produisant une temporisation logicielle
;              param�trable par la variable csg_tempo.
;              La temporisation g�n�r�e est �gale � csg_tempo micro-secondes.
;              ATTENTION: csg_tempo ne doit pas �tre inf�rieure � 2
;
; Param�tres d'entr�e:  csg_tempo dans R6(MSB) et R7(LSB)
; Param�tres de sortie: aucun
; Registres modifi�s: R6 et R7
; Pile: 2 octets 
;******************************************************************************
__tempo:
        PUSH  ACC
        MOV   A,R5
        PUSH  ACC
        MOV  A,R7
        DEC  R7
        JNZ   ?C0006
        DEC   R6
?C0006:
?C0001:
         MOV  A,R7
         ORL  A,R6
         JZ   ?C0005

         MOV  A,R7
         DEC  R7
         JNZ  ?C0007
         DEC  R6
?C0007:
         MOV  R5,#01H
?C0003:
         MOV  A,R5
         JZ   ?C0001
         DEC  R5
         SJMP ?C0003
?C0005:
         POP ACC
         MOV R5,ACC
         POP ACC  
         RET  	
		 
;******************************************************************************
;******************************************************************************
; __tempo_20US
;
; Description: Sous-programme produisant une temporisation logicielle de 20US (environ)
;             
;
; Param�tres d'entr�e:  aucun
; Param�tres de sortie: aucun
; Registres modifi�s: aucun
; Pile: 2 octets 
;******************************************************************************
__tempo_20US:
        PUSH    AR6
		PUSH    AR7
		MOV    	R7,#20 ; Passage de param�tres avant l'appel de __tempo
 		MOV    	R6,#00
		CALL   	__tempo
        POP     AR7
        POP     AR6		
        RET  	
;******************************************************************************
;******************************************************************************
; __tempo_100US
;
; Description: Sous-programme produisant une temporisation logicielle de 100US (environ)
;             
;
; Param�tres d'entr�e:  aucun
; Param�tres de sortie: aucun
; Registres modifi�s: aucun
; Pile: 2 octets 
;******************************************************************************
__tempo_100US:
        PUSH    AR6
		PUSH    AR7
		MOV    	R7,#100 ; Passage de param�tres avant l'appel de __tempo
 		MOV    	R6,#00
		CALL   	__tempo
        POP     AR7
        POP     AR6		
        RET  	

end