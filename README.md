# OS Dev repository
## Files:
- boot.asm: First stage bootloader. BPB for FDD emulation, segment registers and stack setup and second stage bootloader load.
- second_bootloader.asm: Second stage bootloader. Currently, menu to choose between loading the 32-bit Kernel or 16-bit shell.
- screen.asm: Include file with all scren-related routines. Currently, string printing routine and video mode/cursor configuration.
- disk.asm: Include file with all disk-related routines: Currently, econd stage bootloader loading routine and FDD reset.
- keyboard.asm: Include file with all keyboard-related routines. Currently, menu for Kernel/Shell choice.
