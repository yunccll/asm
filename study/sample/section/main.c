#include <stdio.h>


//const int global_const = 12;  //.rodata
char * const ptr = (char*)12;   //.rodata


//static int sta_int = 0;       //.bss
//int global_val = 0;           //.bss
//char buf_zero[4]={0};         //.bss


//static int sta_int_2 = 1;             //.data
//int global_val = 2;                   //.data
//static const char * pstr = "string";  //rodata, .data
//const char * ptr = 10;                //.data

//static int sta_int; //.comm -after link -> .bss
//static int sta_int = 2; //.data

int global_val_2 ;  //.comm -after link -> .bss
char buf[4];        //.comm -after link ->.bss

int global_val_2 = 0;

int main(int argc, char * argv[]){

    //global_val_2 = 100;
    printf("abcdeffff%d\n", 4);
    return 0;
}
