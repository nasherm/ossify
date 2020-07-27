SUBDIRS := src/

all: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@

run:
	qemu-system-i386 -drive file=build/os-image.bin,index=0,if=floppy,format=raw

clean:
	rm src/*.bin

.PHONY: all $(SUBDIRS)
