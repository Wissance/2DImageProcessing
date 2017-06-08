/*
 * Dragster line scanners readout test
 */

#include <stdio.h>
#include "imageCaptureManager.h"
#include "globalDefs.h"

extern PixelFrequencies linescanner0PixelFrequencies;
extern PixelFrequencies linescanner1PixelFrequencies;

#define SYNCH_FREQUENCY 1000 // Hz (period of mechanical part of system)
#define TESTING_TIME 1       // seconds
#define CYCLES_NUMBER SYNCH_FREQUENCY * TESTING_TIME
#define TICKS_TO_TIME_COEFF 100000

//#define SPI_TESTING

static void clearFrequencies();
static void displayFrequencies();

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

    displayFrequencies();
    // stop ...
    systemManager.stopImageCapture();
    printf("Application stopped \r\n");
#endif
    return 0;
}

void clearFrequencies()
{
	linescanner0PixelFrequencies._counter = 0;
    linescanner0PixelFrequencies._pixel0Frequency0 = 0;
    linescanner0PixelFrequencies._pixel0Frequency1 = 0;
    linescanner0PixelFrequencies._pixel1Frequency0 = 0;
    linescanner0PixelFrequencies._pixel1Frequency1 = 0;
    linescanner0PixelFrequencies._pixel2Frequency0 = 0;
    linescanner0PixelFrequencies._pixel2Frequency1 = 0;
    linescanner0PixelFrequencies._pixel0UnassignedFrequency = 0;

    linescanner1PixelFrequencies._counter = 0;
    linescanner1PixelFrequencies._pixel0Frequency0 = 0;
    linescanner1PixelFrequencies._pixel0Frequency1 = 0;
    linescanner1PixelFrequencies._pixel1Frequency0 = 0;
    linescanner1PixelFrequencies._pixel1Frequency1 = 0;
    linescanner1PixelFrequencies._pixel2Frequency0 = 0;
    linescanner1PixelFrequencies._pixel2Frequency1 = 0;
    linescanner1PixelFrequencies._pixel0UnassignedFrequency = 0;
}

void displayFrequencies()
{
    printf("Frequency analyzer 0 rised %d times \r\n", linescanner0PixelFrequencies._counter);
    printf("Frequency analyzer 1 rised %d times \r\n", linescanner1PixelFrequencies._counter);

    printf("Total analyzer time: %.4f seconds \r\n", (double)TESTING_TIME);
    printf("Total one channel time (one dragster): %.4f seconds \r\n", (double)TESTING_TIME/2);

    double pixel0f0Ratio = ((double)linescanner0PixelFrequencies._pixel0Frequency0 / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    double pixel0f1Ratio = ((double)linescanner0PixelFrequencies._pixel0Frequency1 / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    double unassignedPixel0Ratio = ((double)linescanner0PixelFrequencies._pixel0UnassignedFrequency / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    if(unassignedPixel0Ratio > 100.0)
    	unassignedPixel0Ratio = 100.0;

    printf("\nFrequency analyzer 0 pixel0 frequency 0 (5 kHz) %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
           linescanner0PixelFrequencies._pixel0Frequency0,
           (double)linescanner0PixelFrequencies._pixel0Frequency0 / TICKS_TO_TIME_COEFF, pixel0f0Ratio);
    printf("Frequency analyzer 0 pixel0 frequency 1 (10 kHz) %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
           linescanner0PixelFrequencies._pixel0Frequency1,
           (double)linescanner0PixelFrequencies._pixel0Frequency1 / TICKS_TO_TIME_COEFF, pixel0f1Ratio);
    printf("Frequency analyzer 0 pixel0 unassigned frequency %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
           linescanner0PixelFrequencies._pixel0UnassignedFrequency,
           (double)linescanner0PixelFrequencies._pixel0UnassignedFrequency / TICKS_TO_TIME_COEFF, unassignedPixel0Ratio);

    double pixel1f0Ratio = ((double)linescanner0PixelFrequencies._pixel1Frequency0 / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    double pixel1f1Ratio = ((double)linescanner0PixelFrequencies._pixel1Frequency1 / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    double unassignedPixel1Ratio = ((double)linescanner0PixelFrequencies._pixel1UnassignedFrequency / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    if(unassignedPixel1Ratio > 100.0)
      	unassignedPixel1Ratio = 100.0;

    printf("Frequency analyzer 0 pixel1 frequency 0 (15 kHz) %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
           linescanner0PixelFrequencies._pixel1Frequency0,
           (double)linescanner0PixelFrequencies._pixel1Frequency0 / TICKS_TO_TIME_COEFF, pixel1f0Ratio);
    printf("Frequency analyzer 0 pixel1 frequency 1 (20 kHz)  %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
           linescanner0PixelFrequencies._pixel1Frequency1,
           (double)linescanner0PixelFrequencies._pixel1Frequency1 / TICKS_TO_TIME_COEFF, pixel1f1Ratio);
    printf("Frequency analyzer 0 pixel1 unassigned frequency %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
           linescanner0PixelFrequencies._pixel1UnassignedFrequency,
           (double)linescanner0PixelFrequencies._pixel1UnassignedFrequency / TICKS_TO_TIME_COEFF, unassignedPixel1Ratio);

    double pixel2f0Ratio = ((double)linescanner0PixelFrequencies._pixel2Frequency0 / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    double pixel2f1Ratio = ((double)linescanner0PixelFrequencies._pixel2Frequency1 / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    double unassignedPixel2Ratio = ((double)linescanner0PixelFrequencies._pixel2UnassignedFrequency / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    if(unassignedPixel2Ratio > 100.0)
      	unassignedPixel2Ratio = 100.0;

    printf("Frequency analyzer 0 pixel2 frequency 0 (25 kHz) %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
           linescanner0PixelFrequencies._pixel2Frequency0,
           (double)linescanner0PixelFrequencies._pixel2Frequency0 / TICKS_TO_TIME_COEFF, pixel2f0Ratio);
    printf("Frequency analyzer 0 pixel2 frequency 1 (30 kHz) %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
           linescanner0PixelFrequencies._pixel2Frequency1,
           (double)linescanner0PixelFrequencies._pixel2Frequency1 / TICKS_TO_TIME_COEFF, pixel2f1Ratio);
    printf("Frequency analyzer 0 pixel2 unassigned frequency %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
           linescanner0PixelFrequencies._pixel2UnassignedFrequency,
           (double)linescanner0PixelFrequencies._pixel2UnassignedFrequency / TICKS_TO_TIME_COEFF, unassignedPixel2Ratio);

    pixel0f0Ratio = ((double)linescanner1PixelFrequencies._pixel0Frequency0 / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    pixel0f1Ratio = ((double)linescanner1PixelFrequencies._pixel0Frequency1 / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    unassignedPixel0Ratio = ((double)linescanner1PixelFrequencies._pixel0UnassignedFrequency / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    if(unassignedPixel0Ratio > 100.0)
     	unassignedPixel0Ratio = 100.0;

    printf("\nFrequency analyzer 1 pixel0 frequency 0 %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
           linescanner1PixelFrequencies._pixel0Frequency0,
           (double)linescanner1PixelFrequencies._pixel0Frequency0 / TICKS_TO_TIME_COEFF, pixel0f0Ratio);
    printf("Frequency analyzer 1 pixel0 frequency 1 %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
    	   linescanner1PixelFrequencies._pixel0Frequency1,
		   (double)linescanner1PixelFrequencies._pixel0Frequency1 / TICKS_TO_TIME_COEFF, pixel0f1Ratio);
    printf("Frequency analyzer 1 pixel0 unassigned frequency %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
    	   linescanner1PixelFrequencies._pixel0UnassignedFrequency,
		   (double)linescanner1PixelFrequencies._pixel0UnassignedFrequency / TICKS_TO_TIME_COEFF, unassignedPixel0Ratio);

    pixel1f0Ratio = ((double)linescanner1PixelFrequencies._pixel1Frequency0 / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    pixel1f1Ratio = ((double)linescanner1PixelFrequencies._pixel1Frequency1 / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    unassignedPixel1Ratio = ((double)linescanner1PixelFrequencies._pixel1UnassignedFrequency / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    if(unassignedPixel1Ratio > 100.0)
       	unassignedPixel1Ratio = 100.0;

    printf("Frequency analyzer 1 pixel1 frequency 0 %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
    	   linescanner1PixelFrequencies._pixel1Frequency0,
		   (double)linescanner1PixelFrequencies._pixel1Frequency0 / TICKS_TO_TIME_COEFF, pixel1f0Ratio);
    printf("Frequency analyzer 1 pixel1 frequency 1 %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
    	   linescanner1PixelFrequencies._pixel1Frequency1,
		   (double)linescanner1PixelFrequencies._pixel1Frequency1 / TICKS_TO_TIME_COEFF, pixel1f1Ratio);
    printf("Frequency analyzer 1 pixel1 unassigned frequency %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
           linescanner1PixelFrequencies._pixel1UnassignedFrequency,
           (double)linescanner1PixelFrequencies._pixel1UnassignedFrequency / TICKS_TO_TIME_COEFF, unassignedPixel1Ratio);

    pixel2f0Ratio = ((double)linescanner1PixelFrequencies._pixel2Frequency0 / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    pixel2f1Ratio = ((double)linescanner1PixelFrequencies._pixel2Frequency1 / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    unassignedPixel2Ratio = ((double)linescanner1PixelFrequencies._pixel2UnassignedFrequency / TICKS_TO_TIME_COEFF) / ((double)TESTING_TIME * 1000 / 2) * 100;
    if(unassignedPixel2Ratio > 100.0)
       	unassignedPixel2Ratio = 100.0;

    printf("Frequency analyzer 1 pixel2 frequency 0 %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
    	   linescanner1PixelFrequencies._pixel2Frequency0,
		   (double)linescanner1PixelFrequencies._pixel2Frequency0 / TICKS_TO_TIME_COEFF, pixel2f0Ratio);
    printf("Frequency analyzer 1 pixel2 frequency 1 %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
    	   linescanner1PixelFrequencies._pixel2Frequency1,
		   (double)linescanner1PixelFrequencies._pixel2Frequency1 / TICKS_TO_TIME_COEFF, pixel2f1Ratio);
    printf("Frequency analyzer 0 pixel2 unassigned frequency %d ticks or, %.4f milliseconds [%.2f %%]\r\n",
           linescanner1PixelFrequencies._pixel2UnassignedFrequency,
           (double)linescanner1PixelFrequencies._pixel2UnassignedFrequency / TICKS_TO_TIME_COEFF, unassignedPixel2Ratio);
}
