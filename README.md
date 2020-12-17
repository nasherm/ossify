# Introduction
A 32bit x86 hobby OS

# Setup
## Build tools
A few tools need to be installed first install binutils with the following commands. First set some environment variables

    export PREFIX="/usr/local/i386elfgcc"
    export TARGET=i386-elf
    export PATH="$PREFIX/bin:$PATH"

Then install binutils

    $ cd /tmp/src/
    # Download a recent version of binutils into this directory, project was developed with binutils 2.35
    ...
    $ cd binutils-build
    $ ../binutils/configure --target=$TARGET --enable-interwork --enable-multilib --disable-nls --disable-werror --prefix=$PREFIX 2>&1 | tee configure.log
    $ make all install 2>&1 | tee make.log

Then install gcc

    # Download gcc, project was built with GCC 10.2
    ...
    $ cd gcc-build
    $ ../gcc/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --disable-libssp --enable-languages=c --without-headers
    $ make all-gcc 
    $ make all-target-libgcc 
    $ make install-gcc 
    $ make install-target-libgcc 

## Debugging
To debug and develop one has to follow a similar process as with building to build GDB.

    $ cd /tmp/src
    # Download a recent version of GDB
    ...
    $ cd gdb-build
    $ ../gdb/configure --target="$TARGET" --prefix="$PREFIX" --program-prefix=i386-elf-
    $ make
    $ make install

Now you have all the tools you need to hack

# Build
## Main

    make
    make run

## Debug
    make debug
