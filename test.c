volatile unsigned int * const UART0DR = (unsigned int *)0x101f1000; 
//volatile unsigned int * const UART0DR = (unsigned int *)0x10009000;
#define TIMER0 0x101e2000
volatile unsigned int * const Timer1Load = (unsigned int*)(TIMER0 + 0);
volatile unsigned int * const Timer1Control = (unsigned int*)(TIMER0 + 0x08);

volatile unsigned int * const PIC_IntEnable = (unsigned int*)0x10140010;

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
	volatile unsigned int val;
	print_uart0("Try to setup timer\n");
//	val = *Timer1Control;
//	val = 0x0a0;
//	*Timer1Control = val;

	*Timer1Control = 0x42;
	*PIC_IntEnable = 0x010;
	*Timer1Load = 0x80b0;
	*Timer1Control = 0xe2;

//	val = *Timer1Load;
//	val = 0x10;
//	*Timer1Load = val;
}

