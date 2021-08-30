#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <math.h>

char *filename(char *str)	// function to find file name
{
	const char ch = '/';
	char *s = strrchr(str, ch);	//fetches last char '/' in the string
	if (s == NULL)
	{
		return str;
	}
	else
	{
		s++;
		return s;
	}
}

int main(int argc, char *argv[])
{
	char *st1 = argv[2], *st2 = argv[3];	// storing last two arguments in strings
	long long a = *st1 - '0', b = *st2 - '0';	// converting char to int


	int fd = open(argv[1], O_RDONLY);		// opening the file in Read mode
	
	if (fd < 0)								// error handling
	{
		perror("error message:");
		exit(1);
	}

	mkdir("Assignment", S_IRWXU);			// makes Assignment Directory with Read Write Execute Permission to user only

	char *str = (char *)malloc(sizeof(argv[1])), *fn;
	strcpy(str, argv[1]);					// copying that path to str
	fn = filename(str);						// storing name of file in fn
	char fnpath[150];						
	sprintf(fnpath, "Assignment/2_%s", fn);	// creating a path for output file inside directory

	int outputfd = open(fnpath, O_RDWR | O_TRUNC | O_CREAT, S_IRUSR | S_IWUSR);		// creating output file and giving it's user read and write permission

	if(outputfd < 0){	// error handling
		perror("error message:");
		exit(1);
	}

	long long count = lseek(fd, 0, SEEK_END), n = 1, p = 0;	// storing size of the file in count and setting max chunk size 
	long long mx = 4100000, blocksize = count / a, block = blocksize * b, dup = blocksize;	// finding size of each block and the endpoint of the block to reverse

	char *buffer = (char *)calloc(mx, sizeof(char)), *save = (char *)calloc(mx, sizeof(char));	//creating two chunk size strings to reverse  
	char perc[100] = "", msg[50] = "Percentage finished:";							// for progress display

	while (blocksize >= mx)															// compute till block size % chunk characters are left
	{
		p = 0;
		lseek(fd, block - mx, SEEK_SET);											// setting seek mx elements behind end
		read(fd, buffer, mx);														// reading the next mx elements
		for (long long i = mx - 1; i >= 0; i--)										// stores mx elements in reverse in string save
		{
			save[p++] = buffer[i];
		}
		n += p;																		// increaments n
		sprintf(perc, "\r%s %.2f%%", msg, ((double)(n) / (double)dup) * 100);		// stores display message along with % progress 
		write(1, perc, sizeof(perc));												// displays the message
		fflush(stdout);																// flushes buffer
		write(outputfd, save, mx);													// writes the reversed string in output file inside directory
		block -= mx;																// decreases block by mx since last mx elements are stored	
		blocksize -= mx;															// decreases blocksize by mx since last mx elements are stored	
	}
	if (blocksize > 0)																// to reverse the remaining elements (blocksize < mx)
	{
		lseek(fd, dup * (b - 1), SEEK_SET);											// setting seek to start of block required to reverse
		read(fd, buffer, blocksize);
		p = 0;

		for (long long i = blocksize - 1; i >= 0; i--)								// reverses the string and stores in save
		{
			save[p++] = buffer[i];
		}
		n += p;																		// increaments n to number of elements left
		sprintf(perc, "\r%s %.2f%%", msg, ((double)(n) / (double)dup) * 100);		// stores display message with the progress
		write(1, perc, sizeof(perc));												// writes the display message
		fflush(stdout);																// flushes buffer
		write(outputfd, save, p);													// writes the remaining reversed string to output file
	}
	// closes the two opened files
	close(fd);
	close(outputfd);
	return 0;
}