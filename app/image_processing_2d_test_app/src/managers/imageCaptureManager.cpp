#include "imageCaptureManager.h"
#include "axiIoHelper.h"
#include "modulesMap.h"
#include "globalDefs.h"
#include "xparameters.h"
#include "xil_exception.h"

#define SPI_DEVICE_ID XPAR_SPI_0_DEVICE_ID

#define START_COMMAND 1
#define STOP_COMMAND 2
#define RESET_COMMAND 3

#define LINESCANNER0_SLAVE_SELECT 1
#define LINESCANNER1_SLAVE_SELECT 2

#define FREQUENCY_ANALYZER_0_INTERRUPT_ID XPAR_FABRIC_FREQUENCY_ANALYZER_MANAGER_0_IRQ_INTR
#define FREQUENCY_ANALYZER_1_INTERRUPT_ID XPAR_FABRIC_FREQUENCY_ANALYZER_MANAGER_1_IRQ_INTR

#define INTERRUPT_CONTROLLER_DEVICE_ID XPAR_SCUGIC_SINGLE_DEVICE_ID

#ifdef USE_AXI_QUAD_SPI
u8 readBuffer[2];
u8 writeBuffer[2];
#endif

PixelFrequencies linescanner0PixelFrequencies;
PixelFrequencies linescanner1PixelFrequencies;

void freuqencyAnalyzer0Handler(void *data)
{
    linescanner0PixelFrequencies._counter++;
    // TODO: UMV: COMMENTED: BACEUSE LONG OPERATION BREAKES INTERUPT HANDLER 1
    //xil_printf("Frequency analyzer 0 rised %d times \r\n", linescanner0PixelFrequencies._counter);
    //xil_printf("Frequency analyzer 1 rised %d times \r\n", linescanner1PixelFrequencies._counter);
    linescanner0PixelFrequencies._pixel0Frequency0 += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 0);
    linescanner0PixelFrequencies._pixel0Frequency1 += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 4);
    linescanner0PixelFrequencies._pixel1Frequency0 += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 8);
    linescanner0PixelFrequencies._pixel1Frequency1 += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 12);
    linescanner0PixelFrequencies._pixel2Frequency0 += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 16);
    linescanner0PixelFrequencies._pixel2Frequency1 += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 20);
    linescanner0PixelFrequencies._pixel0UnassignedFrequency += read(FREQUENCY_ANALYZER0_BASE_ADDRESS, 24);
}

void freuqencyAnalyzer1Handler(void *data)
{
    linescanner1PixelFrequencies._counter++;
    // TODO: UMV: COMMENTED: BACEUSE LONG OPERATION BREAKES INTERUPT HANDLER 0
    //xil_printf("Frequency analyzer 0 rised %d times \r\n", linescanner0PixelFrequencies._counter);
    //xil_printf("Frequency analyzer 1 rised %d times \r\n", linescanner1PixelFrequencies._counter);
    linescanner1PixelFrequencies._pixel0Frequency0 += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 0);
    linescanner1PixelFrequencies._pixel0Frequency1 += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 4);
    linescanner1PixelFrequencies._pixel1Frequency0 += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 8);
    linescanner1PixelFrequencies._pixel1Frequency1 += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 12);
    linescanner1PixelFrequencies._pixel2Frequency0 += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 16);
    linescanner1PixelFrequencies._pixel2Frequency1 += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 20);
    linescanner1PixelFrequencies._pixel0UnassignedFrequency += read(FREQUENCY_ANALYZER1_BASE_ADDRESS, 24);
}

void ImageCaptureManager::initialize()
{
#ifdef USE_AXI_QUAD_SPI
    initializeSpi();
    initializeDragsters();
#endif
    configureInterrupts();
}

void ImageCaptureManager::startImageCapture()
{
    //Xil_Out32(IMAGE_CAPTURE_MANAGER_BASE_ADDRESS, 1);
    write(IMAGE_CAPTURE_MANAGER_BASE_ADDRESS, 0, START_COMMAND);
    xil_printf("\n Image Capture Manager has been started\n\r");
}

void ImageCaptureManager::stopImageCapture()
{
    //Xil_Out32(IMAGE_CAPTURE_MANAGER_BASE_ADDRESS, 2);
    write(IMAGE_CAPTURE_MANAGER_BASE_ADDRESS, 0, STOP_COMMAND);
    xil_printf("\n Image Capture Manager has been stopped\n\r");
}

void ImageCaptureManager::resetImageCapture()
{
    //Xil_Out32(IMAGE_CAPTURE_MANAGER_BASE_ADDRESS, 2);
    write(IMAGE_CAPTURE_MANAGER_BASE_ADDRESS, 0, RESET_COMMAND);
    xil_printf("\n Image Capture Manager has been reseted\n\r");
}

void ImageCaptureManager::configureInterrupts()
{
    XScuGic_Config* config = XScuGic_LookupConfig(INTERRUPT_CONTROLLER_DEVICE_ID);
    if(!config)
        xil_printf("\n XScuGic_LookupConfig failed \r\n");
    int status = XScuGic_CfgInitialize(&_interruptController, config, config->CpuBaseAddress);
    if (status != XST_SUCCESS)
        xil_printf("\n XScuGic_CfgInitialize \r\n");
    // Set priority and trigger type.
    //    Priority range: 0...248.
    //    Trigger types:
    //        Software-generated Interrupts(SFI): 2(always);
    //        Private Peripheral Interrupt(PPI): 1(Active HIGH), 3(Rising edge);
    //        Shared Peripheral Interrupts(SPI): 1(Active HIGH), 3(Rising edge);*/
    XScuGic_SetPriorityTriggerType(&_interruptController, FREQUENCY_ANALYZER_0_INTERRUPT_ID, 0xA0, 0x3);
    XScuGic_SetPriorityTriggerType(&_interruptController, FREQUENCY_ANALYZER_1_INTERRUPT_ID, 0xA0, 0x3);

    status = XScuGic_Connect(&_interruptController, FREQUENCY_ANALYZER_0_INTERRUPT_ID,
                            (Xil_InterruptHandler)freuqencyAnalyzer0Handler, NULL);
    if (status != XST_SUCCESS)
        xil_printf("\n XScuGic_Connect failed (Frequency analyzer manager 0) \r\n");
    //
    status = XScuGic_Connect(&_interruptController,  FREQUENCY_ANALYZER_1_INTERRUPT_ID,
                             (Xil_InterruptHandler)freuqencyAnalyzer1Handler, NULL);
    if (status != XST_SUCCESS)
        xil_printf("\n XScuGic_Connect failed (Frequency analyzer manager 1) \r\n");

    XScuGic_Enable(&_interruptController,  FREQUENCY_ANALYZER_0_INTERRUPT_ID);
    XScuGic_Enable(&_interruptController,  FREQUENCY_ANALYZER_1_INTERRUPT_ID);

    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_IRQ_INT, (Xil_ExceptionHandler)XScuGic_InterruptHandler, &_interruptController);

    Xil_ExceptionEnable();
}

#ifdef USE_AXI_QUAD_SPI
DragsterConfig ImageCaptureManager::getDragsterConfig(unsigned char linescannerIndex)
{
    struct DragsterConfig config;
    readDragsterConfigImpl(&config, linescannerIndex == LINESCANNER0 ? LINESCANNER0_SLAVE_SELECT
                                                                     : LINESCANNER1_SLAVE_SELECT);
    return config;
}


/* Инициализация SPI в блокирующем режиме (polling mode)*/
void ImageCaptureManager::initializeSpi()
{
    int status;

    /* Запрашиваем конфигурацию устройства */
    XSpi_Config* spiConfig = XSpi_LookupConfig(SPI_DEVICE_ID);
    if(!spiConfig)
        xil_printf("\n XSpi_LookupConfig Failed\n\r");
    _spi.NumSlaveBits = 2;
    _spi.SpiMode = XSP_STANDARD_MODE;

    /* Инициализируем экземпляр SPI */
    status = XSpi_CfgInitialize(&_spi, spiConfig, spiConfig->BaseAddress);
    if(status != XST_SUCCESS)
        xil_printf("\n XSpi_CfgInitialize Failed\n\r");

    /* По умолчанию SPI является Slave, опция ниже конфигурирует его как Master */
     status = XSpi_SetOptions(&_spi, XSP_MASTER_OPTION);
    if(status != XST_SUCCESS)
        xil_printf("\n XSpi_SetOptions Failed\n\r");
    /* Запускаем SPI */

    XSpi_Start(&_spi);

    /* Деактивируем SPI прерывания */
    XSpi_IntrGlobalDisable(&_spi);
}

void ImageCaptureManager::initializeDragsters()
{
    // dragster0 config
    _linescanner0Config.setControlRegister1(//0xAD);   // Clock divider = 2
                                            0xA9);   // Clock divider = 1
    _linescanner0Config.setControlRegister2(0x32);
    _linescanner0Config.setControlRegister3(0x13);
    _linescanner0Config.setEndOfRangeRegister(0x08);
    // dragster1 config
    _linescanner1Config.setControlRegister1(//0xAB);   // Clock divider = 2
                                            0xA9);   // Clock divider = 1
    _linescanner1Config.setControlRegister2(0x32);
    _linescanner1Config.setControlRegister3(0x13);
    _linescanner1Config.setEndOfRangeRegister(0x08);
    initializeDragsterImpl(&_linescanner0Config, LINESCANNER0_SLAVE_SELECT);
    initializeDragsterImpl(&_linescanner1Config, LINESCANNER1_SLAVE_SELECT);
    // deselecting any slave
    XSpi_SetSlaveSelect(&_spi, 0);
}

void ImageCaptureManager::updateDragsters()
{
	sendDragsterRegisterValue(CONTROL_REGISTER_1_ADDRESS, _linescanner0Config.getControlRegister1()._mapImpl._registerValue);
	sendDragsterRegisterValue(CONTROL_REGISTER_1_ADDRESS, _linescanner1Config.getControlRegister1()._mapImpl._registerValue);
}

void ImageCaptureManager::sendTestSpiSequence()
{
	const unsigned char testSequence = 0xAA;
	int status = XSpi_SetSlaveSelect(&_spi, LINESCANNER0_SLAVE_SELECT);
    if(status == XST_SUCCESS)
	    sendDragsterRegisterValue(CONTROL_REGISTER_2_ADDRESS, testSequence);
    XSpi_SetSlaveSelect(&_spi, 0);
}

void ImageCaptureManager::readDragsterConfigImpl(DragsterConfig* config, int dragsterSlaveSelectMask)
{
	beginDragsterSpiTransaction(dragsterSlaveSelectMask);
    config->setControlRegister1(readDragsterRegisterValue(1));
    endDragsterSpiTransaction();

    beginDragsterSpiTransaction(dragsterSlaveSelectMask);
    config->setControlRegister2(readDragsterRegisterValue(2));
    endDragsterSpiTransaction();

    beginDragsterSpiTransaction(dragsterSlaveSelectMask);
    config->setControlRegister3(readDragsterRegisterValue(3));
    endDragsterSpiTransaction();
}

void ImageCaptureManager::initializeDragsterImpl(DragsterConfig* config, int dragsterSlaveSelectMask)
{
    // CONTROL Register 2
   beginDragsterSpiTransaction(dragsterSlaveSelectMask);
   sendDragsterRegisterValue(CONTROL_REGISTER_2_ADDRESS, config->getControlRegister2()._mapImpl._registerValue);
   endDragsterSpiTransaction();

   // CONTROL Register 3
   beginDragsterSpiTransaction(dragsterSlaveSelectMask);
   sendDragsterRegisterValue(CONTROL_REGISTER_3_ADDRESS, config->getControlRegister3()._mapImpl._registerValue);
   endDragsterSpiTransaction();

   // End of Data Register
   beginDragsterSpiTransaction(dragsterSlaveSelectMask);
   sendDragsterRegisterValue(END_OF_RANGE_REGISTER_ADDRESS, config->getEndOfRangeRegister());  // 8 bit pixels value
   endDragsterSpiTransaction();

   // CONTROL Register 1
   beginDragsterSpiTransaction(dragsterSlaveSelectMask);
   sendDragsterRegisterValue(CONTROL_REGISTER_1_ADDRESS, config->getControlRegister1()._mapImpl._registerValue);
   endDragsterSpiTransaction();
}

void ImageCaptureManager::sendDragsterRegisterValue(unsigned char address, unsigned char value)
{
    unsigned char convertedAddress = convertFromMsbToLsbFirst(address);
    writeBuffer[1] = convertedAddress;
    unsigned char convertedValue = convertFromMsbToLsbFirst(value);
    writeBuffer[0] = convertedValue;
    XSpi_Transfer(&_spi, writeBuffer, NULL, 2);
}

unsigned char ImageCaptureManager::readDragsterRegisterValue(unsigned char address)
{
	unsigned char readRegisterAddress = 0x0F;
	readBuffer[0] = 0;
    writeBuffer[0] = convertFromMsbToLsbFirst(readRegisterAddress);
    writeBuffer[1] = convertFromMsbToLsbFirst(address);
    int result = XSpi_Transfer(&_spi, writeBuffer, NULL, 2);
    if(result != -XST_SUCCESS)
        xil_printf("Read fails, reason %d", result);
    return convertFromLsbToMsbFirst(readBuffer[0]);
}

void ImageCaptureManager::beginDragsterSpiTransaction(unsigned char slaveNumber)
{
	XSpi_SetSlaveSelect(&_spi, slaveNumber);
}

void ImageCaptureManager::endDragsterSpiTransaction()
{
    XSpi_SetSlaveSelect(&_spi, 0);
}
#endif
