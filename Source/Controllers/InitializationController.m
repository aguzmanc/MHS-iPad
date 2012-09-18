#import "InitializationController.h"

@implementation InitializationController


#pragma mark Initialization

-(id)init
{
    self = [super initWithNibName:@"InitializationView" bundle:nil];
    if (!self) return nil;
    
    return self;
}


-(void)setLogic:(Logic *)logic
{
    _logic = logic;
}






#pragma mark - Initialization Delegate
-(void)updatePercentageProgress:(int)percentage
{
    _myprogressview.progress = percentage/100.0f;
    
}







#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];   
}



- (void)viewDidUnload
{
    [super viewDidUnload];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{    
	return UIInterfaceOrientationIsPortrait(orientation);
}

@end
