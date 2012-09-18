#import <UIKit/UIKit.h>

#import "Logic.h"
#import "Client.h"
#import "Interview.h"

@interface InterviewCell :  UITableViewCell 
{
    IBOutlet UILabel * _lblFirstName;
    IBOutlet UILabel * _lblLastName;
    IBOutlet UILabel * _lblLastVisited;
    IBOutlet UIImageView * _imgClient;
    IBOutlet UIButton * _btnAction;
    IBOutlet UIImageView * _imgInter;
    IBOutlet UIImageView * _imgView;    
    IBOutlet UIImageView * _imgTick;
    IBOutlet UIActivityIndicatorView * _indicator;
    
    Logic * _logic;
    
    Interview * _interview;
}

// Properties
@property (strong, nonatomic) Logic * logic;
@property (strong, nonatomic) Interview * interview;

// Public Methods
-(void)setImage:(UIImage *)img;
-(void)waitForPhoto;
-(void)applyData:(Interview *)interview;

// Action Handlers
-(IBAction)makeInterview:(id)sender;


@end
