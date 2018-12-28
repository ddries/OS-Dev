
void kmain()
{
	char* videomem = (char*) 0xb8000; // Create a pointer to the beginning of video memory.
	*videomem = 'K'; // Store 'A' at the beginning of video memory = Print 'A' on (0,0).
}
