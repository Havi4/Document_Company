//
//  GUISmtlkViewController.h
//  SmartLink V3.0
//
//  Created by Peter on 14-5-5.
//  Copyright (c) 2014年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFSmtlkV30.h"

@class localSave;
@class HFSmtlkV30;

@interface GUISmtlkViewController : UIViewController <SmtlkV30Delegate>
{
    int smtlkState;
    localSave *save;
    int showKey;
    HFSmtlkV30 *smtlk;
    NSInteger times;
    NSInteger findTimes;
    BOOL isfinding ;
}

@property (weak, nonatomic) IBOutlet UIButton *butConnect;
@property (weak, nonatomic) IBOutlet UITextField *textSsid;
@property (weak, nonatomic) IBOutlet UITextField *textKey;
@property (weak, nonatomic) IBOutlet UIView *viewLog;
@property (weak, nonatomic) IBOutlet UIView *viewTimeout;
@property (weak, nonatomic) IBOutlet UILabel *lblLog;
@property (weak, nonatomic) IBOutlet UILabel *lblLogIp;
- (IBAction)connectPressed:(id)sender;
- (IBAction)backgroundTapped:(id)sender;
- (IBAction)ssidEditEnd:(id)sender;
- (IBAction)showKeyPressed:(id)sender;


@end
