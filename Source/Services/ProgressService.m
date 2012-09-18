#import "ProgressService.h"
#import "JSON.h"
#import "Globals.h"


@implementation ProgressService

#pragma mark Initialization

-(id)initWithDelegate:(id<ProgressServiceDelegate>)delegate
{
	self = [super init];
	
	_delegate = delegate;
    
	return self;
}



-(void)initProgress:(NSString *) idUser
{
    // Build request URL with al parameters
	NSString * requestURL = [NSString stringWithFormat:@"%@?user_id=%@", CLIENTS_SERVICE_REQUEST_PAGE, idUser];
	
	responseData = [[NSMutableData data] retain];
    
	NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];  
}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	totalSize = [NSNumber numberWithLongLong:[response expectedContentLength]];
   
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
    indexProgress = [NSNumber numberWithUnsignedInteger:[data length]];    
        
    NSLog(@"receiveData:%i",[indexProgress intValue]);
    
    [_delegate indexService:indexProgress];
    [responseData appendData:data];
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{	
    NSLog(@"%@",[NSString stringWithFormat:@"Connection failed: %@", [error description]]);    
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{	   
    [connection release];
}



@end
