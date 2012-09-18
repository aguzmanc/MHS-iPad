#import <UIKit/UIKit.h>

#import "Logic.h"

@interface InterviewController : UIViewController <InterviewDelegate,UITextFieldDelegate>
{
    Logic * _logic;
    IBOutlet UIButton * _backTolist;
    
    IBOutlet UILabel *_lblFirts_Name;
    IBOutlet UILabel *_lblLast_Name; 
    IBOutlet UILabel *_lblProfile_Num;
    
    IBOutlet UIImageView *_img_Photo;
    
    IBOutlet UIButton * _btnFinish;
    
    NSString *_client_profile_id;
    IBOutlet UILabel *_lblDate;    
    IBOutlet UILabel *_lblStartTime;
    IBOutlet UITextView *_textComment;    
    IBOutlet UILabel *_lblEndTime;          
    IBOutlet UILabel *_lblTimeSpent;
    IBOutlet UITextField *_lblCost;
    IBOutlet UILabel *_lblAge;
    IBOutlet UILabel *_lblSuburb;
           
    
    NSString *_interview_id;
    NSDate *_start_Time;
    NSDate *_end_Time;       
}

@property(nonatomic,retain) IBOutlet UIButton * _backTolist;

-(IBAction) slideFrameUp;
-(void) slideFrame:(BOOL)up;
-(IBAction) slideFrameDown;

-(void)setLogic:(Logic *)logic;

// Event Handlers
-(IBAction)finishClick:(id)sender;
-(IBAction)backToListClick:(id)sender;



@end
