#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>

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

void solve(char const filename[], char str[])
{

    struct stat inpfile;

    if (stat(filename, &inpfile) == -1)     // error handling if the file doesnot exists or has some issues
    {
        char error[150] = "";
        sprintf(error, "error message : %s", str);
        perror(error);                      // prints the error on screen
        return;
    }
    // PERMISSION FOR USER  
    char display1[600] = "";                // empty display string for user permission message
    sprintf(display1, "User has read permission on %s: %s\n", str, (inpfile.st_mode & S_IRUSR) ? "Yes" : "No");     // checks for read permission
    write(1, display1, sizeof(display1));                                                                           // display the message
    sprintf(display1, "User has write permission on %s: %s\n", str, (inpfile.st_mode & S_IWUSR) ? "Yes" : "No");    // checks for write permisson
    write(1, display1, sizeof(display1));                                                                           // display the message
    sprintf(display1, "User has execute permission on %s: %s\n\n", str, (inpfile.st_mode & S_IXUSR) ? "Yes" : "No");// checks for execute permission
    write(1, display1, sizeof(display1));                                                                           // display the message
    // PERMISSION FOR GROUP
    char display2[600] = "";                // empty display string for group permission message
    sprintf(display2, "Group has read permission on %s: %s\n", str, (inpfile.st_mode & S_IRGRP) ? "Yes" : "No");    // checks for read permission
    write(1, display2, sizeof(display2));                                                                           // display the message
    sprintf(display2, "Group has write permission on %s: %s\n", str, (inpfile.st_mode & S_IWGRP) ? "Yes" : "No");   // checks for write permission
    write(1, display2, sizeof(display2));                                                                           // display the message
    sprintf(display2, "Group has execute permission on %s: %s\n\n", str, (inpfile.st_mode & S_IXGRP) ? "Yes" : "No");// checks for execute permission
    write(1, display2, sizeof(display2));                                                                           // display the message 
    // PERMISSION FOR OTHERS
    char display3[600] = "";                // empty display string for others permission message
    sprintf(display3, "Others has read permission on %s: %s\n", str, (inpfile.st_mode & S_IROTH) ? "Yes" : "No");   // checks for read permission
    write(1, display3, sizeof(display3));                                                                           // display the message
    sprintf(display3, "Others has write permission on %s: %s\n", str, (inpfile.st_mode & S_IWOTH) ? "Yes" : "No");  // checks for write permission  
    write(1, display3, sizeof(display3));                                                                           // display the message
    sprintf(display3, "Others has execute permission on %s: %s\n\n", str, (inpfile.st_mode & S_IXOTH) ? "Yes" : "No");// checks for execute permission
    write(1, display3, sizeof(display3));                                                                           // display the message

}

int main(int argc, char *argv[])
{
    
    char buffer2[100] = "Assignment/1_", buffer3[100] = "Assignment/2_", buffer[100] = "Assignment";  // storing the path names for the output files and directory

    char *str = (char *)malloc(sizeof(argv[1])), *fn;
	strcpy(str, argv[1]);					// copying that path to str
	fn = filename(str);						// storing name of file in fn
	char fnpath[150] = "";						
	sprintf(fnpath, "%s", fn);	// creating a path for output file inside directory

    strcat(buffer2, fnpath);    // concatenates filename to the directory path
    strcat(buffer3, fnpath);    // concatenates filename to the directory path

    int s1 = open(buffer, O_RDONLY);    // opens directory
    int s2 = open(buffer2, O_RDONLY);   // opens output_file_1
    int s3 = open(buffer3, O_RDONLY);   // opens output_file_2

    char msg[200] = "";                 // to store display message
    if (s1 < 0)                         // handling error if directory doesnt exist
    {
        sprintf(msg,"%s\n\n","Directory is created: NO");
        // printf("Directory is created: NO\n");
        write(1,msg,sizeof(msg));
        return 0;                       // terminates if directory doesnt exist
    }
    else{
        sprintf(msg,"%s\n\n","Directory is created: YES");
        write(1,msg,sizeof(msg));       // prints message that directory exists
    }
    if (s2 > 0)                         // checks if output file 1 exists
    {
        solve(buffer2, "output_file_1");    // calls solve function if output file 1 exists
    }
    if (s3 > 0)                         // checks if output file 2 exists
    {   
        solve(buffer3, "output_file_2");    // calls solve function if output file 2 exists
    }
    solve(buffer, "directory");         // calls solve function since directory exists
        // closes the 3 opened directory and files
    close(s1);
    close(s2);
    close(s3);
    return 0;
}
