/*
 * AdventOfCode2020
 * --- Day 2: Password Philosophy ---
 * part1: 600
 * Elapsed: 0.625000 ms
 * part2: 245
 * Elapsed: 0.693000 ms
 *
 */
#include <stdio.h> 
#include <stdlib.h> 
#include <string.h> 
#include <time.h>
#define RECCOUNT 1000
#define DATA "../data/google-2.txt"
//#define DATA "./data.txt"

void part1(char d[][4][30] , int t);
void part2(char d[][4][30] , int t);

int main(int argc, char *argv[])
{
    clock_t begin = clock();

    // Load the data
    // for this puzzle the data will be 1000 rows into 4 segment pieces
    // begin, end, letter, password

    // Array for 1000 lines, each with 4 strings, each string max 30 chars
    // Adjust values as required.
    char data[RECCOUNT][4][30];

    FILE * fp;
    int i = 0;
    int tot = 0;

    fp = fopen(DATA, "r");
    if (fp == NULL) {
        exit(EXIT_FAILURE);
    }


    char line[100];
    while(fgets(line, sizeof(line) / sizeof(line[0]), fp) != NULL) {
        // Rudimentary error checking - if the string has no newline
        // there wasn't enough space in line
        if (strchr(line, '\n') == NULL) {
            printf("Line too long...");
            exit(EXIT_FAILURE);
        }
        char *ptr1 = strtok(line, "-");
        strcpy(data[i][0], ptr1);
        char *ptr2 = strtok(NULL, " ");
        strcpy(data[i][1], ptr2);
        char *ptr3 = strtok(NULL, ": ");
        strcpy(data[i][2], ptr3);
        char *ptr4 = strtok(NULL, "\n");
        strcpy(data[i][3], ptr4);
        i++;
    }

    tot=i; // Unecessary - just use a different variable in your loop and use i as the upper bound

    part1(data, tot);
    clock_t end = clock();
    printf("Elapsed: %f ms\n", (double)(end - begin) * 1000.0/ CLOCKS_PER_SEC);

    part2(data, tot);
    end = clock();
    printf("Elapsed: %f ms\n", (double)(end - begin) * 1000.0/ CLOCKS_PER_SEC);

    exit(EXIT_SUCCESS);
}


void part1(char d[][4][30] , int t)
{
    //part1
    int counter = 0;
    for (int i=0;i<t;i++) {
        // count occurances of letter in password
        int count = 0;
        
        // Get data in format we can use
        int begin = atoi(d[i][0]);
        int end = atoi(d[i][1]);

        char toSearch[1] = {0};
        strcpy(toSearch,d[i][2]);
        
        char str0[30] = {0};
        strcpy(str0,d[i][3]);
        // Remove left character
        char* str = str0 + 1;

        //printf("%s|%s|",str,d[i][3]);
        //for (int k=0;k<strlen(str);k++) {
        //    printf("%c", str[k]);
        //}

        // Count the number of matches in the string for letter
        for (int k=0;k<strlen(str);k++) {
            if(str[k]==toSearch[0]) {
                //printf("Match:(%c)(%c)",str[k],toSearch[0]);
                count++;
            } else {
                //printf("No Match:(%c)(%c)",str[k],toSearch[0]);
            }

        }

        // Count where number of matches is in the defined range
        if (count >= begin && count <= end) {
            //printf("%d: %d %d %d\n",i,count,begin,end);
            counter++;
        } else {
            //printf("%d: %d %d %d\n",i,count,begin,end);
        }
    }
    printf("part1: %d\n", counter);
}

void part2(char d[][4][30] , int t)
{
    // part2
    // 1-3 a: abcde is valid: position 1 contains a and position 3 does not.
    // 1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.
    // 2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.
    int counter = 0;
    for (int i=0;i<t;i++) {
        // count occurances of letter in password
        
        // Get data in format we can use
        int begin = atoi(d[i][0]);
        int end = atoi(d[i][1]);

        char toSearch[1] = {0};
        strcpy(toSearch,d[i][2]);
        
        char str0[30] = {0};
        strcpy(str0,d[i][3]);
        // Remove left character
        char* str = str0 + 1;

        // Count the number of matches in the string for letter
        if(str[begin-1]==toSearch[0] ^ str[end-1]==toSearch[0]) {
            //printf("Match:(%c)(%c)",str[k],toSearch[0]);
            counter++;
        } else {
            //printf("No Match:(%c)(%c)",str[k],toSearch[0]);
        }
    }
    printf("part2: %d\n", counter);
}