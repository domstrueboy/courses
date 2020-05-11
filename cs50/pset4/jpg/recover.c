/**
 * recover.c
 *
 * Computer Science 50
 * Problem Set 4
 *
 * Recovers JPEGs from a forensic image.
 */
 
#include <stdio.h>
#include <stdint.h>

typedef uint8_t BYTE;

int main(void)
{
    FILE* file = fopen("card.raw", "r");
    
    if (file == NULL)
    {
        printf("Could not open 'card.raw'\n");
        return 1;
    }
    
    int count = 0; 
    BYTE buf[512];
    int bufsize = sizeof(buf);
    char filename[7]; 
   
    FILE* tmp = NULL; 
    
    do
    {
        if(
            ( buf[0] == 0xff && buf[1] == 0xd8 && buf[2] == 0xff && buf[3] == 0xe0 ) ||
            ( buf[0] == 0xff && buf[1] == 0xd8 && buf[2] == 0xff && buf[3] == 0xe1)
        )
        {
            sprintf(filename, "%03d.jpg", count);
            tmp = fopen(filename, "w");
            count++;
            
            fwrite(buf, bufsize, 1, tmp);
        }
        else if (count > 0)
        {
            fwrite(buf, bufsize, 1, tmp);            
        }
      
        fread(buf, bufsize, 1, file);
        
    } while(!feof(file));
    
    fclose(tmp);
    fclose(file);

    // that's all folks
    return 0;
}
