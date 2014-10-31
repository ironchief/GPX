#include <iostream>
#include <string>
#include <bitset>
#include <stdint.h>
#include "helper.h"

short long_to_bitset(long long input) 
{   
	// convert long binary representation into a string
    std::string input_str = std::to_string(input);
    // convert string binary rep into a bitset
    std::bitset<16> input_bitset(input_str);
    // convert bitset into a short
    short input_short = (short)input_bitset.to_ulong();
    // check to see if shorts binary matches representaitons
    // std::bitset<16> input_check(input_short);
    // std::cout << input << '\n' << input_bitset << '\n' << input_check << '\n';

    return input_short;
}