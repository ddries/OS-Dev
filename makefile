
all: $(media)
	@sudo nasm -f bin boot/boot.asm -o bin/boot.bin -i include/ -i boot/
	@sudo nasm -f bin boot/second_boot.asm -o bin/second.bin -i include/ -i boot/
	@sudo nasm -f bin boot/shell.asm -o bin/shell.bin -i include/ -i boot/
	@sudo nasm -f bin boot/k.asm -o bin/k.bin -i include/ -i boot/
	@sudo dd if=/dev/zero of=$(media) bs=1024 count=1440 status=none
	@sudo dd if=bin/boot.bin of=$(media) bs=512 count=1 conv=notrunc status=none
	@sudo dd if=bin/second.bin of=$(media) bs=512 count=1 seek=1 conv=notrunc status=none
	@sudo dd if=bin/shell.bin of=$(media) bs=512 count=1 seek=2 conv=notrunc status=none
	@sudo dd if=bin/k.bin of=$(media) bs=512 count=1 seek=3 conv=notrunc status=none
