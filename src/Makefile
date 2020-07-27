SOURCE_TARGETS := kernel.o kernel_entry.o kernel.bin bootsect.bin os-image.bin
ASM_UTILS := $(wildcard ./boot/*)
KERNEL := $(wildcard ./kernel/*)
all: $(SOURCE_TARGETS)

kernel.o: $(KERNEL)
	i386-elf-gcc -ffreestanding -c $^ -o $@

kernel_entry.o: boot/kernel_entry.asm
	nasm $^ -f elf -o $@

kernel.bin: kernel_entry.o kernel.o
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

bootsect.bin: $(ASM_UTILS)
	nasm boot/bootsect.asm -f bin -o $@

os-image.bin: bootsect.bin kernel.bin
	mkdir -p ../build; cat $^ > ../build/$@

clean:
	rm $(SOURCE_TARGETS)


