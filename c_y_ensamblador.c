#include <stdio.h>

int gcd( int $a, int $b ){
    int $result;
    asm(
        "movl %1, %%eax;"
        "movl %2, %%ebx;"
        "CONTD: cmpl $0, %%ebx;"
        "je DONE;"
        "xorl %%edx, %%edx;"
        "idivl %%ebx;"
        "movl %%ebx, %%eax;"
        "movl %%edx, %%ebx;"
        "jmp CONTD;"
        "DONE: movl %%eax, %0;" : "=g" ( $result ) : "g" ( $a ), "g" ( $b )
    );
    return $result ;
}

int suma( int $a, int $b ){
    int $result;
    asm(
        "movl %1, %%eax;"
        "movl %2, %%ebx;"
        "addl %%ebx, %%eax;"
        "movl %%eax,%0;" : "=g" ( $result ) : "g" ( $a ), "g" ( $b )
    );
    return $result ;
}


int suma3( int $a, int $b, int $c ){
    int $result;
    asm(
        "movl %1, %%eax;"
        "movl %2, %%ebx;"
        "movl %3, %%ecx;"
        "addl %%ebx, %%eax;"
        "addl %%ecx, %%eax;"
        "movl %%eax,%0;" : "=g" ( $result ) : "g" ( $a ), "g" ( $b ),  "g" ( $c )
    );
    return $result ;
}

int sar(int $a){
    int $resultado;

    __asm__(
        "movl %1, %%eax;"
        "sarl %%eax;"
        "movl %%eax, %0;":"=g"( $resultado ): "g"( $a )
    );

    return $resultado;
}

int sal(int $a){
    int $resultado;

    __asm__(
        "movl %1, %%eax;"
        "sall %%eax;"
        "movl %%eax, %0;":"=g"( $resultado ): "g"( $a )
    );

    return $resultado;
}

void decabin (int n) {
    if (n) {
        decabin(n / 2);
        printf("%d", n % 2);
    }
}


int main(int argc, char** argv) {
    int e, i = 0;
    int rotaciones, numero, aux;
    
    printf("Valor de a:");
    scanf("%d", &numero);

    aux = numero;

    printf("Valor de rotaciones:");
    scanf("%d", &rotaciones);

    printf("\nDezplazamiento Aritmetico a la Derecha SAR");
    printf("\nRotacion 0\n");
    printf("%d\t", numero);
    decabin(numero);

    while(i < rotaciones){
        printf("\nRotacion %d\n", i + 1);
        numero = (int)sar(numero);
        printf("%d\t", numero);
        decabin(numero);
        i++;
    }

    numero = aux;
    i = 0;

    printf("\n\nDezplazamiento Aritmetico a la Izquierda SAL");
    printf("\nRotacion 0\n");
    printf("%d\t", numero);
    decabin(numero);

    while(i < rotaciones){
        printf("\nRotacion %d\n", i + 1);
        numero = (int)sal(numero);
        printf("%d\t", numero);
        decabin(numero);
        i++;
    }
    
  
	return 0;
}