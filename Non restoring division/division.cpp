#include <stdio.h>
#include <fstream>
#include <stdlib.h>

const int NUM_SIZE(64);

extern "C" {
     void division(
         long* dividend,
         long* divisor,
         long* quotient,
         long* remainder);
     }

// struct Divis
// {
//     void init_remainder()
//     {
//         for(int i = 0; i != NUM_SIZE + 1; i++)
//             { remainder.bin_num[i] = false; }
//     }
//
//     void init_quotient()
//     {
//         for(int i = 0; i != NUM_SIZE; i++)
//         { quotient.bin_num[i] = dividend.bin_num[i]; }
//     }
//
//     void init_mantissa()
//     {
//         for(int i = 0; i != divisor.size; i++)
//         { mantissa.bin_num[i] = divisor.bin_num[i]; }
//     }
//     void divide()
//     {
//         Bignum divisor_compli = compliment(divisor);
//         Bignum mantissa = divisor_compli;
//
//         for(int i = 0; i != NUM_SIZE; i++)
//         {
//             remainder<<quotient;
//
//
//             if(remainder.last_popped == true)
//             { mantissa = divisor; }
//             else
//             { mantissa = divisor_compli; }
//             remainder = remainder + mantissa;
//             quotient.bin_num[quotient.size - 1] = !remainder.bin_num[0];
//         }
//         if(remainder.bin_num[0] == true)
//         { remainder = remainder + divisor; }
//     }
// };

int main( int argc, const char* argv[] )
{
    // ifstream dividend("./dividend.txt", ios::binary);
    // ifstream divisor("./divisor.txt", ios::binary);
    // ofstream quotient("./quotient.txt", ios::binary);
    // ofstream remainder("./remainder.txt", ios::binary);
    // char dividend_buffer[NUM_SIZE];
    // char divisor_buffer[NUM_SIZE];
    //
    long dividend[2], divisor[2], quotient[2], remainder[2];
    dividend[0] = 0xFF000010;
    dividend[1] = 0xF0110000;

    divisor[0] = 0x10000000;
    divisor[1] = 0x00000000;


division(dividend, divisor, quotient, remainder);

    // char test_divisor[] = { '0', '1', '5', '0', '1', '5', '0', '1', '5', '0', '1', '5','0', '1', '5', };
    // char test_dividend[] = { '0', '0', '5' };

    // long int res_dividend; //[NUM_SIZE/];
    // long int res_divisor; //[NUM_SIZE/4];
    // long int quotient;
    // long int remainder;

    // dividend.read(buffer, NUM_SIZE);
    // quotient.write(buffer, 5);

    // for(int i = 0; i != NUM_SIZE/4; i++)
    // {
    //
    // }

    //res_dividend = atol(test_dividend);
    //res_divisor = atol(test_divisor);
}
