# OS Dev repository
## Files:
### Main files:
- boot.asm: First stage bootloader. BPB for FDD emulation, segment registers and stack setup and second stage bootloader load.
- second_bootloader.asm: Second stage bootloader. Currently, menu to choose between loading the 32-bit Kernel or 16-bit shell.
- shell.asm: 16-bit shell in real mode. Currently, no commands available. Only printing pressed keys.

### Include files:
- screen.asm: Include file with all screen-related routines. Currently, string printing routine and video mode/cursor configuration.
- disk.asm: Include file with all disk-related routines. Currently, second stage bootloader loading routine and FDD reset.
- keyboard.asm: Include file with all keyboard-related routines. Currently, menu for Kernel/Shell choice.

### Other files:
- makefile: Used to compile the OS in UNIX. Currently, I have no file to compile in Windows. By the way, you can copy source code and compile yourself very easy.

## Warnings:
### Non-dangerous:
- 16-bit Shell is buggy. If you're going to play with it, don't backspace when there are no more characters. Furthermore, shell may crash or get stuck sometimes.
- If you press a different key of the displayed ones at any time user input is needed, computer will halt. It's not a bug but a coded feature. Just follow the instructions.
- If an error occurs at any time of the boot process, computer will halt. It's a coded feature to prevent damaging the computer. You'll need to restart the PC.

## How to build
If you want to test the OS, you can do it in real hardware or emulating.
### Emulating
My preference is QEMU. I'm using this tool to test the OS When developing it without having to restart the computer. However, you can use other tools as Bochs or Virtualbox, but you might need to do extra work to get the desired file image of the OS to test it in those programs, as building an ISO file or a configuration file for Bochs.

### Real Hardware
Bootloder is programmed to work as a Floppy Disk. I recommed you burning the OS into a USB stick as it's how I'm doing it. You can use CDs too but extra work may be necessary.
You may need to modify BIOS boot options to give more preference to the bootable media you are using than to your main OS (Windows, Linux, Mac...).

## Contact
**Email:** adri7escalona@gmail.com
**Twitter**: @a7escalona
**Reddit**: u/a7escalona
