CC=/home/shane/android/prebuilt/linux-x86/toolchain/arm-eabi-4.4.0/bin/arm-eabi

test.bin: *.s *.c test.ld
	$(CC)-as -mcpu=arm926ej-s -g startup.s -o startup.o
	$(CC)-gcc -c -mcpu=arm926ej-s -g test.c -o test.o
	$(CC)-ld -T test.ld test.o startup.o -o test.elf
	$(CC)-objcopy -O binary test.elf test.bin

clean:
	rm -rf *.o test.elf test.bin *~

