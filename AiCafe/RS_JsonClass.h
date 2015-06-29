//
//  RS_JsonClass.h
//  AiCafe
//
//  Created by Rahul Singha Roy on 22/05/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RS_ios_customBlock.h"
#import "RS_PCH.pch"
@interface RS_JsonClass : NSObject<NSURLConnectionDelegate>
{
    NSDictionary *DataDictionary;
    NSMutableData *responseData;
    NSURLConnection *connection;
    NSUserDefaults *UserData;
}

-(void)GlobalDict:(NSString *)parameter Globalstr:(NSString *)parametercheck Withblock:(Urlresponceblock)responce;
-(NSString *) GlobalDict_image:(NSString *)parameter Globalstr_image:(NSString *)parametercheck globalimage:(NSData *)imageparameter ;
- (BOOL)connectedToNetwork;
-(void)Userdict:(NSDictionary *)userdetails;

@property NSString *error_str;

@end
