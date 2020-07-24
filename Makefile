

boot: boot.asm
	nasm $^ -o $@.bin


run: boot.bin
	qemu $^
