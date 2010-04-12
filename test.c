volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000; 
//volatile unsigned int * const UART0DR = (unsigned int *)0x10009000;
#define TIMER0 0x101e2000
volatile unsigned int * const Timer1Load = (unsigned int*)(TIMER0 + 0);
volatile unsigned int * const Timer1Control = (unsigned int*)(TIMER0 + 0x08);

void print_uart0(const char *s) {
    while(*s != '\0') { /* Loop until end of string */
	*UART0DR = (unsigned int)(*s); /* Transmit char */
	s++; /* Next char */
    }
}

void c_entry() {
    print_uart0("Hello world!\n");
}

void data_entry()
{
    print_uart0("data error...\n");
}

void itoa(unsigned int data)
{
        char tmp[10];
        int i,d;
        for (i = 0; i < 8; ++i) {
                d = data % 16;
                tmp[7-i] = d + '0';
                if (d > 9) {
                        tmp[7-i] = d - 10 + 'A';
                } else {
                        tmp[7-i] = d + '0';
                }
                data /= 16;
        }
	tmp[8] = '\n';
	tmp[9] = 0;
	print_uart0(tmp);
}

void setup_timer()
{
	print_uart0("Try to setup timer\n");
	*Timer1Load = 0x10;
	*Timer1Control = 0x0A1;
}

