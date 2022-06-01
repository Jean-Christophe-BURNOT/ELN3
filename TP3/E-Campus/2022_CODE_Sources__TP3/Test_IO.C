//------------------------------------------------------------------------------------
// Test_IO.C
//------------------------------------------------------------------------------------
// AUTH: FJ
// DATE: 09-05-2022
// Target: C8051F02x
// Tool chain: KEIL Eval 'c'
//------------------------------------------------------------------------------------
// Fonction de Test pour TP SM3 - ELN3
// Ce programme produit des cycles d'écriture en XDATA de l'adresse 0 à l'adresse F800H
// par pas de 800H - Adresses produites: 000, 800H, 1000H, 1800H..........  F000H, F800H
// Le signal SLC1 (P4.0) sert de repère pour le cycle de test
// Une impulsion large sur SLC1 indique le début d'un cycle de test
// Les impulsions courtes sur SLC1 indiquent les cycles de Test sur les adresses
// de 000 à F800H
// Pour chaque adresse testée, on met à 1 les LED, puis on les remet à 0
//
// Si le décodage est OK (de 5000H à 5FFFH) on devrait obtenir 2 (et seulement 2 )impulsions
// (sur les 32 impulsions) quand on observe un des signaux LED.
// Au niveau de l'oscilloscope:
// Voie 1 - Visu et déclenchement sur SLC1 - Décleclenchement sur durée d'impulsion supérieure à
//  200 micro-secondes
// Voie 2 - Visu d'un des signaux LED
//
// Utilation de ce programme de TEST: dans le fichier Base_TP3, appeler ce sous-programme
// par un call Test_IO et le faire exécuter en boucle

//------------------------------------------------------------------------------------
// Includes
//------------------------------------------------------------------------------------
#include <c8051f020.h>                    // SFR declarations
//------------------------------------------------------------------------------------
// Global CONSTANTS
//------------------------------------------------------------------------------------

#define SYSCLK 22118400 //approximate SYSCLK frequency in Hz
#define LED_On 1
#define LED_Off 0
#define SET_SLC1  P4 |= (1<<0)
#define CLR_SLC1  P4 &= ~(1<<0)


// Eléments présents sur la carte 8051F020
sbit  LED = P1^6;         // LED verte: '1' = ON; '0' = OFF
sbit BP = P3^7;           // Bouton Poussoir '1' relaché, '0' pressé

// Eléments de l'application Pilotage d'un système de tri
sbit Tst4 = P3^4;
sbit Tst5 = P3^5;
sbit Tst6 = P3^6;

//------------------------------------------------------------------------------------
// Function PROTOTYPES
//------------------------------------------------------------------------------------

void _tempo(unsigned int);     // Fonction assembleur codée dans Asm_8051_Lib.asm


void Test_IO (void) {

char xdata * Ptr_xdata;
unsigned char Cp_bcl;	
Ptr_xdata = 0x5000;
*Ptr_xdata=0;
	
SET_SLC1;
_tempo(400);
CLR_SLC1;
_tempo(100);
Ptr_xdata = 0;
for(Cp_bcl=0;Cp_bcl<32;Cp_bcl++)
{
SET_SLC1;
*Ptr_xdata = 0XFF;
_tempo(20);
CLR_SLC1;
*Ptr_xdata = 0X00;	
_tempo(40);
Ptr_xdata += 0x800;	
}
tempo(400);
LED = ~LED;
   
}

