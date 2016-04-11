#include <string.h>
int frame2(int a2){
    int abc = 0;
    abc += 0xf2;
    
    int * ptr = &abc;
    memset(ptr, 0, 128);
    //*ptr = 10;
    return abc;
}
int frame1(int a1){
    int abc = 0;
    abc += 0xf1;
    abc += frame2(a1);
    return abc;
}
int main(int argc, char * argv[]){
    int abc = 0;
    int bcd = frame1(++abc);
    return 0;
}
