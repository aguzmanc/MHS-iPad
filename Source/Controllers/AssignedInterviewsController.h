#import <UIKit/UIKit.h>

#import "Logic.h"
#import "InterviewCell.h"


@interface AssignedInterviewsController : UIViewController <UITableViewDataSource, UITableViewDataSource, AssignedInterviewsDelegate>
{
    Logic * _logic;
    
    NSMutableArray * _imagesButtonsOn;
    NSMutableArray * _imagesButtonsOff;
    
    IBOutlet UIButton * _btnMon;
    IBOutlet UIButton * _btnTue;
    IBOutlet UIButton * _btnWed;
    IBOutlet UIButton * _btnThu;
    IBOutlet UIButton * _btnFri;
    IBOutlet UIButton * _btnSat;
    IBOutlet UIButton * _btnSun;
    IBOutlet UIButton * _btnAll;
    
    IBOutlet UITableView * _tblInterviews;
    
    IBOutlet UIButton * _btnBackToLogin;
    
    NSMutableArray * _waitingCells;

    int _selectedWeekday;
    
    IBOutlet UILabel * _lblMessage;
    
    NSArray * _currentInterviews;
}


@property (nonatomic, assign) NSArray *tableData;

// Public Methods
-(void)setLogic:(Logic *)logic;
-(void)reload;

// Action Handlers
-(IBAction)monClick;
-(IBAction)tueClick;
-(IBAction)wedClick;
-(IBAction)thuClick;
-(IBAction)friClick;
-(IBAction)satClick;
-(IBAction)sunClick;
-(IBAction)allClick;

-(IBAction)backToLogic;



@end


