
all:
	cd src; make

debug:
	cd src; make debug

run:
	cd src; qemu-system-i386 -drive file=os-image.bin,index=0,if=floppy,format=raw

clean:
	rm src/*.bin

.PHONY: all $(SUBDIRS)
