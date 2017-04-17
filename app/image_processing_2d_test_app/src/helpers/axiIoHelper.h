#ifndef SRC_HELPERS_AXIIOHELPER_H_
#define SRC_HELPERS_AXIIOHELPER_H_

#include "xil_io.h"

void write(int baseAddress, int offset, int value);
int read(int baseAddress, int offset);



#endif /* SRC_HELPERS_AXIIOHELPER_H_ */
