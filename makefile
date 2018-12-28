
all: $(media)
	@sudo gcc -ffreestanding -c kernel/kernel.c -o kernel.o # Compile kernel
	@sudo nasm -f bin boot/boot.asm -o bin/boot.bin -i include/ -i boot/ -i shell/
	@sudo nasm -f bin boot/second_boot.asm -o bin/second.bin -i include/ -i boot/ -i include/ -i shell/
	@sudo nasm -f bin shell/shell.asm -o bin/shell.bin -i include/ -i boot/ -i shell/
	@sudo nasm boot/k.asm -f elf -o k.o
	@sudo dd if=/dev/zero of=$(media) bs=1024 count=1440 status=none
	@sudo dd if=bin/boot.bin of=$(media) bs=512 count=1 conv=notrunc status=none
	@sudo dd if=bin/second.bin of=$(media) bs=512 count=1 seek=1 conv=notrunc status=none
	@sudo dd if=bin/shell.bin of=$(media) bs=512 count=1 seek=2 conv=notrunc status=none
	@sudo dd if=k.o of=$(media) bs=512 count=1 seek=3 conv=notrunc status=none
	@sudo ld -o bin/kernel.bin -Ttext 0x1000 k.o kernel.o --oformat binary
	@sudo dd if=bin/kernel.bin of=$(media) count=1 seek=4 conv=notrunc status=none
