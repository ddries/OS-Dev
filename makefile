


all: $(media)
	# Kernel compilation
	@sudo gcc -ffreestanding -c -m32 -fno-pie kernel/kernel.c -o kernel.o 
	# Assembly compilation
	@sudo nasm -f bin boot/boot.asm -o bin/boot.bin -i boot/
	@sudo nasm -f bin boot/second_boot.asm -o bin/second.bin -i boot/
	@sudo nasm -f bin shell/shell.asm -o bin/shell.bin -i boot/
	@sudo nasm -f elf boot/k.asm -o k.o
	# Linking kernel
	@sudo ld -o bin/kernel.bin -Ttext 0x1000 -m elf_i386 --oformat binary  k.o kernel.o 
	# Building image
	@sudo dd if=/dev/zero of=$(media) bs=1024 count=1440 status=none
	@sudo dd if=bin/boot.bin of=$(media) bs=512 count=1 status=none
	@sudo dd if=bin/second.bin of=$(media) bs=512 count=1 seek=1 status=none
	@sudo dd if=bin/shell.bin of=$(media) bs=512 count=1 seek=2 status=none
	@sudo dd if=bin/kernel.bin of=$(media) count=1 seek=3 status=none
	# Remove object files
	@sudo rm *.o
