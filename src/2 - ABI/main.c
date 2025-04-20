#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "ABI.h"

int main() {
	/* Acá pueden realizar sus propias pruebas */
	assert(alternate_sum_4_using_c(8, 2, 5, 1) == 10);

	assert(alternate_sum_4_using_c_alternative(8, 2, 5, 1) == 10);

	assert(alternate_sum_8(8, 2, 5, 1, 8, 2, 5, 1) == 20);

	uint32_t p = 10;
	uint32_t a = 5;
	float b = 2.51;
	product_2_f(&p, a, b);
	printf("%f",p);
	assert(p == 12.55);
	return 0;
}
