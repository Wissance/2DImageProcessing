#include "frequencyAnalyzerManagerConfig.h"

 void FrequecnyAnalyzerManagerConfig :: setPointStartIndex(unsigned char index, unsigned short value)
 {
     if(index == 0)
         _point0StartIndex = value;
     else if (index == 1)
         _point1StartIndex = value;
     else _point2StartIndex = value;
 }

 unsigned char FrequecnyAnalyzerManagerConfig :: getPointStartIndex(unsigned char index)
 {
     if(index == 0)
         return _point0StartIndex;
     else if (index == 1)
         return _point1StartIndex;
     else return _point2StartIndex;
 }

 void FrequecnyAnalyzerManagerConfig :: setPointStopIndex(unsigned char index, unsigned short value)
 {
     if(index == 0)
         _point0StopIndex = value;
     else if (index == 1)
         _point1StopIndex = value;
     else _point2StopIndex = value;
 }

 unsigned char FrequecnyAnalyzerManagerConfig :: getPointStopIndex(unsigned char index)
 {
     if(index == 0)
         return _point0StopIndex;
     else if (index == 1)
         return _point1StopIndex;
     else return _point2StopIndex;
 }

