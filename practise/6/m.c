#include <stdio.h>

int str_len(const char * string);

int main(){
    const char *  fmt = "12345555";
    int a = str_len(fmt);
    printf("str_len is return %d\n", a);
    return 0;
}
