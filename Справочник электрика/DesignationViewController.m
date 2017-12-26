//
//  DesignationViewController.m
//  Справочник электрика
//
//  Created by Admin on 15.05.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "DesignationViewController.h"

@interface DesignationViewController ()

@end

@implementation DesignationViewController

@synthesize designationWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    designationWebView.delegate = self;
    designationWebView.translatesAutoresizingMaskIntoConstraints = YES;
    
    // Получаем ссылку на AppDelegate
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // Загружаем страницу
    NSURLRequest *localRequest = [NSURLRequest requestWithURL: [NSURL fileURLWithPath:delegate.electricanDesignationLocalFilePath]];
    [self SetCorrectSizeForComponent];
    [designationWebView loadRequest:localRequest];
    
    self.navigationItem.title = @"Обозначение на схеме";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)SetCorrectSizeForComponent {
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect correctFrame;
    
    if (scrHeight == 480) {
        
        correctFrame = CGRectMake(0, 0, 320, 480);
        //if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0)
        //  correctFrame = CGRectMake(0, 0, 320, 480 - 56 - 100);
    }
    else if (scrHeight == 568)
        correctFrame = CGRectMake(0, 0, 320, 568);
    else if (scrHeight == 667)
        correctFrame = CGRectMake(0, 0, 375, 667);
    else correctFrame = CGRectMake(0, 0, 414, 736);
    
    [designationWebView setFrame:correctFrame];
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
