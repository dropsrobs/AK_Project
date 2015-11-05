#include <iostream>
#include <vector>

using namespace std;

const int NUM_SIZE(256);

struct Bignum
{
    vector<bool> bin_num;
    bool last_popped;
    int size;

    Bignum()
    {}

    Bignum(int si)
    {
        bin_num.resize(si);
        size = si;
        for(int i = 0; i != size; i++)
        { bin_num[i] = false; }
    }

    ~Bignum()
    {
        size = 0;
        last_popped = 0;
    }

    Bignum operator+(Bignum other)
    {
        Bignum result(other.size);
        bool carry = false;
        bool partial_sum = false;
        bool sum = false;
        for(int i = other.size - 1; i > -1; i--)
        {
            partial_sum = ((bin_num[i] != other.bin_num[i]));
            sum = (partial_sum != carry);
            carry = ((bin_num[i] && other.bin_num[i]) || (partial_sum && carry));
            result.bin_num[i] = sum;
         }
        return result;
    }

    void operator<<(bool inserted)
    {
        Bignum result(size);

        for(int j = 0; j != size - 1; j++)
        { result.bin_num[j] = bin_num[j + 1]; }

        result.bin_num[size - 1] = inserted;
        last_popped = bin_num[0];

        for(int i = 0; i != size; i++)
        { bin_num[i] = result.bin_num[i]; }
    }
};

struct Divis
{
    Bignum dividend;
    Bignum divisor;
    Bignum quotient;
    Bignum remainder;
    Bignum mantissa;

    Divis() : dividend(NUM_SIZE), divisor(NUM_SIZE + 1), quotient(NUM_SIZE), remainder(NUM_SIZE + 1)
    {}

    void convert_and_load(char* divid, char* divis)
    {
        for(int i = 0; i != NUM_SIZE; i++)
        {
            divid[i + 1] == '1' ? dividend.bin_num[i] = true : dividend.bin_num[i] = false;
            divis[i] == '1' ? divisor.bin_num[i] = true : divisor.bin_num[i] = false;
        }
        divis[NUM_SIZE] == '1' ? divisor.bin_num[NUM_SIZE] = true : divisor.bin_num[NUM_SIZE] = false;

        init_remainder();
        init_quotient();
    }

    void init_remainder()
    {
        for(int i = 0; i != NUM_SIZE + 1; i++)
            { remainder.bin_num[i] = false; }
    }

    void init_quotient()
    {
        for(int i = 0; i != NUM_SIZE; i++)
        { quotient.bin_num[i] = dividend.bin_num[i]; }
    }

    void init_mantissa()
    {
        for(int i = 0; i != divisor.size; i++)
        { mantissa.bin_num[i] = divisor.bin_num[i]; }
    }

    void divide()
    {
        Bignum divisor_compli = compliment(divisor);
        Bignum mantissa = divisor_compli;

        for(int i = 0; i != NUM_SIZE; i++)
          {
              remainder<<1;
              remainder.bin_num[remainder.size - 1] = quotient.bin_num[0];
              remainder = remainder + mantissa;
              quotient<<1;
              quotient.bin_num[quotient.size - 1] = !remainder.bin_num[0];

              if(remainder.bin_num[0])
              { remainder = remainder + compliment(mantissa); }
          }

    }

    Bignum compliment(Bignum big_number)
    {
        Bignum result(big_number.size);
        Bignum compliment_one(big_number.size);

        for(int i = 0; i != big_number.size; i++)
        {
            result.bin_num[i] = !big_number.bin_num[i];
            compliment_one.bin_num[i] = false;
        }

        compliment_one.bin_num[big_number.size - 1] = true;
        result =  result + compliment_one;
        return result;
    }

    char* shift(char* div)
    {
        int stop_index = 0;
        for(int i = 0; i != NUM_SIZE + 1; i++)
        {
            if(div[i] == '\0')
            { stop_index = i; }
        }

        int shift = NUM_SIZE - stop_index + 1;
        char char_tmp[NUM_SIZE];

        for(int i = 0; i != stop_index; i++)
        { char_tmp[i] = div[i]; }

        for(int i = 0; i != stop_index; i++)
        { div[i + shift] = char_tmp[i]; }

        for(int i = 0; i != shift; i++)
        { div[i] = '0'; }

        return div;
    }

    void result_print()
    {
        cout<<"Quotient: ";
        for(int i = 0; i != quotient.size; i++)
            { cout<<quotient.bin_num[i]; }
        cout<<endl;

        cout<<"Remainder: ";
        for(int i = 0; i != remainder.size; i++)
            { cout<<remainder.bin_num[i]; }
        cout<<endl;
    }
};

int main( int argc, const char* argv[] )
{
    char* dividend = new char[NUM_SIZE + 1];
    char* divisor = new char[NUM_SIZE + 1];

    char* holder1;
    char* holder2;

    for(int i = 0; i != NUM_SIZE + 1; i++)
    {
        dividend[i] = '0';
        divisor[i] = '0';
    }

    cout<<"This is xxxxxxxx divisor"<<endl;
    cout<<"Enter dividend: ";
    cin>>dividend;
    cout<<"Enter divisor: ";
    cin>>divisor;

    Divis divis;
    holder1 = divis.shift(dividend);
    holder2 = divis.shift(divisor);

    divis.convert_and_load(holder1, holder2);

    divis.divide();
    divis.result_print();
}
