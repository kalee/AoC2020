/*
 * AdventOfCode2020
 * --- Day 1: Report Repair ---
 * part1: 63616
 * part2: 67877784
 * Elapsed: 4.727000 ms
 *
 */
#include <stdio.h> 
#include <stdlib.h> 
#include <string.h> 
#include <time.h>
#define DATA "../data/google-1.txt"

void part1(int * d, int c);
void part2(int * d, int c);

int main(int argc, char *argv[])
{
    clock_t begin = clock();

    // Load the data
    FILE * fp;
    char * line = NULL;
    size_t len = 0;
    ssize_t read;
    int data[200] = {0};  // define and initilize to zero
    int counter = 0;

    fp = fopen(DATA, "r");
    if (fp == NULL) {
        exit(EXIT_FAILURE);
    }

    while ((read = getline(&line, &len, fp)) != -1) {
        //printf("Retrieved line of length %zu:\n", read);
        //printf("%s", line);
        data[counter] = atoi(line);
        counter++;
    }

    fclose(fp);

    part1(data,counter);
    part2(data,counter);

    clock_t end = clock();
    printf("Elapsed: %f ms\n", (double)(end - begin) * 1000.0/ CLOCKS_PER_SEC);

    exit(EXIT_SUCCESS);
}


void part1(int * d, int c)
{
    //part1
    // Display the data in the array
    for (int i = 0; i<c; i++) {
        for (int j = 0; j<c; j++) {
            if(d[i]+d[j]==2020){
                printf("part1: %d\n",d[i]*d[j]);
                return;
            }
        }
    }
}

void part2(int * d, int c)
{
    //part1
    // Display the data in the array
    for (int i = 0; i<c; i++) {
        for (int j = 0; j<c; j++) {
            for (int k = 0; k<c; k++) {
                if(d[i]+d[j]+d[k]==2020){
                    printf("part2: %d\n",d[i]*d[j]*d[k]);
                    return;
                }
            }
        }
    }
}