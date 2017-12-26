//
//  PowerAndCurrentEngineViewController.m
//  Электрика
//
//  Created by Admin on 06.10.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "PowerAndCurrentEngineViewController.h"

@interface PowerAndCurrentEngineViewController ()

@end

@implementation PowerAndCurrentEngineViewController

@synthesize powerAndCurrentEngineWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    powerAndCurrentEngineWebView.delegate = self;
    powerAndCurrentEngineWebView.translatesAutoresizingMaskIntoConstraints = YES;
    
    // Получаем ссылку на AppDelegate
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // Загружаем страницу
    NSURLRequest *localRequest = [NSURLRequest requestWithURL: [NSURL fileURLWithPath:delegate.automationPowerAndCurrentEngineFilePath]];
    [self SetCorrectSizeForComponent];
    [powerAndCurrentEngineWebView loadRequest:localRequest];
    
    self.navigationItem.title = @"Мощность и токи двигателя";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)SetCorrectSizeForComponent {
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect correctFrame;
    
    if (scrHeight == 480)
        correctFrame = CGRectMake(0, 0, 320, 480);
    else if (scrHeight == 568)
        correctFrame = CGRectMake(0, 0, 320, 568);
    else if (scrHeight == 667)
        correctFrame = CGRectMake(0, 0, 375, 667);
    else correctFrame = CGRectMake(0, 0, 414, 736);
    
    [powerAndCurrentEngineWebView setFrame:correctFrame];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
