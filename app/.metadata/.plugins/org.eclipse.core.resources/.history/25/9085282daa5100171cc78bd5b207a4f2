#ifndef SRC_MANAGERS_IMAGECAPTUREMANAGER_H_
#define SRC_MANAGERS_IMAGECAPTUREMANAGER_H_

#include "imageCaptureState.h"
#include "dragsterConfig.h"
#include "pixelFrequencies.h"
#ifdef USE_AXI_QUAD_SPI
#include "xspi.h"
#endif
#include "xscugic.h"
#include "xil_exception.h"
#include "xil_assert.h"

//#define USE_AXI_QUAD_SPI

extern PixelFrequencies linescanner0PixelFrequencies;
extern PixelFrequencies linescanner1PixelFrequencies;

class ImageCaptureManager
{
public:
    void initialize();
    void resetImageCapture();
    void startImageCapture();
    void stopImageCapture();
#ifdef USE_AXI_QUAD_SPI
    DragsterConfig getDragsterConfig(unsigned char linescannerIndex);
    void updateDragsters();
    void sendTestSpiSequence();   //todo: umv: test method
#endif
private:
    void configureInterrupts();
#ifdef USE_AXI_QUAD_SPI
    // dragster
    void initializeSpi();
    void initializeDragsters();
    void initializeDragsterImpl(DragsterConfig* config, int dragsterSlaveSelectMask);
    void readDragsterConfigImpl(DragsterConfig* config, int dragsterSlaveSelectMask);
    void sendDragsterRegisterValue(unsigned char address, unsigned char value);
    unsigned char readDragsterRegisterValue(unsigned char address);
    void beginDragsterSpiTransaction(unsigned char slaveNumbe);
    void endDragsterSpiTransaction();
#endif
private:
    // interrupt controller
    XScuGic _interruptController;
    // dragster entities
#ifdef USE_AXI_QUAD_SPI
    XSpi _spi;
#endif
    ImageCaptureState _imageCaptureState;
    DragsterConfig _linescanner0Config;
    DragsterConfig _linescanner1Config;
};


#endif /* SRC_MANAGERS_IMAGECAPTUREMANAGER_H_ */
