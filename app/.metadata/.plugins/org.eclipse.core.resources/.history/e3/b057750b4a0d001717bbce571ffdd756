#ifndef SRC_DATA_DRAGSTERCONFIG_H_
#define SRC_DATA_DRAGSTERCONFIG_H_

#define CONTROL_REGISTER_1_ADDRESS        0x01
#define CONTROL_REGISTER_2_ADDRESS        0x02
#define ADC_GAIN_REGISTER_ADDRESS         0x03
#define OFFSET_REGISTER_1_ADDRESS         0x04
#define CONTROL_REGISTER_3_ADDRESS        0x05
#define THRESHOLD_REGISTER_1_ADDRESS      0x06
#define THRESHOLD_REGISTER_2_ADDRESS      0x07
#define THRESHOLD_REGISTER_3_ADDRESS      0x08
#define END_OF_RANGE_REGISTER_ADDRESS     0x09
#define TEST_MULTIPLEXOR_REGISTER_ADDRESS 0x0A

unsigned char convertFromMsbToLsbFirst(unsigned char byte);
unsigned char convertFromLsbToMsbFirst(unsigned char byte);

struct DragsterControlRegister1
{
    union
    {
        struct
        {
            unsigned char _updateRequest : 1;     // bit 0
            unsigned char _mainClockDivider : 2;  // bit 1, 2
            unsigned char _dithering : 1;         // bit 3
            unsigned char _offsetSubtraction : 1; // bit 4
            unsigned char _saturationEnabled : 1; // bit 5
            unsigned char _adcMode : 1;           // bit 6
            unsigned char _vThreshold : 1;        // bit 7
        };
        unsigned char _registerValue;
    };
};

struct DragsterControlRegister2
{
    union
    {
        struct
        {
            unsigned char _autoGenerateLoadPulse : 1; // bit 0
            unsigned char _enableControlOffset : 1;   // bit 1
            unsigned char _writeOffset : 1;           // bit 2
            unsigned char _enableAntiblooming : 1;    // bit 3
            unsigned char _enableWhiteClamping : 1;   // bit 4
            unsigned char _analogGain : 1;            // bit 5
            unsigned char : 2;                        // bit 6, 7
        };
        unsigned char _registerValue;
    };
};

struct DragsterControlRegister3
{
    union
    {
        struct
        {
            unsigned char _pixelClockEnablede : 1; // bit 0
            unsigned char _reLinearization : 1;    // bit 1
            unsigned char _enableOffsetSram : 1;   // bit 2
            unsigned char _bandgapSwitch : 3;      // bit 3, 4, 5
            unsigned char : 2;                     // bit 6, 7
        };
        unsigned char _registerValue;
    };
};

class DragsterConfig
{
public:
    DragsterControlRegister1 getControlRegister1() {return _controlRegister1;}
    void setControlRegister1(unsigned char value) {_controlRegister1._registerValue = value;}
    DragsterControlRegister2 getControlRegister2() {return _controlRegister2;}
    void setControlRegister2(unsigned char value) {_controlRegister2._registerValue = value;}
    DragsterControlRegister3 getControlRegister3() {return _controlRegister3;}
    void setControlRegister3(unsigned char value) {_controlRegister3._registerValue = value;}
    unsigned char getAdcGainRegister() {return _adcGainRegister;}
    void setAdcGainRegister(unsigned char value) {_adcGainRegister = value;}
    unsigned char getOffsetRegister() {return _offsetRegister;}
    void setOffsetRegister(unsigned char value) {_offsetRegister = value;}
    unsigned char getThresholdRegister1() {return _thresholdRegister1;}
    void setThresholdRegister1(unsigned char value) {_thresholdRegister1 = value;}
    unsigned char getThresholdRegister2() {return _thresholdRegister2;}
    void setThresholdRegister2(unsigned char value) {_thresholdRegister2 = value;}
    unsigned char getThresholdRegister3() {return _thresholdRegister3;}
    void setThresholdRegister3(unsigned char value) {_thresholdRegister3 = value;}
    unsigned char getEndOfRangeRegister() {return _endOfRangeRegister;}
    void setEndOfRangeRegister(unsigned char value) {_endOfRangeRegister = value;}
    unsigned char getTestMultiplexorRegister() {return _testMultiplexorRegister;}
    void setTestMultiplexorRegister(unsigned char value) {_testMultiplexorRegister = value;}
private:
    DragsterControlRegister1 _controlRegister1;
    DragsterControlRegister2 _controlRegister2;
    DragsterControlRegister3 _controlRegister3;
    unsigned char _adcGainRegister;
    unsigned char _offsetRegister;
    unsigned char _thresholdRegister1;
    unsigned char _thresholdRegister2;
    unsigned char _thresholdRegister3;
    unsigned char _endOfRangeRegister;
    unsigned char _testMultiplexorRegister;
};




#endif /* SRC_DATA_DRAGSTERCONFIG_H_ */
