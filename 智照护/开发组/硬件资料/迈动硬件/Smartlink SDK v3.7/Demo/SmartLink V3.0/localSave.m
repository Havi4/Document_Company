//
//  localSave.m
//  SmartLink V4.0
//
//  Created by Peter on 14-2-19.
//  Copyright (c) 2014年 Peter. All rights reserved.
//

#import "localSave.h"
#import "NSString+HFJson.h"
#import "NSObject+HFJson.h"

@implementation localSave
{
    NSMutableDictionary *mDiction;
    NSString *storeFile;
}

-(id)init
{
    if (self = [super init]) {
//        mDiction = [[NSMutableDictionary alloc] init];
        NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory= [paths objectAtIndex:0];
        storeFile=[documentDirectory stringByAppendingPathComponent:@"localSave.json"];
        [self load];
    }
    return self;
}

-(void)saveSsid:(NSString *)ssid andKey:(NSString *)key
{
    NSString *saved=[mDiction objectForKey:ssid];
    if (saved!= nil)
    {
        if ([saved isEqualToString:key]== TRUE)
            return;
    }
    [mDiction setObject:key forKey:ssid];
    [self save];
}

-(NSString *)getKeyBySsid:(NSString *)ssid
{
    NSString *key;
    
    key=[mDiction objectForKey:ssid];
    return key;
}

#pragma mark - private functions
- (void)save
{
    NSString* jsonStr = [mDiction toJsonString];
    [jsonStr writeToFile:storeFile atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
}

- (void)load
{
    NSString *jsonStr = [NSString stringWithContentsOfFile:storeFile encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"read from %@",jsonStr);
    NSDictionary *dic=[jsonStr toJsonValue];
    mDiction=[self makeMutable:dic];
}

-(NSMutableDictionary *)makeMutable:(NSDictionary *)dicIn
{
    NSMutableDictionary *dicOut=[[NSMutableDictionary alloc] init];
    NSArray *keys=[dicIn allKeys];
    NSInteger num= [keys count];
    if (num== 0)
        return dicOut;
    for (int i=0; i<num; i++)
    {
        NSMutableDictionary *dicSon;
        if ([[dicIn objectForKey:keys[i]] isKindOfClass:NSClassFromString(@"NSDictionary")]==TRUE)
        {
            dicSon=[self makeMutable:[dicIn objectForKey:keys[i]]];
            [dicOut setObject:dicSon forKey:keys[i]];
        }
        else
            [dicOut setObject:[dicIn objectForKey:keys[i]] forKey:keys[i]];
    }
    return dicOut;
}

@end
