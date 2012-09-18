#import <Foundation/Foundation.h>

#import "Globals.h"

#define TOTAL_SIZE_CLIENTS_SERVICE_IDENTIFIER @"clients"
#define TOTAL_SIZE_INTERVIEWS_SERVICE_IDENTIFIER @"interview_list"

@protocol TotalSizeServiceDelegate;

@interface TotalSizeService : NSObject
{
    id<TotalSizeServiceDelegate> _delegate;
    
    NSString * _serviceIdentifier;
    
    NSMutableData * _responseData;
}


// Initialization
-(id)initWithDelegate:(id<TotalSizeServiceDelegate>)delegate;

// Public Methods
-(void)requestSizeForService:(NSString *) serviceId WithUserId:(NSString *)userId;

@end


@protocol TotalSizeServiceDelegate

-(void)receiveTotalSizeInBytes:(int)size ForService:(NSString *) service;

@end
