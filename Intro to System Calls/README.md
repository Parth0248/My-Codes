# Assignment 1: Intro To System Calls
## Name: Parth Maradia
## Rollno.: 2020111006
## Branch: CSD

## General Assumptions
* The given input file exists in the same directory as the programs, though the programs accept relative and absolute paths to that file. 
* The number of characters in the input files will not exceed long long int.
* In question 2, arguments for number of parts and part number will be a single digit from 0-9.

## Explaination of each question
### Q1
-  We create a new directory with Read, Write, and Execute permissions and an output file with Read and Write permissions for the user. We use divide and conquer strategy and break down the entire file in small chunks of size close to 4MB each , reverse them and store them in output file. The remaining string is reversed separately since its size is less than 4 MB. While we compute, we also display the progress.
### Q2
- We take arguments of number of parts and part number from argument and assuming they are single digits we type cast them to int and store them in variables. Then just like question 1 we creat new directory and the output file with the required permissions. We use divide and conquer strategy and break down the entire block to reverse in small chunks of size close to 4 MB each, reverse them and store them in output file. The remaining string of block is reversed separately since its size is less than 4 MB. While we compute, we also display the progress.
### Q3
- We take the file name from argument and generate path to output file 1 , output file 2 and assignment directory. We check if the directory exists and handle possible errors. Later we also check if the two output files exists and if either doesnt exists we skip it and compute the next. We make a function that handles error and also prints the permission to read, write, execute for each user, group, and others for output file 1, output file 2 and assignment directory.