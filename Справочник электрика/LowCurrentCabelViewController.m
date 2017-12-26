//
//  LowCurrentCabelViewController.m
//  Справочник электрика
//
//  Created by Admin on 21.05.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "LowCurrentCabelViewController.h"

@interface LowCurrentCabelViewController ()

@end

@implementation LowCurrentCabelViewController

@synthesize lowCurrentWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    lowCurrentWebView.delegate = self;
    lowCurrentWebView.translatesAutoresizingMaskIntoConstraints = YES;
    
    // Получаем ссылку на AppDelegate
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // Загружаем страницу
    NSURLRequest *localRequest = [NSURLRequest requestWithURL: [NSURL fileURLWithPath:delegate.automationLowCurrentCabelLocalFilePath]];
    [self SetCorrectSizeForComponent];
    [lowCurrentWebView loadRequest:localRequest];
    
    self.navigationItem.title = @"Слаботочный кабель";
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
    
    [lowCurrentWebView setFrame:correctFrame];
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
