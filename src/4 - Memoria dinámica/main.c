#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "Memoria.h"

int main() {
	/* Acá pueden realizar sus propias pruebas */
    char* texto1 = "Hola mundo!";
    char* texto2 = "";          // String vacío

    FILE* f = stdout;

    strPrint(texto1, f); 		// Debería imprimir "Hola mundo!"
    strPrint(texto2, f); 		// Debería imprimir "NULL"
	strPrint(texto2, f); 		// Debería imprimir "Hola mundo!"

	return 0;
}
