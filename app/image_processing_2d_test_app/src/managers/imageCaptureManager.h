#ifndef SRC_MANAGERS_IMAGECAPTUREMANAGER_H_
#define SRC_MANAGERS_IMAGECAPTUREMANAGER_H_

#include "xscugic.h"
#include "xil_exception.h"
#include "xil_assert.h"
#include "imageCaptureState.h"
#include "dragsterConfig.h"
#include "pixelFrequencies.h"
#include "frequencyAnalyzerManagerConfig.h"

extern PixelFrequencies linescanner0PixelFrequencies;
extern PixelFrequencies linescanner1PixelFrequencies;

void clearFrequencies();

class ImageCaptureManager
{
public:
    void initialize();
    void resetImageCapture();
    void startImageCapture();
    void stopImageCapture();
    DragsterConfig* getDragsterConfig(unsigned char linescannerIndex);
private:
    void configureInterrupts();
    void configureFrequencyAnalyzerManagers();
private:
    // interrupt controller
    XScuGic _interruptController;
    // dragster entities
    ImageCaptureState _imageCaptureState;
    FrequecnyAnalyzerManagerConfig _analyzerManager0Configs;
    FrequecnyAnalyzerManagerConfig _analyzerManager1Configs;
    DragsterConfig _linescanner0Config;
    DragsterConfig _linescanner1Config;
};


#endif /* SRC_MANAGERS_IMAGECAPTUREMANAGER_H_ */
