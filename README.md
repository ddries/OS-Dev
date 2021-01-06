# OS Dev repository

[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.png?v=103)](https://github.com/DriesCode/OS-Dev/blob/master/LICENSE)
[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://github.com/DriesCode/OS-Dev)

## Directories:
- boot/ : Everything related to boot process. Everything in assembly language.
- include/ : Files with routines used by more than one file.
- bin/ : Raw binary files.
- kernel/ : Everything related to kernel. 
- img/ : Image of the OS. Ready to be executed in emulators or real hardware.
- shell/ : Everything related to the 16 bit shell.
## Files:
### Main files:
- boot.asm: First stage bootloader. BPB for FDD emulation, segment registers and stack setup and second stage bootloader load.
- second_bootloader.asm: Second stage bootloader. Currently, menu to choose between loading the 32-bit Kernel or 16-bit shell.
- shell.asm: 16-bit shell in real mode. Currently, no commands available. Only printing pressed keys.
- 32b.asm: File that loads protected mode. GDT, GDT descriptor and routine to test if 32b is running by printing an 'A' to (0,0).
- k.asm: Kernel entry point.
- kernel.c: Kernel

### Include files:
- screen.inc: Include file with all screen-related routines. Currently, string printing routine and video mode/cursor configuration.

### Other files:
- makefile: Used to compile the OS in UNIX. Currently, I have no file to compile in Windows. By the way, you can copy source code and compile yourself very easy.

## Warnings:
### Non-dangerous:
- 16-bit Shell is a bit buggy.
- If you press a different key of the displayed ones at any time user input is needed, computer will halt. It's not a bug but a coded feature. Just follow the instructions.
- If an error occurs at any time of the boot process, computer will halt. It's a coded feature to prevent damaging the computer. You'll need to restart the PC.

## How to build
To build the OS, make use of the makefile. Currently, it only supports UNIX-like environments.
To do so, use `make media=_foo_` where _foo_ is the name of the file or the media where you want to compile the OS.
For example, you could do: `make media=img/os.img` or `make media=/dev/sdb`.
If you want to test the OS with an *.img* file, you might need to create it before running the makefile. To do so, simply use UNIX's *dd* program --> `dd if=/dev/zero of=os.img bs=1024 count=1440`

## Running
### Emulating
My preference is QEMU. I'm using this tool to test the OS while developing it without having to restart the computer. However, you can use other tools as Bochs or Virtualbox, but you might need to do extra work to get the desired file image of the OS to test it in those programs, as building an ISO file or a configuration file for Bochs.

Using QEMU, you can launch the OS by `qemu-system-i386 img/os.img`.

### Real Hardware
Bootloder is programmed to work as a Floppy Disk. I recommed you burning the OS into a USB stick as it's how I'm doing it. You can use CDs too but extra work may be necessary.
You may need to modify BIOS boot options to give more preference to the bootable media you are using than to your main OS (Windows, Linux, Mac...).
