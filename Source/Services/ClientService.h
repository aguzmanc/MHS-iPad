#import <Foundation/Foundation.h>

#import "Globals.h"
#import "Client.h"

@protocol AsyncListClientReceiverDelegate;

@interface ClientService : NSObject
{
    id<AsyncListClientReceiverDelegate> _delegate;
    
    NSMutableData * _responseData;
}

// Initialization
-(id)initWithDelegate:(id<AsyncListClientReceiverDelegate>) delegate; 

// Public Methods
-(void)requestDataWithUserId:(NSString *)userId;
                         
@end






// Allows receive async response
@protocol AsyncListClientReceiverDelegate

-(void)updateClientBytesReceived:(int)bytesCount;
-(void)receiveClients:(NSArray *)clients;

@end