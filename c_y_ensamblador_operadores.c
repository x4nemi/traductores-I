#include <stdio.h>

int opAND(int $a, int $b){
    int $result;

    asm(
        "movl %1, %%eax;"
        "movl %2, %%ebx;"
        "andl %%ebx, %%eax;"
        "movl %%eax,%0;" : "=g" ( $result ) : "g" ( $a ), "g" ( $b )
    );
    return $result ;
}

int opOR(int $a, int $b){
    int $result;

    asm(
        "movl %1, %%eax;"
        "movl %2, %%ebx;"
        "orl %%ebx, %%eax;"
        "movl %%eax,%0;" : "=g" ( $result ) : "g" ( $a ), "g" ( $b )
    );
    return $result ;
}

int opNEG(int $a){
    int $result;

    __asm__(
        "movl %1, %%eax;"
        "negl %%eax;"
        "movl %%eax,%0;" : "=g" ( $result ) : "g" ( $a )
    );
    return $result ;
}

int opXOR(int $a, int $b){
    int $result;

    asm(
        "movl %1, %%eax;"
        "movl %2, %%ebx;"
        "xorl %%ebx, %%eax;"
        "movl %%eax,%0;" : "=g" ( $result ) : "g" ( $a ), "g" ( $b )
    );
    return $result ;
}

char *binbin(char n){
    static char bin[9];
    int x;

    for(x = 0; x < 8; x++)
    {
        bin[x] = n & 0x80 ? '1' : '0';
        n <<= 1;
    }
    bin[x] = '\0';
    return(bin);
}

int main(){
    int a, b;

    printf("Valor de a:");
    scanf("%d", &a);

    printf("Valor de b:");
    scanf("%d", &b);

    printf("Binario a: %s\n", binbin(a));

    printf("Binario b: %s\n", binbin(b));

    int aux = opAND(a, b);

    printf("a AND b: %d %s\n", aux, binbin(aux));

    aux = opOR(a, b);
    printf("a OR  b: %d %s\n", aux, binbin(aux));

    aux = opXOR(a, b);
    printf("a XOR b: %d %s\n", aux, binbin(aux));

    aux = opNEG(a);
    printf("NEG a: \t%d %s\n", aux, binbin(aux));

    aux = opNEG(b);
    printf("NEG b: \t%d %s\n", aux, binbin(aux));

    return 0;
}