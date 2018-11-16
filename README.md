# OS Dev repository
## Files:
### Main files:
- boot.asm: First stage bootloader. BPB for FDD emulation, segment registers and stack setup and second stage bootloader load.
- second_bootloader.asm: Second stage bootloader. Currently, menu to choose between loading the 32-bit Kernel or 16-bit shell.
- shell.asm: 16-bit shell in real mode. Currently, no commands available. Only printing pressed keys.

### Include files:
- screen.asm: Include file with all scren-related routines. Currently, string printing routine and video mode/cursor configuration.
- disk.asm: Include file with all disk-related routines: Currently, econd stage bootloader loading routine and FDD reset.
- keyboard.asm: Include file with all keyboard-related routines. Currently, menu for Kernel/Shell choice.

## Warnings:
### Non-dangerous:
- 16-bit Shell is buggy. If you're going to play with it, don't backspace when there are no more characters. Furthermore, shell may crash or get stuck sometimes.
- If you press a different key of the displayed ones, computer will halt. It's not a bug but a coded feature. Just follow the instructions.
- If an error occurs at any time of the boot process, computer will halt. It's a coded feature to prevent damaging the computer. You'll need to restart the PC.
