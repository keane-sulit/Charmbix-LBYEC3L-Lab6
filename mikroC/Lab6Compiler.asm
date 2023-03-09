
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Lab6Compiler.c,1 :: 		void interrupt() {
;Lab6Compiler.c,2 :: 		INTCON.f7 = 0;          // Disable Global Interrupt
	BCF        INTCON+0, 7
;Lab6Compiler.c,3 :: 		if(INTCON.f2 == 1) {    // Check if TMR0 Interrupt Flag is set
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;Lab6Compiler.c,4 :: 		PORTC = ~PORTC;         // Turn on all LEDs
	COMF       PORTC+0, 1
;Lab6Compiler.c,5 :: 		INTCON.f2 = 0;      // Clear TMR0 Interrupt Flag
	BCF        INTCON+0, 2
;Lab6Compiler.c,6 :: 		}
L_interrupt0:
;Lab6Compiler.c,7 :: 		INTCON.f7 = 1;          // Enable Global Interrupt
	BSF        INTCON+0, 7
;Lab6Compiler.c,8 :: 		}
L_end_interrupt:
L__interrupt2:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Lab6Compiler.c,10 :: 		void main() {
;Lab6Compiler.c,11 :: 		INTCON.f7 = 1;      // Enable Global Interrupt
	BSF        INTCON+0, 7
;Lab6Compiler.c,12 :: 		INTCON.f6 = 1;      // Enable Peripheral Interrupt
	BSF        INTCON+0, 6
;Lab6Compiler.c,13 :: 		INTCON.f5 = 1;      // Enable TMR0 Interrupt
	BSF        INTCON+0, 5
;Lab6Compiler.c,14 :: 		TRISC = 0x00;       // Set PORTC as Output
	CLRF       TRISC+0
;Lab6Compiler.c,15 :: 		OPTION_REG.f5 = 0;  // Set TMR0 Prescaler to 1:256
	BCF        OPTION_REG+0, 5
;Lab6Compiler.c,16 :: 		OPTION_REG.f3 = 0;  // Set TMR0 Clock Source to Fosc/4
	BCF        OPTION_REG+0, 3
;Lab6Compiler.c,17 :: 		OPTION_REG.f2 = 1;  // Set TMR0 Clock Source to Fosc/4
	BSF        OPTION_REG+0, 2
;Lab6Compiler.c,18 :: 		OPTION_REG.f1 = 1;  // Set TMR0 Clock Source to Fosc/4
	BSF        OPTION_REG+0, 1
;Lab6Compiler.c,19 :: 		OPTION_REG.f0 = 1;  // Set TMR0 Clock Source to Fosc/4
	BSF        OPTION_REG+0, 0
;Lab6Compiler.c,21 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
