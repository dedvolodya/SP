#include <stdio.h>
#define n 9 // кількість байтів у надвеликому числі
typedef unsigned char byte; // для роботи з байтами використовується тип char
extern "C" {
	void BigShowN(byte* p1, int p2);
	void BigShr(byte* M1, byte* Carry, int len);
}


int main()
{
	byte x[n]; //надвеликі числа
	byte carry = 0;
	for (int i = 0; i<n; i++)
	{
		x[i] = i+1;
	}
	printf("X=");
	BigShowN(x, n);

	BigShr(x, &carry, n);
	printf("CARRY = %i\n", carry);
	printf("X=");
	BigShowN(x, n);
	BigShr(x, &carry, n);
	printf("CARRY = %i\n", carry);
	printf("X=");
	BigShowN(x, n);

	getchar();
	return 0;
}
