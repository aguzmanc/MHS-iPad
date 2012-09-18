//
//  InterviewSave.m
//  MHS Prototype
//
//  Created by Giancarlo on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InterviewSave.h"
#import "Globals.h"
#import "JSON.h"

@implementation InterviewSave


-(id)initWithDelegate:(id<InterviewSaveServiceDelegate>)delegate
{
	self = [super init];
	
	_delegate = delegate;
	
	return self;
}


#pragma mark Public Methods

-(void)interviewSaves:(NSString *)interviewId andStarTime:(NSString *)startime andEndTime:(NSString *)endtime andTimespent:(NSString *)timespent andComment:(NSString *)comment andCost:(NSString *)cost
{
    //encode name
    NSString * encodeComment = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)comment ,NULL ,(CFStringRef)@"!*'();:@&=+$,/?%#[]" , kCFStringEncodingUTF8 );
    
    // Build request URL with al parameters
	NSString * requestURL = [NSString stringWithFormat:@"%@?interview_id=%@&start_time=%@&end_time=%@&interview_time=%@&cost=%@&comments=%@", INTERVIEW_SERVICE_REQUEST_PAGE
                                          , interviewId
                                          , startime
                                          , endtime
                                          , timespent
                                          , cost
                                          , encodeComment];
	NSLog(@"%@",requestURL);    
    
	responseData = [[NSMutableData data] retain];
    	
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
    [_delegate errorInterviewSave:[error description]];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{	
	[connection release];
	
	responseString = [[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSDictionary * results = [responseString JSONValue];
	NSString * res = [results objectForKey:@"Success"];
	
	BOOL success  = [res isEqualToString:@"True"];
	NSString * reason = nil;
	
	if (success == NO)
		reason = (NSString *)[results objectForKey:@"Reason"];
	
	[_delegate successInterviewSave:success andMessage:reason];
}





@end
