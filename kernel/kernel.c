

void kmain()
{
	char* videomem = (char*) 0xb8000; // Create a pointer to the beginning of video memory.
	*videomem = 'K';
}

void print(char* string)
{
	char* videomem = (char*) 0xb8000;
	char* print_loc = videomem;	

	int i;
	for (i = 0; i < 4; i++)
	{
		print_loc = videomem - (i * 2);
		*print_loc = string[i];
	}
}
