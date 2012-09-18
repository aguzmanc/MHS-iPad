#import "ClientService.h"

#import "JSON.h"

@implementation ClientService


#pragma mark - Initialization

-(id)initWithDelegate:(id<AsyncListClientReceiverDelegate>) delegate; 
{
	self = [super init];
	
	_delegate = delegate;    
	
	return self;
}






#pragma mark - Public Methods

-(void)requestDataWithUserId:(NSString *)userId
{
    // Build request URL with al parameters
	NSString * requestURL = [NSString stringWithFormat:@"%@?user_id=%@", CLIENTS_SERVICE_REQUEST_PAGE, userId];
	
	_responseData = [[NSMutableData data] retain];
    
	NSLog(@"%@", requestURL);
	
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
        
    int size = [_responseData length];
    
    [_delegate updateClientBytesReceived:size];
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{	
    NSLog(@"%@",[NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{	
	[connection release];
	
	NSMutableString * responseString = [[NSMutableString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    
	NSDictionary * jsonDict = [responseString JSONValue];
	NSString * successStr = [jsonDict objectForKey:@"Success"];
    BOOL success  = [successStr isEqualToString:@"True"];
    
    NSMutableArray * clients = [[NSMutableArray alloc] init];
    
    if(success)
    {
        NSArray * jsonClients = (NSArray *)[jsonDict objectForKey:@"Clients"];
        
        for(NSDictionary * jsonClient in jsonClients)
        {
            Client * client = [[Client alloc] init];
            
            client.profileNumber = [jsonClient objectForKey:@"profile_number"];
            client.firstName = [jsonClient objectForKey:@"first_name"];
            client.lastName = [jsonClient objectForKey:@"last_name"];
            client.middleName = [jsonClient objectForKey:@"middle_name"];
            client.info = [jsonClient objectForKey:@"info"];
            client.photoFileName = [jsonClient objectForKey:@"photo"];
            
            NSDateFormatter * format = [[[NSDateFormatter alloc] init] autorelease];
            
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString * dateStr = (NSString *)[jsonClient objectForKey:@"last_visited"];
            
            client.subUrb = [jsonClient objectForKey:@"suburb"];
            client.age = [jsonClient objectForKey:@"age"];
            
             
            if(dateStr == nil || [dateStr isKindOfClass:[NSNull class]])
                client.lastVisitDate = nil; // we don't have a date really
            else
                client.lastVisitDate = [format dateFromString:dateStr];
            
            [clients addObject:client];
        }
        
        [_delegate receiveClients:clients];
    }
}



@end
