SOURCE_TARGETS := kernel.o kernel_entry.o kernel.bin bootsect.bin os-image.bin
ASM_UTILS := $(wildcard ./asm_utils/*)
all: $(SOURCE_TARGETS)

kernel.o: kernel.c
	i386-elf-gcc -ffreestanding -c $^ -o $@

kernel_entry.o: kernel_entry.asm
	nasm $^ -f elf -o $@

kernel.bin: kernel_entry.o kernel.o
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

bootsect.bin: bootsect.asm $(ASM_UTILS)
	nasm bootsect.asm -f bin -o $@

os-image.bin: bootsect.bin kernel.bin
	mkdir -p ../build; cat $^ > ../build/$@

clean:
	rm $(SOURCE_TARGETS)


