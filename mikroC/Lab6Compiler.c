int counter = 0;            // Artificial prescaler counter
void interrupt () {
    INTCON.f7 = 0;          // Disable global interrupt

    // Switch at RB0
    if(INTCON.f1 == 1) {
        PORTC.f0 = 0;       //LED1 off
        PORTC.f1 = 1;       //LED2 on
        delay_ms(1000);
        PORTC.f1 = 0;       //LED2 off
        INTCON.f1 = 0;
    }
    
    // If TMRO overflow flag is set
    else if(INTCON.f2 == 1) {
        // If counter is 10, toggle LED1
        if(counter == 10) {
            PORTC.f0 = ~PORTC.f0;
            counter = 0;
        }
        // Increment counter
        else {
            counter++;
        }

        INTCON.f2 = 0;      // Clear TMR0 overflow flag
    }

    INTCON.f7 = 1;          // Enable global interrupt
}

void init() {
    INTCON.f7 = 1;          // Enable global interrupt
    INTCON.f6 = 1;          // Enable peripheral interrupt
    INTCON.f5 = 1;          // Enable TMR0 overflow interrupt
    INTCON.f4 = 1;          // Enable RB port change interrupt
    OPTION_REG.f5 = 0;      // Internal clock for TMR0
    OPTION_REG.f3 = 0;      // Prescaler assigned to TMR0
    OPTION_REG.f2 = 1;      // Prescaler 1:256
    OPTION_REG.f1 = 1;      // Prescaler 1:256
    OPTION_REG.f0 = 1;      // Prescaler 1:256
}

void main() {
    init();
    TRISC = 0x00;           // PORTC as output
    PORTC = 0x00;
}