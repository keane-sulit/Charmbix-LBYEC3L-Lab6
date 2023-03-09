int counter = 0;                // Artificial prescaler counter
void interrupt() {
    INTCON.f7 = 0;              // Disable Global Interrupt
    
    if(INTCON.f2 == 1) {        // Check if TMR0 Interrupt Flag is set
        if(counter == 50) {     // Higher prescaler value, slower blinking
            PORTC = ~PORTC;     // Turn on all LEDs
            counter = 0;
        }
        else
            counter++;          // Increment counter
    
    INTCON.f2 = 0;          // Clear TMR0 Interrupt Flag
    }

    INTCON.f7 = 1;              // Enable Global Interrupt
}

void main() {
    INTCON.f7 = 1;      // Enable Global Interrupt
    INTCON.f6 = 1;      // Enable Peripheral Interrupt
    INTCON.f5 = 1;      // Enable TMR0 Interrupt
    TRISC = 0x00;       // Set PORTC as Output
    OPTION_REG.f5 = 0;  // Set TMR0 Prescaler to 1:256
    OPTION_REG.f3 = 0;  // Set TMR0 Clock Source to Fosc/4
    OPTION_REG.f2 = 1;  // Set TMR0 Clock Source to Fosc/4
    OPTION_REG.f1 = 1;  // Set TMR0 Clock Source to Fosc/4
    OPTION_REG.f0 = 1;  // Set TMR0 Clock Source to Fosc/4
    PORTC = 0x00;       // Turn off all LEDs
}