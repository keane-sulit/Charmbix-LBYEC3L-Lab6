void interrupt() {
    INTCON.f7 = 0;          // Disable Global Interrupt

    if(INTCON.f1 == 1) {    // Check if TMR0 Interrupt
        PORTC.f0 = 0;       // Turn off LED
        delay_ms(1000);     // Wait 1 second
        INTCON.f1 = 0;      // Clear TMR0 Interrupt Flag
    }

    INTCON.f7 = 1;          // Enable Global Interrupt
}

void main() {
    INTCON.f7 = 1;      // Enable Global Interrupt
    INTCON.f6 = 1;      // Enable Peripheral Interrupt
    INTCON.f4 = 1;      // Enable TMR0 Interrupt
    TRISC = 0x00;
    while(1) {
        PORTC = 0xFF;
        delay_ms(500);
        PORTC = 0x00;
        delay_ms(500);
    }
}