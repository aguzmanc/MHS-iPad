#import <UIKit/UIKit.h>

#import "Logic.h"

@interface InitializationController : UIViewController <InitializationDelegate>
{
    Logic * _logic;
    IBOutlet UIProgressView * _myprogressview;
    NSNumber * _index;
    NSNumber * _total;
    NSTimer *timer;
}

//public method
-(void)setLogic:(Logic *)logic;

// Initialization Delegate
-(void)updatePercentageProgress:(int)percentage;


@end



