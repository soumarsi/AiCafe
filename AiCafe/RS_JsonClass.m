//
//  RS_JsonClass.m
//  AiCafe
//
//  Created by Rahul Singha Roy on 22/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import "RS_JsonClass.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>

@implementation RS_JsonClass
{
    Urlresponceblock _responce;
    NSString *check;
    
}

-(void)GlobalDict:(NSMutableURLRequest *)parameter Globalstr:(NSString *)parametercheck Withblock:(Urlresponceblock)responce
{
    
    
    
    //NSURL *url = [NSURL URLWithString:parameter];
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    connection = [[NSURLConnection alloc] initWithRequest:parameter delegate:self];
    
    check  = parametercheck;
    connection=nil;
    _responce=[responce copy];
    
}

-(NSString *) GlobalDict_image:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter
{
    
 

    
  //  check  = parametercheck;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", parameter]]];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    
    if ( imageparameter.length > 0)
        
    {
        
        NSLog(@"Uploading.....");
        
        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:imageparameter];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:body];
        
        
    }

    
    NSURLResponse *response = nil;
    NSError *error;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  
    
    
    NSString *result = [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];

    
    return result;
    
}
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"no_internet" object:nil];
    
    NSLog(@"Did Fail");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
  if([check isEqualToString:@"array"])
    {
        
        id result=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        NSLog(@"Result...%@",result);
        _responce(result,nil);
    }
    if ([check isEqualToString:@"string"])
    {
        id  result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Result...%@",result);
        _responce(result,nil);
    }

}

-(void)Userdict:(NSDictionary *)userdetails
{
    UserData = [[NSUserDefaults alloc]init];
    
    [UserData setObject:[userdetails objectForKey:@"id"] forKey:@"id"];

    [UserData synchronize];
}
- (BOOL)connectedToNetwork
{
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    

    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

@end
