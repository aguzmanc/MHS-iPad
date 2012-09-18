#import "TotalSizeService.h"
#import "JSON.h"

@implementation TotalSizeService

#pragma mark - Initialization

-(id)initWithDelegate:(id<TotalSizeServiceDelegate>)delegate
{
    self = [super init];
	
	_delegate = delegate;
	
	return self;
}





#pragma mark - Public Methods

-(void)requestSizeForService:(NSString *)serviceId WithUserId:(NSString *)userId
{
    _serviceIdentifier = serviceId;
    
    // Build request URL with al parameters
	NSString * requestURL = [NSString stringWithFormat:@"%@?service=%@&user_id=%@", TOTAL_SIZE_SERVICE_REQUEST_PAGE, serviceId, userId];
	
	_responseData = [[NSMutableData data] retain];
    	
	NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
}






#pragma mark - Request Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	NSHTTPURLResponse *HTTPresponse = (NSHTTPURLResponse *)response; 
	NSInteger statusCode = [HTTPresponse statusCode]; 
	if ( 404 == statusCode || 500 == statusCode ) {
		NSLog(@"Server Error - %@", [ NSHTTPURLResponse localizedStringForStatusCode: statusCode ]);
	} else { 
		[ _responseData setLength:0 ];
	}
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	[_responseData appendData:data];
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{	
    NSLog(@"%@",[NSString stringWithFormat:@"Connection failed: %@", [error description]]);
    
    [_delegate receiveTotalSizeInBytes:0 ForService:_serviceIdentifier];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{	
	[connection release];
	
	NSMutableString * responseString = [[NSMutableString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];

	NSDictionary * jsonDict = [responseString JSONValue];
	NSString * successStr = [jsonDict objectForKey:@"Success"];
    BOOL success  = [successStr isEqualToString:@"True"];
    
    int totalBytes = 0;
    
    if(success)
    {
        totalBytes = [((NSString *)[jsonDict objectForKey:@"Size"]) intValue];
    }
    
    [_delegate receiveTotalSizeInBytes:totalBytes ForService:_serviceIdentifier];
}


@end
