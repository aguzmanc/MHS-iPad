#import <Foundation/Foundation.h>

@protocol ProgressServiceDelegate;


@interface ProgressService : NSObject
{
	NSMutableData * responseData;	
	
	id<ProgressServiceDelegate> _delegate;
	
    NSNumber * indexProgress;
    NSNumber * totalSize;   
}

// Initialization
-(id)initWithDelegate:(id<ProgressServiceDelegate>)delegate;

// Public Methods
-(void)initProgress:(NSString *) idUser;


@end


@protocol ProgressServiceDelegate

-(void)indexService:(NSNumber *)indexvalor;

@end