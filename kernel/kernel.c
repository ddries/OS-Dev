
void kmain()
{
	char* videomem = 0xb8000; // Create a pointer to the beginning of video memory.

	*videomem = 'A'; // Store 'A' at the beginning of video memory = Print 'A' on (0,0).
}
