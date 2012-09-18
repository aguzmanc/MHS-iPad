#import <Foundation/Foundation.h>

#import "Client.h"

@interface Interview : NSObject
{
    NSString * _interviewId;
    NSDate * _scheduleDate;
    NSDate * _date;
    NSDate * _interviewTime;
    int _scheduleWeekday;
    NSDate * _startTime;
    NSDate * _endTime;
    double _cost;
    NSString * _comment;

    bool _visited;

    Client * _client;
    NSString * _profileNumber; // to link with related client
}

// Properties
@property (strong, nonatomic) NSString * interviewId;
@property (strong, nonatomic) NSDate * startTime;
@property (strong, nonatomic) NSDate * endTime;
@property (nonatomic) double cost;
@property (strong, nonatomic) NSString * comment;
@property (nonatomic) bool visited;
@property (strong, nonatomic) Client * client;
@property (strong, nonatomic) NSString * profileNumber;
@property (strong, nonatomic) NSDate * scheduleDate;
@property (strong, nonatomic) NSDate * date;
@property (strong, nonatomic) NSDate * interviewTime;
@property (nonatomic) int scheduleWeekday;

@end
