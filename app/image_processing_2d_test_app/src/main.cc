/*
 * Dragster line scanners readout test
 */

#include <stdio.h>
#include "imageCaptureManager.h"
#include "globalDefs.h"

extern PixelFrequencies linescanner0PixelFrequencies;
extern PixelFrequencies linescanner1PixelFrequencies;

int main()
{
    printf("Application started \r\n");
    ImageCaptureManager systemManager;
    systemManager.initialize();

    // check config
    DragsterConfig linescanner0Config = systemManager.getDragsterConfig(LINESCANNER0);
    DragsterConfig linescanner1Config = systemManager.getDragsterConfig(LINESCANNER1);
    xil_printf("Linescanner 0, Register1: 0x%02X \r\n", linescanner0Config.getControlRegister1()._mapImpl._registerValue);
    xil_printf("Linescanner 0, Register2: 0x%02X \r\n", linescanner0Config.getControlRegister2()._mapImpl._registerValue);
    xil_printf("Linescanner 0, Register3: 0x%02X \r\n", linescanner0Config.getControlRegister3()._mapImpl._registerValue);

    xil_printf("Linescanner 1, Register1: 0x%02X \r\n", linescanner1Config.getControlRegister1()._mapImpl._registerValue);
    xil_printf("Linescanner 1, Register2: 0x%02X \r\n", linescanner1Config.getControlRegister2()._mapImpl._registerValue);
    xil_printf("Linescanner 1, Register3: 0x%02X \r\n", linescanner1Config.getControlRegister3()._mapImpl._registerValue);
    // todo: umv: write configuration in files via FatFS
    // start process ...
    systemManager.startImageCapture();

    linescanner0Config = systemManager.getDragsterConfig(LINESCANNER0);
    linescanner1Config = systemManager.getDragsterConfig(LINESCANNER1);

    for(long l= 0; l < 40000000; l++)
    {
    	//xil_printf("infinite loop cycle");
    }
    // stop ...
    xil_printf("Frequency analyzer 0 rised %d times \r\n", linescanner0PixelFrequencies._counter);
    xil_printf("Frequency analyzer 1 rised %d times \r\n", linescanner1PixelFrequencies._counter);
    systemManager.stopImageCapture();
    return 0;
}
