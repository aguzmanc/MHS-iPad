#import <Foundation/Foundation.h>

#import "LoginUserService.h"
#import "PhotoService.h"
#import "Client.h"
#import "Interview.h"
#import "TotalSizeService.h"
#import "ClientService.h"
#import "InterviewService.h"
#import "InterviewSave.h"

@protocol ViewChangerDelegate;
@protocol AssignedInterviewsDelegate;
@protocol LoginUserDelegate;
@protocol InitializationDelegate;
@protocol InterviewDelegate;
@protocol InterviewSaveDelegate;

@interface Logic : NSObject <LoginUserServiceDelegate, AsyncProfileImageReceiverDelegate, 
                        TotalSizeServiceDelegate, AsyncListClientReceiverDelegate,
                        AsyncListInterviewReceiverDelegate, InterviewSaveServiceDelegate>
{
    // delegates
    id<ViewChangerDelegate> _viewChangerDelegate;
    id<LoginUserDelegate> _loginUserDelegate;
    id<InitializationDelegate> _initializationDelegate;
    id<InterviewDelegate> _interviewDelegate;
    id<AssignedInterviewsDelegate> _assignedInterviewsDelegate;
    
    // Services
    LoginUserService * _loginUserService;
    ClientService * _clientService;
    InterviewService * _interviewService;
    InterviewSave * _interviewSave;
    
    
    // Logic data 
    NSArray * _interviewList;
    NSArray * _clientList;
    NSMutableDictionary * _userImageCache;
    NSMutableArray * _profileNumbersWaitingForPhoto;
    UIImage * _defaultImage;
    
    int _totalLoadSizeOfServices;
    int _totalBytesReceived;
    bool _isClientsResponseSizeKnown;
    bool _isInterviewsResponseSizeKnown;
    bool _clientsReceived;
    bool _interviewsReceived;
    
    NSString * _userIdLogged;
    
    Interview * _selectedInterview;
}

// Properties

@property (strong, nonatomic) NSArray * interviewList;

// Initialization
-(id)initWithViewChangerDelegate:(id<ViewChangerDelegate>)viewChanger
            andLoginUserDelegate:(id<LoginUserDelegate>)loginUsers
       andInitializationDelegate:(id<InitializationDelegate>)initialization
            andInterviewDelegate:(id<InterviewDelegate>)interviews
   andAssignedInterviewsDelegate:(id<AssignedInterviewsDelegate>)assignedInterviews;

// Public Methods
-(void)switchToInitialization;
-(void)switchToLogin;
-(void)switchToAssignedInterviews;
-(void)switchToInterview;
-(void)switchToFinishInterview;


-(bool)existsImageForProfileNumber:(NSString *)profileNumber;
-(UIImage *)getImageForProfileNumber:(NSString *)profileNumber;
-(void)obtainImageForProfileNumber:(NSString *)profileNumber withFileName:(NSString *)fileName;

-(void)loginUser:(NSString *)user Pass:(NSString *)pass;


-(void)yesClickDelegate;

-(Interview *)getDummyInterview;
-(Interview *)getInterviewAt:(int)row ForWeekday:(int)weekday;
-(NSArray *)getInterviewsForWeekday:(int)weekday;

-(void)makeInterview:(Interview *)interview;
-(void)makeClientInterviewRelations;

-(void)interviewSaveService:(NSString *)interviewId andStarTime:(NSDate *)startime andEndTime:(NSDate *)endtime andTimespent:(NSDate *)timespent andComment:(NSString *)comment andCost:(NSString *)cost;

@end








/*
 *  VIEW CHANGER DELEGATE
 */

@protocol ViewChangerDelegate

-(void)switchToInitialization;
-(void)switchToAssignedInterviews;
-(void)switchToLogin;
-(void)switchToInterview;
-(void)switchToFinishInterview;


@end



/*
 *  Interview DELEGATE
 */
@protocol InterviewDelegate

-(void)setLogic:(Logic *)logic;
-(void)applyDataInterviewSave:(Interview *)interview;
-(void)applyDataInterviewView:(Interview *)interview;
-(void)successSaveInterview:(BOOL)status andMessage:(NSString *)message;
-(void)errorSaveInterview:(NSString *)message;
-(void)interviewMessageSave;

@end



/*
 *  Initializations DELEGATE
 */
@protocol InitializationDelegate

-(void)setLogic:(Logic *)logic;
-(void)updatePercentageProgress:(int)percentage;
@end



/*
 *  LOGIN DELEGATE
 */
@protocol LoginUserDelegate

-(void)setLogic:(Logic *)logic;
-(void)loginError:(NSString *)message;
-(void)errorLogin:(NSString *)message;
-(void)clearFields;

@end


/*
 *  ASSIGNED INTERVIEWS DELEGATE
 */
@protocol AssignedInterviewsDelegate

-(void)updateImage:(UIImage *)image forProfileNumber:(NSString *)profileNumber;
-(void)reload;

@end