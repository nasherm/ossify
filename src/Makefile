SOURCE := kernel.o kernel_entry.o kernel.bin bootsect.bin os-image.bin

all: $(SOURCE)

kernel.o: kernel.c
	i386-elf-gcc -ffreestanding -c $^ -o $@

kernel_entry.o: kernel_entry.asm
	nasm $^ -f elf -o $@

kernel.bin: kernel_entry.o kernel.o
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

bootsect.bin: bootsect.asm
	nasm $^ -f bin -o $@

os-image.bin: bootsect.bin kernel.bin
	mkdir -p ../build; cat $^ > ../build/$@

run:
	qemu-system-i386 -fda os-image.bin
