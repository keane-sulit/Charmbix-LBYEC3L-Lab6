#line 1 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Lab6/mikroC/Lab6Compiler.c"
int counter = 0;
void interrupt () {
 INTCON.f7 = 0;


 if(INTCON.f1 == 1) {
 PORTC.f0 = 0;
 PORTC.f1 = 1;
 delay_ms(1000);
 PORTC.f1 = 0;
 INTCON.f1 = 0;
 }


 else if(INTCON.f2 == 1) {

 if(counter == 10) {
 PORTC.f0 = ~PORTC.f0;
 counter = 0;
 }

 else {
 counter++;
 }

 INTCON.f2 = 0;
 }

 INTCON.f7 = 1;
}

void init() {
 INTCON.f7 = 1;
 INTCON.f6 = 1;
 INTCON.f5 = 1;
 INTCON.f4 = 1;
 OPTION_REG.f5 = 0;
 OPTION_REG.f3 = 0;
 OPTION_REG.f2 = 1;
 OPTION_REG.f1 = 1;
 OPTION_REG.f0 = 1;
}

void main() {
 init();
 TRISC = 0x00;
 PORTC = 0x00;
}
