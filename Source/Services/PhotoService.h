#import <Foundation/Foundation.h>

#import "Globals.h"

@protocol AsyncProfileImageReceiverDelegate;

@interface PhotoService : NSObject
{
    id<AsyncProfileImageReceiverDelegate> _delegate;
    
    NSString * _profileNumber;
    bool _errorInTransfer;
    
    NSMutableData * _responseData;
}

// Initialization
-(id)initWithProfileImageReceiverDelegate:(id<AsyncProfileImageReceiverDelegate>) delegate 
                         andProfileNumber:(NSString *)profileNumber;

// Public Methods
-(void)obtainImageForFile:(NSString *)fileName;

@end






// Allows receive async response of an image from web
@protocol AsyncProfileImageReceiverDelegate

-(void)receiveImage:(UIImage *)image ForProfileNumber:(NSString *) profileNumber;
-(void)receiveImageErrorForProfileNumber:(NSString *)profileNumber;

@end