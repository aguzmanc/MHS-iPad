#import "InterviewCell.h"

@implementation InterviewCell

@synthesize logic = _logic;
@synthesize interview = _interview;


#pragma Mark - Public Methods

-(void)setImage:(UIImage *)img
{
    _imgClient.image = img;
    
	[_indicator stopAnimating];
}



-(void)waitForPhoto
{
	[_indicator startAnimating];
}



-(void)applyData:(Interview *)interview
{
    _interview = [interview retain];
    
    _lblFirstName.text = interview.client.firstName;
    _lblLastName.text = interview.client.lastName;
    
    if(interview.client.lastVisitDate != nil)
    {
        // format date
        NSDateFormatter * format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"dd/MM/yyyy"];
        _lblLastVisited.text = [format stringFromDate:interview.client.lastVisitDate];
    }
    else
        _lblLastVisited.text = @"Not Visited";
    
    _imgTick.hidden = (interview.visited == false);
    _imgInter.hidden = (interview.visited == true);
    _imgView.hidden = (interview.visited == false);    
    
}



#pragma mark - Action Handlers

-(IBAction)makeInterview:(id)sender
{
    [_logic makeInterview:_interview];
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
