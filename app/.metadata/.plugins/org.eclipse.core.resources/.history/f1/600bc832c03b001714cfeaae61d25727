/*
 * Dragster line scanners readout test
 */

#include <stdio.h>
#include "imageCaptureManager.h"
#include "globalDefs.h"

extern PixelFrequencies linescanner0PixelFrequencies;
extern PixelFrequencies linescanner1PixelFrequencies;

#define SYNCH_FREQUENCY 2000 // Hz (period of mechanical part of system)
#define TESTING_TIME 1       // seconds
#define CYCLES_NUMBER SYNCH_FREQUENCY * TESTING_TIME

//#define SPI_TESTING

static void clearFrequencies();

int main()
{
    printf("Application started \r\n");

    ImageCaptureManager systemManager;
    systemManager.initialize();

#ifdef SPI_TESTING
    while(1)
    {
    	systemManager.sendTestSpiSequence();
    	for(int i=0; i< 1000000; i++);  //pause
    }
    // stop ...
    systemManager.stopImageCapture();
    printf("Application stopped \r\n");
#else
    systemManager.resetImageCapture();
    clearFrequencies();
    systemManager.startImageCapture();

    while(linescanner0PixelFrequencies._counter != CYCLES_NUMBER);
#ifdef USE_AXI_QUAD_SPI
    DragsterConfig linescanner0Config = systemManager.getDragsterConfig(LINESCANNER0);
    DragsterConfig linescanner1Config = systemManager.getDragsterConfig(LINESCANNER1);
    systemManager.updateDragsters();

    xil_printf("Linescanner 0, Register1: 0x%02X \r\n", linescanner0Config.getControlRegister1()._mapImpl._registerValue);
    xil_printf("Linescanner 0, Register2: 0x%02X \r\n", linescanner0Config.getControlRegister2()._mapImpl._registerValue);
    xil_printf("Linescanner 0, Register3: 0x%02X \r\n", linescanner0Config.getControlRegister3()._mapImpl._registerValue);

    xil_printf("Linescanner 1, Register1: 0x%02X \r\n", linescanner1Config.getControlRegister1()._mapImpl._registerValue);
    xil_printf("Linescanner 1, Register2: 0x%02X \r\n", linescanner1Config.getControlRegister2()._mapImpl._registerValue);
    xil_printf("Linescanner 1, Register3: 0x%02X \r\n\r\n", linescanner1Config.getControlRegister3()._mapImpl._registerValue);
#endif
    xil_printf("Frequency analyzer 0 rised %d times \r\n", linescanner0PixelFrequencies._counter);
    xil_printf("Frequency analyzer 1 rised %d times \r\n", linescanner1PixelFrequencies._counter);

    xil_printf("\nFrequency analyzer 0 pixel0 frequency 0 %d \r\n", linescanner0PixelFrequencies._pixel0Frequency0);
    xil_printf("Frequency analyzer 0 pixel0 frequency 1 %d \r\n", linescanner0PixelFrequencies._pixel0Frequency1);
    xil_printf("Frequency analyzer 0 pixel1 frequency 0 %d \r\n", linescanner0PixelFrequencies._pixel1Frequency0);
    xil_printf("Frequency analyzer 0 pixel1 frequency 1 %d \r\n", linescanner0PixelFrequencies._pixel1Frequency1);
    xil_printf("Frequency analyzer 0 pixel2 frequency 0 %d \r\n", linescanner0PixelFrequencies._pixel2Frequency0);
    xil_printf("Frequency analyzer 0 pixel2 frequency 1 %d \r\n", linescanner0PixelFrequencies._pixel2Frequency1);

    xil_printf("\nFrequency analyzer 1 pixel0 frequency 0 %d \r\n", linescanner1PixelFrequencies._pixel0Frequency0);
    xil_printf("Frequency analyzer 1 pixel0 frequency 1 %d \r\n", linescanner1PixelFrequencies._pixel0Frequency1);
    xil_printf("Frequency analyzer 1 pixel1 frequency 0 %d \r\n", linescanner1PixelFrequencies._pixel1Frequency0);
    xil_printf("Frequency analyzer 1 pixel1 frequency 1 %d \r\n", linescanner1PixelFrequencies._pixel1Frequency1);
    xil_printf("Frequency analyzer 1 pixel2 frequency 0 %d \r\n", linescanner1PixelFrequencies._pixel2Frequency0);
    xil_printf("Frequency analyzer 1 pixel2 frequency 1 %d \r\n", linescanner1PixelFrequencies._pixel2Frequency1);

    // stop ...
    systemManager.stopImageCapture();
    printf("Application stopped \r\n");
#endif
    return 0;
}

void clearFrequencies()
{
    linescanner0PixelFrequencies._pixel0Frequency0 = 0;
    linescanner0PixelFrequencies._pixel0Frequency1 = 0;
    linescanner0PixelFrequencies._pixel1Frequency0 = 0;
    linescanner0PixelFrequencies._pixel1Frequency1 = 0;
    linescanner0PixelFrequencies._pixel2Frequency0 = 0;
    linescanner0PixelFrequencies._pixel2Frequency1 = 0;

    linescanner1PixelFrequencies._pixel0Frequency0 = 0;
    linescanner1PixelFrequencies._pixel0Frequency1 = 0;
    linescanner1PixelFrequencies._pixel1Frequency0 = 0;
    linescanner1PixelFrequencies._pixel1Frequency1 = 0;
    linescanner1PixelFrequencies._pixel2Frequency0 = 0;
    linescanner1PixelFrequencies._pixel2Frequency1 = 0;
}
