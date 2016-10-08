//
//  GUISmtlkViewController.m
//  SmartLink V3.0
//
//  Created by Peter on 14-5-5.
//  Copyright (c) 2014年 Peter. All rights reserved.
//

#import <SystemConfiguration/CaptiveNetwork.h>
#import "GUISmtlkViewController.h"
#import "localSave.h"

@interface GUISmtlkViewController ()
{
    NSMutableArray *macArray;
}

@end

@implementation GUISmtlkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        smtlkState= 0;
        showKey= 1;
        save=[[localSave alloc] init];
        smtlk=[[HFSmtlkV30 alloc] initWithDelegate:self];
        macArray=[[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _butConnect.backgroundColor = [UIColor colorWithRed:80/255.0 green:200/255.0 blue:80/255.0 alpha:1];
    _butConnect.layer.masksToBounds = YES;
    _butConnect.layer.cornerRadius = 8.0;
    
    [self showWifiSsid];
}

- (void)showWifiSsid
{
    BOOL wifiOK= FALSE;
    NSDictionary *ifs;
    NSString *ssid;
    UIAlertView *alert;
    if (!wifiOK)
    {
        ifs = [self fetchSSIDInfo];
        ssid = [ifs objectForKey:@"SSID"];
        //        ssid=@"HF_LPB100";
        if (ssid!= nil)
        {
            wifiOK= TRUE;
            _textSsid.text= ssid;
            _textKey.text=[save getKeyBySsid:ssid];
        }
        else
        {
            alert= [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"请连接Wi-Fi"] delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            alert.delegate=self;
            [alert show];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self showWifiSsid];
}

- (id)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    return info;
}

#pragma mark - actions
- (IBAction)connectPressed:(id)sender
{
    [_textKey resignFirstResponder];
    [_textSsid resignFirstResponder];
    
    if (_textKey.text==nil)
        _textKey.text=@"";
    if (_textSsid.text==nil)
        _textSsid.text=@"";
    
    if (smtlkState== 0)
    {
        [save saveSsid:_textSsid.text andKey:_textKey.text];
        
        smtlkState= 1;
        times= 0;
        findTimes= 0;
        [macArray removeAllObjects];
        [sender setTitle:@"取消连接" forState:UIControlStateNormal];
        // start to do smtlk
        [self startSmartLink];
    }
    else
    {
        // stop smtlk
        [self stopSmartLink];
        smtlkState= 0;
        isfinding = NO;
        [sender setTitle:@"开始连接" forState:UIControlStateNormal];
    }
}

- (IBAction)backgroundTapped:(id)sender
{
    [_textKey resignFirstResponder];
    [_textSsid resignFirstResponder];
}

- (IBAction)ssidEditEnd:(id)sender
{
    UITextField *textField=(UITextField *)sender;
    NSLog(@"ssid Edit End");
    _textKey.text=[save getKeyBySsid:textField.text];
}

- (IBAction)showKeyPressed:(id)sender
{
    UIButton *button=(UIButton *)sender;
    
    //    NSLog(@"pressed");
    if (showKey== 1)
    {
        showKey= 0;
        [button setSelected:TRUE];
        [_textKey setSecureTextEntry:TRUE];
    }
    else
    {
        showKey= 1;
        [button setSelected:FALSE];
        [_textKey setSecureTextEntry:FALSE];
    }
}

// do smartLink
- (void)startSmartLink
{
    [smtlk SmtlkV30StartWithKey:_textKey.text];
}

- (void)stopSmartLink
{
    [smtlk SmtlkV30Stop];
}

- (void)SmtlkTimeOut
{
    //findTimes++;
   // NSLog(@"smtlkTimeOut, %ld", findTimes);
    //if (findTimes== 20)
    if (!isfinding)
    {
        [self stopSmartLink];
        smtlkState= 0;
        if ([macArray count]== 0)
            [self showTimeout];
        [_butConnect setTitle:@"开始连接" forState:UIControlStateNormal];
        return;
    }
    
    [smtlk SendSmtlkFind];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(SmtlkTimeOut) userInfo:nil repeats:NO];
}

// SmartLink delegate
- (void)SmtlkV30Finished
{
    if (times < 2)
    {
        NSLog(@"smtlk second start");
        times++;
        [self startSmartLink];
        findTimes= 0;
        isfinding = YES;
        [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(SmtlkTimeOut) userInfo:nil repeats:NO];
    }else{
        isfinding = NO;
        [self stopSmartLink];
    }
}

- (void)SmtlkV30ReceivedRspMAC:(NSString *)mac fromHost:(NSString *)host
{
    NSLog(@"Receive MAC:%@",mac);
    NSLog(@"Receive IP:%@",host);
    NSInteger macNum=[macArray count];
    NSInteger i;
    for (i= 0; i< macNum; i++)
    {
        if ([mac isEqualToString:macArray[i]])
            return;
    }
    [macArray addObject:mac];
    NSString* msg = [@"smart_config " stringByAppendingString:mac];
    NSLog(@"msg %@",msg);
    // 让模块停止发送信息。
    isfinding = NO;
    [smtlk SendSmartlinkEnd:msg moduelIp:host];
    [self showLogMac:mac fromhost:host];
}
//end 
- (void)showLogMac:(NSString *)mac fromhost:(NSString *)host
{
    _lblLog.text=mac;
    _lblLogIp.text = host;
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [_viewLog setAlpha:1.0f];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5
                                               delay:1.0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              [_viewLog setAlpha:0.0f];
                                          }
                                          completion:^(BOOL finished) {
                                          }];
                     }];
}

- (void)showTimeout
{
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [_viewTimeout setAlpha:1.0f];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5
                                               delay:1.0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              [_viewTimeout setAlpha:0.0f];
                                          }
                                          completion:^(BOOL finished) {
                                          }];
                     }];
}

@end
