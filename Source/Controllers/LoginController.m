#import "LoginController.h"

@implementation LoginController

#pragma mark Initialization

-(id)init
{
    self = [super initWithNibName:@"LoginView" bundle:nil];
        
    if (!self) return nil;

    return self;
}


-(void)setLogic:(Logic *)logic
{
    _logic = logic;
}

#pragma mark Event Handlers

-(IBAction)loginClick:(id)sender
{
    NSString * user = _user.text;
    NSString * pass = _pass.text;        
    [_logic loginUser:user Pass:pass];
    [_pass resignFirstResponder];
    
}

#pragma mark - Login Users Delegate

-(void)loginError:(NSString *)message
{    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"LOGIN FAILED" message:message delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles:nil];
	
	[alert show];
	[alert release];
    
}

-(void)errorLogin:(NSString *)message
{   
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"CONNECTION ERROR" message:@"Failed to connect to login, please verify" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	
	[alert show];
	[alert release];
    
}


-(void)clearFields
{
    [_user setText:@""];
    [_pass setText:@""];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_user resignFirstResponder];
    [_pass resignFirstResponder];
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
