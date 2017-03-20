#include "axiIoHelper.h"

void write(int baseAddress, int offset, int value)
{
    Xil_Out32(baseAddress + offset, value);
}

int read(int baseAddress, int offset)
{
    return Xil_In32(baseAddress + offset);
}




