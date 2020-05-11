/**
 * generate.c
 *
 * Computer Science 50
 * Problem Set 3
 *
 * Generates pseudorandom numbers in [0,LIMIT), one per line.
 *
 * Usage: generate n [s]
 *
 * where n is number of pseudorandom numbers to print
 * and s is an optional seed
 */
 
#define _XOPEN_SOURCE

#include <cs50.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// constant
#define LIMIT 65536

int main(int argc, string argv[])
{
    /* The program takes a 2 or 3 arguments: 1 - is the name of the program, 2 and 3 - user's parameters.
    If you pass the number of arguments is not equal to 2 or 3 (the program name without any parameters (argc == 1)
    or more than 2 user's parameters), then displays a brief instruction on the proper operation of the program
    and the work program is stopped. */
    if (argc != 2 && argc != 3)
    {
        printf("Usage: generate n [s]\n");
        return 1;
    }

    /* Value of the first argument (excluding zero - argv[0]) converted from a string type to an integer
    and assigned to the variable "n". */
    int n = atoi(argv[1]);

    /* If the program is run with a user entered a second argument, then the random number generator initialized (init func "srand48")
    based on the value of the argument converted from a string type to an integer, and then to long integer.
    If this argument is not entered, the generator is initialized with a value of system time converted to long int. */
    if (argc == 3)
    {
        srand48((long int) atoi(argv[2]));
    }
    else
    {
        srand48((long int) time(NULL));
    }

    /* Pseudo-random number generation is performed in the range from 0 to 1 (double type) n times.
    The value is multiplied by a constant (65536) and then converted to int type (decimal places are lost).
    The resulting value is included in the "unsigned short int" type range.
    At each iteration, the value obtained is displayed, but not saved. */
    for (int i = 0; i < n; i++)
    {
        printf("%i\n", (int) (drand48() * LIMIT));
    }

    // success
    return 0;
}