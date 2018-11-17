
all:
	sudo nasm -f bin boot.asm -o boot.bin
	sudo nasm -f bin second_boot.asm -o second.bin
	sudo nasm -f bin shell.asm -o shell.bin
	sudo dd if=/dev/zero of=os.img bs=1024 count=1440
	sudo dd if=boot.bin of=os.img bs=512 count=1 conv=notrunc
	sudo dd if=second.bin of=os.img bs=512 count=1 seek=1 conv=notrunc
	sudo dd if=shell.bin of=os.img bs=512 count=1 seek=2 conv=notrunc
