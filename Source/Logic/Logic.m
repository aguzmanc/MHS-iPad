#import "Logic.h"

@implementation Logic

@synthesize interviewList = _interviewList;

#pragma mark - Initialization

-(id)initWithViewChangerDelegate:(id<ViewChangerDelegate>)viewChanger
            andLoginUserDelegate:(id<LoginUserDelegate>)loginUsers
       andInitializationDelegate:(id<InitializationDelegate>)initialization
            andInterviewDelegate:(id<InterviewDelegate>)interviews
   andAssignedInterviewsDelegate:(id<AssignedInterviewsDelegate>)assignedInterviews
{
    self = [super init];
    
    _viewChangerDelegate = viewChanger;
    _assignedInterviewsDelegate = assignedInterviews;
    _loginUserDelegate = loginUsers;
    _interviewDelegate = interviews;
    _initializationDelegate = initialization;
    
    _loginUserService = [[LoginUserService alloc] initWithDelegate:self];    
    _clientService = [[ClientService alloc] initWithDelegate:self];
    _interviewService = [[InterviewService alloc] initWithDelegate:self];    
    _interviewSave = [[InterviewSave alloc] initWithDelegate:self];
    
    
    [_loginUserDelegate setLogic:self];
    
    // init cache of images
	_userImageCache = [[NSMutableDictionary alloc] init];
    _profileNumbersWaitingForPhoto = [[NSMutableArray alloc] init];
    _defaultImage = [UIImage imageNamed:@"default_photo.png"];
    
    return self;
}

-(void)yesClickDelegate
{    
    [_interviewDelegate interviewMessageSave];
}

-(void)loginUser:(NSString *)user Pass:(NSString *)pass
{    
    [_loginUserService loginUser:user Pass:pass];
}


-(void)interviewSaveService:(NSString *)interviewId 
                andStarTime:(NSDate *)startime 
                 andEndTime:(NSDate *)endtime 
               andTimespent:(NSDate *)timespent 
                 andComment:(NSString *)comment andCost:(NSString *)cost
{
        
    NSDateFormatter * format_start = [[NSDateFormatter alloc] init];
    NSDateFormatter * format_end = [[NSDateFormatter alloc] init];
    NSDateFormatter * format_time = [[NSDateFormatter alloc] init];
    
    [format_start setDateFormat:@"hhmm"];
    [format_end setDateFormat:@"hhmm"];
    [format_time setDateFormat:@"hhmm"];
    NSLog(@"%@",[format_time stringFromDate: timespent]);

    
    [_interviewSave interviewSaves:interviewId andStarTime:[format_start stringFromDate: startime] andEndTime:[format_end stringFromDate: endtime] andTimespent:[format_time stringFromDate: timespent] andComment:comment andCost:cost];
      
    _selectedInterview.visited = true;
    _selectedInterview.interviewId = interviewId;
    
    _selectedInterview.startTime = startime;    
    _selectedInterview.endTime = endtime;
    _selectedInterview.interviewTime = timespent;
    _selectedInterview.comment = comment;
    _selectedInterview.cost = [cost doubleValue];
       
        
    [self switchToAssignedInterviews];
    [_assignedInterviewsDelegate reload];
}

#pragma mark - Public Methods

-(void)switchToInitialization
{
    [_viewChangerDelegate switchToInitialization];
    
    [_initializationDelegate updatePercentageProgress:0];
}



-(void)switchToLogin
{
    [_viewChangerDelegate switchToLogin];
    [_loginUserDelegate clearFields];
    [_assignedInterviewsDelegate reload];//se inserto esta linea para mostrar el dia actual
}



-(void)switchToAssignedInterviews
{
    [_viewChangerDelegate switchToAssignedInterviews];
}



-(void)switchToInterview
{
    [_viewChangerDelegate switchToInterview];
}

-(void)switchToFinishInterview
{
    [_viewChangerDelegate switchToFinishInterview];
}

-(void)obtainImageForProfileNumber:(NSString *)profileNumber withFileName:(NSString *)fileName;
{
    if([_profileNumbersWaitingForPhoto containsObject:profileNumber])
        return ;  // another process already require the same profile number, so it is innecesary require it again
    
    [_profileNumbersWaitingForPhoto addObject:profileNumber]; // put in the waiting list
    PhotoService * service = [[PhotoService alloc] initWithProfileImageReceiverDelegate:self andProfileNumber:profileNumber];
    
    [service obtainImageForFile:fileName];
}



-(bool)existsImageForProfileNumber:(NSString *)profileNumber
{
	return ([[_userImageCache allKeys] containsObject:profileNumber] == YES);
}



-(UIImage *)getImageForProfileNumber:(NSString *)profileNumber;
{
	return [_userImageCache objectForKey:profileNumber];
}


-(Interview *)getDummyInterview
{
    // dummy data
    Interview * interview = [[Interview alloc] init];
    interview.interviewId = @"k2374";
    interview.startTime = [NSDate date];
    interview.endTime = [NSDate date];
    interview.cost = 34.52;
    interview.comment = @"Lorem Ipsum";
    interview.visited = [NSDate date];
    interview.client = [[Client alloc] init];
    interview.client.middleName = @"AGC";
    interview.client.info = @"Lorem Ipsum";
    interview.client.lastVisitDate = [NSDate date];
    
    interview.visited = ((rand()%2) == 0);
    
    int clientIndex  = rand()%3;
    
    NSArray * names = [NSArray arrayWithObjects:@"Mauricio", @"Johan", @"Neil", nil];
    NSArray * lastNames = [NSArray arrayWithObjects:@"Larrea S.", @"Munchen Fr.", @"Rodemberg", nil];
    NSArray * profiles = [NSArray arrayWithObjects:@"UF-927-X", @"WS-221-C", @"IT-521-Q", nil];
    NSArray * photos = [NSArray arrayWithObjects:@"photo1.jpg", @"photo2xdfasdfasd.jpg", @"photo3.jpg", nil];
    
    interview.client.firstName = [names objectAtIndex:clientIndex];
    interview.client.lastName = [lastNames objectAtIndex:clientIndex];
    interview.client.profileNumber = [profiles objectAtIndex:clientIndex];
    interview.client.photoFileName = [photos objectAtIndex:clientIndex];
    
    return interview;
}



-(Interview *)getInterviewAt:(int)row ForWeekday:(int)weekday
{
    //NSMutableArray * selectedInterviews = [[NSMutableArray alloc] init];
    //NSCalendar * cal = [NSCalendar currentCalendar];
    //NSDateComponents * comp = [cal components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    
    //int currentWeekday = [comp weekday];

    
    
    
    row = MAX(0, MIN([_interviewList count]-1, row));
    
    return [_interviewList objectAtIndex:row];
}

-(NSArray *)getInterviewsForWeekday:(int)weekday
{
    
    if(weekday == __ALL) return _interviewList;
    
    NSMutableArray * selected = [[NSMutableArray alloc] init];
    
    for(Interview * interview in _interviewList)
    {
        if(interview.scheduleWeekday == weekday)        
            [selected addObject:interview];
    }
    return selected;
}



-(void)makeInterview:(Interview *)interview
{
    _selectedInterview = interview;
    [self switchToInterview];
    if (interview.visited)
      [_interviewDelegate applyDataInterviewView:_selectedInterview];    
    else
      [_interviewDelegate applyDataInterviewSave:_selectedInterview];
    
}



-(void)makeClientInterviewRelations
{
    if(_clientsReceived && _interviewsReceived)
    {
        for(Interview * interview in _interviewList)
        {
            for(Client * client in _clientList)
            {
                if([interview.profileNumber isEqualToString:client.profileNumber])
                    interview.client = client;
            }
        }
        
        [self switchToAssignedInterviews];
    }
}








#pragma mark - TotalSizeServiceDelegate

-(void)receiveTotalSizeInBytes:(int)size ForService:(NSString *)serviceIdentifier
{
    if ([serviceIdentifier isEqualToString:TOTAL_SIZE_CLIENTS_SERVICE_IDENTIFIER]) {
        _isClientsResponseSizeKnown = true;
        _totalLoadSizeOfServices += size;
        
        NSLog(@"Size of Clients: %d bytes", size);
    }
    
    if ([serviceIdentifier isEqualToString:TOTAL_SIZE_INTERVIEWS_SERVICE_IDENTIFIER]) {
        _isInterviewsResponseSizeKnown = true;
        _totalLoadSizeOfServices += size;
        
        NSLog(@"Size of Interviews: %d bytes", size);
    }
    
    if(_isClientsResponseSizeKnown && _isInterviewsResponseSizeKnown)
    {
        [_clientService requestDataWithUserId:_userIdLogged];   
        [_interviewService requestDataWithUserId:_userIdLogged];
    }
}






#pragma mark - LoginUserServiceDelegate

-(void)successLogin:(NSString *) userId 
          FirstName:(NSString *)firstName 
           LastName:(NSString *)lastName 
              Email:(NSString *)email
{
    [self switchToInitialization];
    
    // initial values for loading process
    _isClientsResponseSizeKnown = false;
    _isInterviewsResponseSizeKnown = false;
    _totalBytesReceived = 0;
    _totalLoadSizeOfServices = 0;
    _clientsReceived = false;
    _interviewsReceived = false;
    
    //[_progressService initProgress:userId];
    TotalSizeService * sizeForClientsService = [[TotalSizeService alloc] initWithDelegate:self];
    [sizeForClientsService requestSizeForService:TOTAL_SIZE_CLIENTS_SERVICE_IDENTIFIER WithUserId:userId];
    
    TotalSizeService * sizeForInterviewsService = [[TotalSizeService alloc] initWithDelegate:self];
    [sizeForInterviewsService requestSizeForService:TOTAL_SIZE_INTERVIEWS_SERVICE_IDENTIFIER WithUserId:userId];
    
    _userIdLogged = [userId retain];
}



-(void)errorLoginService:(NSString *)message
{
    [_loginUserDelegate errorLogin:message];
}

#pragma mark - Interview Save Service Delegate

-(void)successInterviewSave:(BOOL)status andMessage:(NSString *)message;
{
    [_interviewDelegate successSaveInterview:status andMessage:message];
}

-(void)errorInterviewSave:(NSString *)message
{
    [_interviewDelegate errorSaveInterview:message];
}


#pragma mark - AsyncClientServiceDelegate

-(void)updateClientBytesReceived:(int)bytesCount
{
    _totalBytesReceived += bytesCount;
    int percentageProgress = 0;
    
    if(_totalLoadSizeOfServices != 0)        
        percentageProgress = (int)(((double)_totalBytesReceived / _totalLoadSizeOfServices) * 100);
    
    
    [_initializationDelegate updatePercentageProgress:percentageProgress];
}



-(void)receiveClients:(NSArray *)clients
{
    _clientList = [clients retain];
    _clientsReceived = true;
    
    [self makeClientInterviewRelations];
}






#pragma mark - AsyncListInterviewReceiverDelegate

-(void)updateInterviewBytesReceived:(int)bytesCount
{
    _totalBytesReceived += bytesCount;
    int percentageProgress = 0;
    
    if(_totalLoadSizeOfServices != 0)        
        percentageProgress = (int)(((double)_totalBytesReceived / _totalLoadSizeOfServices) * 100);
    
    
    [_initializationDelegate updatePercentageProgress:percentageProgress];
}



-(void)receiveInterviews:(NSArray *)interviews
{
    
    _interviewList = [interviews retain];
    _interviewsReceived = true;    
    
    [self makeClientInterviewRelations];
}







#pragma mark - AsyncProfileImageReceiverDelegate

-(void)receiveImage:(UIImage *)image ForProfileNumber:(NSString *) profileNumber
{
    [_assignedInterviewsDelegate updateImage:image forProfileNumber:profileNumber];
    
    [_userImageCache setObject:image forKey:profileNumber];
}



-(void)receiveImageErrorForProfileNumber:(NSString *)profileNumber
{
    [_assignedInterviewsDelegate updateImage:_defaultImage forProfileNumber:profileNumber];
    
    [_userImageCache setObject:_defaultImage forKey:profileNumber];
}
@end
