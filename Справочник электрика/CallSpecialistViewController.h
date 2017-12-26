//
//  CallSpecialistViewController.h
//  Электрика
//
//  Created by Admin on 21.08.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CallSpecialistViewController : UIViewController <NSURLConnectionDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>
{
    NSMutableData *_responseData;
}

@property (weak, nonatomic) IBOutlet UIView *topInfoView;
@property (weak, nonatomic) IBOutlet UITableView *callSpecialistTableView;
@property (weak, nonatomic) IBOutlet UIButton *callSpecialistButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UILabel *underlineLabel;

- (IBAction)CallSpec:(id)sender;

@end
