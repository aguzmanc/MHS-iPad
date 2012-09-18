#import <Foundation/Foundation.h>

#import "Globals.h"
#import "Interview.h"

@protocol AsyncListInterviewReceiverDelegate;

@interface InterviewService : NSObject
{
    id<AsyncListInterviewReceiverDelegate> _delegate;
    
    NSMutableData * _responseData;
    
}

// Initialization
-(id)initWithDelegate:(id<AsyncListInterviewReceiverDelegate>) delegate; 

// Public Methods
-(void)requestDataWithUserId:(NSString *)userId;


@end

// Allows receive async response
@protocol AsyncListInterviewReceiverDelegate

-(void)updateInterviewBytesReceived:(int)bytesCount;
-(void)receiveInterviews:(NSArray *)clients;

@end

