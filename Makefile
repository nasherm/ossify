SUBDIRS := src/

all: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@

run:
	qemu-system-i386 -fda build/os-image.bin

.PHONY: all $(SUBDIRS)
