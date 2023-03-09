#line 1 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Lab6/mikroC/Lab6Compiler.c"
void interrupt() {
 INTCON.f7 = 0;
 if(INTCON.f2 == 1) {
 PORTC = ~PORTC;
 INTCON.f2 = 0;
 }
 INTCON.f7 = 1;
}

void main() {
 INTCON.f7 = 1;
 INTCON.f6 = 1;
 INTCON.f5 = 1;
 TRISC = 0x00;
 OPTION_REG.f5 = 0;
 OPTION_REG.f3 = 0;
 OPTION_REG.f2 = 1;
 OPTION_REG.f1 = 1;
 OPTION_REG.f0 = 1;

}
