#include "dragsterConfig.h"
#include <math.h>

unsigned char convertImpl(unsigned char byte);

unsigned char convertFromMsbToLsbFirst(unsigned char byte)
{
	return convertImpl(byte);
}

unsigned char convertFromLsbToMsbFirst(unsigned char byte)
{
	return convertImpl(byte);
}

unsigned char convertImpl(unsigned char byte)
{
	unsigned char result = 0;
    for(int i = 0; i < 8; i++)
    {
       unsigned char selector = (unsigned char)pow(2.0, i);
       unsigned char bitSelection = (byte & selector) > 0 ? 1 : 0;
       result += bitSelection << (7-i);
    }
    return result;
}
