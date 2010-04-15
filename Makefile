CC=/home/shane/toolchain/arm-eabi-4.4.0/bin/arm-eabi

all: test.bin

startup.o:startup.s
	$(CC)-as -mcpu=arm926ej-s -g startup.s -o startup.o

test.o:test.c
	$(CC)-gcc -c -mcpu=arm926ej-s -g test.c -o test.o

test.bin:startup.o test.o
	$(CC)-ld -T test.ld test.o startup.o -o test.elf
	$(CC)-objcopy -O binary test.elf test.bin

clean:
	rm -rf *.o test.elf test.bin *~

