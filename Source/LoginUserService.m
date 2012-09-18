#import "LoginUserService.h"
#import "JSON.h"
#import "Globals.h"

@implementation LoginUserService

#pragma mark Initialization

-(id)initWithDelegate:(id<LoginUserServiceDelegate>)delegate
{
	self = [super init];
	
	_delegate = delegate;
	
	return self;
}



#pragma mark Public Methods

-(void)loginUser:(NSString *)user Pass:(NSString *)pass
{
    // Build request URL with al parameters
	NSString * requestURL = [NSString stringWithFormat:@"%@?user=%@&pass=%@", LOGIN_USER_SERVICE_REQUEST_PAGE, user, pass];
	
	responseData = [[NSMutableData data] retain];
    
	NSLog(@"%@", requestURL);
	
	NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	NSHTTPURLResponse *HTTPresponse = (NSHTTPURLResponse *)response; 
	NSInteger statusCode = [HTTPresponse statusCode]; 
	if ( 404 == statusCode || 500 == statusCode ) {
		NSLog(@"Server Error - %@", [ NSHTTPURLResponse localizedStringForStatusCode: statusCode ]);
	} else { 
		[ responseData setLength:0 ];
	}
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	[responseData appendData:data];
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{	
    NSLog(@"%@",[NSString stringWithFormat:@"Connection failed: %@", [error description]]);
    [_delegate errorLoginService:[error description]];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{	
	[connection release];
	
	responseString = [[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSDictionary * results = [responseString JSONValue];
	NSString * res = [results objectForKey:@"Success"];
    
    NSDictionary * userData = [results objectForKey:@"User"];
    NSString * userId = [userData objectForKey:@"user_id"];
    NSString * firstName = [userData objectForKey:@"first_name"];
    NSString * lastName = [userData objectForKey:@"last_name"];
    NSString * email = [userData objectForKey:@"email"];
    	
	BOOL success  = [res isEqualToString:@"True"];
    
	NSString * reason = nil;
	
	if (success == NO)
    {
		reason = (NSString *)[results objectForKey:@"Reason"];
        [_delegate errorLoginService:reason];
    }
    else
    {
        [_delegate successLogin:userId FirstName:firstName LastName:lastName Email:email];
    }
}


@end
