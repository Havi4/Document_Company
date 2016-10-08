//
//  localSave.h
//  SmartLink V4.0
//
//  Created by Peter on 14-2-19.
//  Copyright (c) 2014年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface localSave : NSObject

-(id)init;
-(void)saveSsid:(NSString *)ssid andKey:(NSString *)key;
-(NSString *)getKeyBySsid:(NSString *)ssid;

@end
