int main();
void printc(char b);
void prints(char *c);
void exits();
void cls();
void int_to_string(int value, char *str);
int video=0xb8000;
static inline unsigned short get_ds(void) {
    unsigned short seg;
    __asm__ __volatile__ (
        "mov %%ds, %0"
        : "=r"(seg)
        :
        :
    );
    return seg;
}
int main(){
       char c[1024];
       char *cc="hello world.....";
       int i=0;
       video=0xb8000;
       cls();
       i=get_ds();
       int_to_string(i,c);
       prints(c);
       i=*cc;
       int_to_string(i,c);
       prints(c);
       while(1){}
       exits();

}
int _main(){
     main();
}
int __main(){
     main();
}

void printc(char b)
        {
        int i=video;
	char *fbp=(char* )i;
	*((char *)(fbp)) =(char)b;
	*((char *)(fbp+1)) =(char)0x67;
	video++;
	video++;
          
        }

void prints(char *c)
{
        int counter=0;
	while(c[counter]!=0){
		printc(c[counter]);
		counter++;
	}
        video=video +60;
}
void exits(){
    halts:
    goto halts;
    
}
void cls(){

char *dest=(char* )0xb8000;
int i=0;
int length=4000;
unsigned int value=0x67;
    // Cast o ponteiro para unsigned char* para permitir o preenchimento byte a byte
    unsigned char *d = (unsigned char *)dest;

    // Preencha os bytes da memória com o valor especificado
    for (i = 0; i < length; i=i+2) {
        d[i] = 32;
        d[i+1] = value;
    }
}
void int_to_string(int value, char *str) {
    char temp[12];
    int i = 0;
    int is_neg = 0;

    // Tratar número zero
    if (value == 0) {
        str[0] = '0';
        str[1] = '\0';
        return;
    }

    // Tratar negativo
    if (value < 0) {
        is_neg = 1;
        value = -value;
    }

    // Extrair dígitos ao contrário
    while (value > 0) {
        int digit = value % 10;
        temp[i++] = '0' + digit;
        value /= 10;
    }

    // Adicionar sinal se necessário
    if (is_neg) {
        temp[i++] = '-';
    }

    // Inverter para str final
    int j = 0;
    i--;
    while (i >= 0) {
        str[j++] = temp[i--];
    }

    str[j] = '\0';
}
