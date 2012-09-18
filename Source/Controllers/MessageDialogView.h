#import <UIKit/UIKit.h>

#import "Logic.h"

@interface MessageDialogView : UIViewController
{
    
    Logic * _logic;
    
    
}

//public method
-(void)setLogic:(Logic *)logic;


-(IBAction)yesClick:(id)sender;
-(IBAction)noClick:(id)sender;
@end
