

void kernelCheck(void)
{
	char* vidmem = (char*) 0xb8000;
	char* msg = "Kernel";
	
	int i;
	for (i = 0; i < 6; i++)
	{
		vidmem = vidmem + (2 * i);
		*vidmem = *msg;
		*(vidmem + 1) = 0x0f;

		*msg++;
	}

}

void kmain(void)
{
	kernelCheck();
}

