#include <stdio.h>
int p, j;
int main() {
	int A[11];
	for (p = 0; p<11; p++) {
		j = 32 - 2 * p;
		/*switch (p) {
		case 9: j *= 2; break;
		case 7: j += 15; break;
		case 4: j = -5; break;
		case 2: j -= 8; break;
		case 0: j = 0; break;
		default: j = 77;
		}*/
		//switch (p) 
		_asm {
			
			// case 9 
				mov	 eax, p
			        cmp	 p, 9
				je	 SHORT case9

			// case 7 
			         mov	 eax, p
			         cmp	 p, 7
			         je	 SHORT case7

			// case 4 
			         mov	 eax, p
			         cmp	 p, 4
			         je	 SHORT case4

			// case 2 
				mov	 eax, p
				cmp	 p, 2
				je	 SHORT case2

			// case 0 
				mov	 eax, p
				cmp	 p, 0
				je	 SHORT case0

			// default	
                                jmp def
             
			// j *= 2; break;
			        case9 :
				    shl j,1
				    jmp END

                        // j += 15; break;
				case7:
                                    add j,15
            			    jmp END

			 // j = -5; break;
				case4:
                                    mov j,-5
				    jmp END

			 // j -= 8; break;
				case2 :
				    sub j, 8
				    jmp END
			
			 // j = 0; break;
		 		case0 :
             			    mov j, 0
				    jmp END
                         // j = 77
				def:
				    mov j,77

			  END:

		}
		/*A[p] = j;*/
		_asm {
			mov ecx,p
			mov eax,j
			mov A[ecx*4],eax
		}
	}
	for (j = 0; j<11; j++)
		printf("%d ", A[j]);
	printf("\n");
	
	return 0;
}