#ifndef SRC_DATA_FREQUENCYANALYZERMANAGERCONFIG_H_
#define SRC_DATA_FREQUENCYANALYZERMANAGERCONFIG_H_

#define THRESHOLD_INDEX             9
#define POIN0_START_INDEX          10
#define POIN0_STOP_INDEX           11
#define POIN1_START_INDEX          12
#define POIN1_STOP_INDEX           13
#define POIN2_START_INDEX          14
#define POIN2_STOP_INDEX           15
#define POINS_PIXEL_WIDTH_INDEX    16

class FrequecnyAnalyzerManagerConfig
{
public:
    unsigned char getThreshold() {return _threshold;}
    void setThreshold(unsigned char value) {_threshold = value;}
    unsigned char getPointStartIndex(unsigned char index);
    void setPointStartIndex(unsigned char index, unsigned short value);
    unsigned char getPointStopIndex(unsigned char index);
    void setPointStopIndex(unsigned char index, unsigned short value);
private:
    unsigned char _threshold;
    unsigned short _point0StartIndex;
    unsigned short _point0StopIndex;
    unsigned short _point1StartIndex;
    unsigned short _point1StopIndex;
    unsigned short _point2StartIndex;
    unsigned short _point2StopIndex;
    unsigned char _pointPixelWidth;
};



#endif /* SRC_DATA_FREQUENCYANALYZERMANAGERCONFIG_H_ */
