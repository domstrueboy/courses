/**
 * helpers.c
 *
 * Computer Science 50
 * Problem Set 3
 *
 * Helper functions for Problem Set 3.
 */
       
#include <cs50.h>
#include <stdio.h>

#include "helpers.h"

/**
 * Returns true if value is in array of n values, else false.
 */
bool search(int value, int values[], int n)
{
    int position, jump;
    
    if(n % 2 == 0)
    {
        jump = n/2;
        position = jump;
    }
    else
    {
        jump = (n+1)/2;
        position = jump-1;
    }
    
    while( jump > 0 )
    {
        if( values[position] == value )
        {
            return values[position];
        }
        else
        {   
            jump = (int) jump/2;
            if ( values[position] > value )
            {
                position = position - jump;    
            }
            else if( values[position] < value )
            {
                position = position + jump; 
            }
        }
    }
    
    return 0;
}

/**
 * Sorts array of n values.
 */
void sort(int values[], int n)
{
    int buff = 0;
    bool flag;
    
    do
    {
        flag = false;
        for( int i = 1; i < n; i++ )
        {
            if( values[i-1] > values[i] )
            {
                flag = true;
                
                buff = values[i-1];
                values[i-1] = values[i];
                values[i] = buff;
            }
        }
    }
    while(flag);
    
    /* for( int i = 0; i < n; i++ )
    {
        printf("%i  ", values[i]);
    } */
    
    return;
}