


all: $(media)
	@sudo gcc -m32 -ffreestanding -c kernel/kernel.c -o kernel.o # Kernel compilation
	# Assembly compilation
	@sudo nasm -f bin boot/boot.asm -o bin/boot.bin -i include/ -i boot/ -i shell/
	@sudo nasm -f bin boot/second_boot.asm -o bin/second.bin -i include/ -i boot/ -i shell/
	@sudo nasm -f bin shell/shell.asm -o bin/shell.bin -i include/ -i boot/ -i shell/
	@sudo nasm -f elf boot/k.asm -o k.o
	# Linking kernel
	@sudo ld -o bin/kernel.bin -Ttext 0x1000 k.o kernel.o --oformat binary -m elf_i386
	# Building image
	@sudo dd if=/dev/zero of=$(media) bs=1024 count=1440 status=none
	@sudo dd if=bin/boot.bin of=$(media) bs=512 count=1 status=none
	@sudo dd if=bin/second.bin of=$(media) bs=512 count=1 seek=1 status=none
	@sudo dd if=bin/shell.bin of=$(media) bs=512 count=1 seek=2 status=none
	@sudo dd if=bin/kernel.bin of=$(media) count=1 seek=3 status=none
