
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Lab6Compiler.c,2 :: 		void interrupt () {
;Lab6Compiler.c,3 :: 		INTCON.f7 = 0;          // Disable global interrupt
	BCF        INTCON+0, 7
;Lab6Compiler.c,6 :: 		if(INTCON.f1 == 1) {
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt0
;Lab6Compiler.c,7 :: 		PORTC.f0 = 0;       //LED1 off
	BCF        PORTC+0, 0
;Lab6Compiler.c,8 :: 		PORTC.f1 = 1;       //LED2 on
	BSF        PORTC+0, 1
;Lab6Compiler.c,9 :: 		delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_interrupt1:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt1
	DECFSZ     R12+0, 1
	GOTO       L_interrupt1
	DECFSZ     R11+0, 1
	GOTO       L_interrupt1
	NOP
;Lab6Compiler.c,10 :: 		PORTC.f1 = 0;       //LED2 off
	BCF        PORTC+0, 1
;Lab6Compiler.c,11 :: 		INTCON.f1 = 0;
	BCF        INTCON+0, 1
;Lab6Compiler.c,12 :: 		}
	GOTO       L_interrupt2
L_interrupt0:
;Lab6Compiler.c,15 :: 		else if(INTCON.f2 == 1) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt3
;Lab6Compiler.c,17 :: 		if(counter == 10) {
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt8
	MOVLW      10
	XORWF      _counter+0, 0
L__interrupt8:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt4
;Lab6Compiler.c,18 :: 		PORTC.f0 = ~PORTC.f0;
	MOVLW      1
	XORWF      PORTC+0, 1
;Lab6Compiler.c,19 :: 		counter = 0;
	CLRF       _counter+0
	CLRF       _counter+1
;Lab6Compiler.c,20 :: 		}
	GOTO       L_interrupt5
L_interrupt4:
;Lab6Compiler.c,23 :: 		counter++;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;Lab6Compiler.c,24 :: 		}
L_interrupt5:
;Lab6Compiler.c,26 :: 		INTCON.f2 = 0;      // Clear TMR0 overflow flag
	BCF        INTCON+0, 2
;Lab6Compiler.c,27 :: 		}
L_interrupt3:
L_interrupt2:
;Lab6Compiler.c,29 :: 		INTCON.f7 = 1;          // Enable global interrupt
	BSF        INTCON+0, 7
;Lab6Compiler.c,30 :: 		}
L_end_interrupt:
L__interrupt7:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_init:

;Lab6Compiler.c,32 :: 		void init() {
;Lab6Compiler.c,33 :: 		INTCON.f7 = 1;          // Enable global interrupt
	BSF        INTCON+0, 7
;Lab6Compiler.c,34 :: 		INTCON.f6 = 1;          // Enable peripheral interrupt
	BSF        INTCON+0, 6
;Lab6Compiler.c,35 :: 		INTCON.f5 = 1;          // Enable TMR0 overflow interrupt
	BSF        INTCON+0, 5
;Lab6Compiler.c,36 :: 		INTCON.f4 = 1;          // Enable RB port change interrupt
	BSF        INTCON+0, 4
;Lab6Compiler.c,37 :: 		OPTION_REG.f5 = 0;      // Internal clock for TMR0
	BCF        OPTION_REG+0, 5
;Lab6Compiler.c,38 :: 		OPTION_REG.f3 = 0;      // Prescaler assigned to TMR0
	BCF        OPTION_REG+0, 3
;Lab6Compiler.c,39 :: 		OPTION_REG.f2 = 1;      // Prescaler 1:256
	BSF        OPTION_REG+0, 2
;Lab6Compiler.c,40 :: 		OPTION_REG.f1 = 1;      // Prescaler 1:256
	BSF        OPTION_REG+0, 1
;Lab6Compiler.c,41 :: 		OPTION_REG.f0 = 1;      // Prescaler 1:256
	BSF        OPTION_REG+0, 0
;Lab6Compiler.c,42 :: 		}
L_end_init:
	RETURN
; end of _init

_main:

;Lab6Compiler.c,44 :: 		void main() {
;Lab6Compiler.c,45 :: 		init();
	CALL       _init+0
;Lab6Compiler.c,46 :: 		TRISC = 0x00;           // PORTC as output
	CLRF       TRISC+0
;Lab6Compiler.c,47 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;Lab6Compiler.c,48 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
