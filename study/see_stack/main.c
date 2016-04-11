//#include <stdio.h>


int area(int a){
    return a*a;
}


int main(int argc, char * argv[]){
    int abc = 0;
    int bcd = area(++abc);
    return 0;
}
