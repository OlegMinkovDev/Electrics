//
//  DesignationOfCommutativeDevicesViewController.m
//  Электрика
//
//  Created by Admin on 05.10.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "DesignationOfCommutativeDevicesViewController.h"

@interface DesignationOfCommutativeDevicesViewController ()

@end

@implementation DesignationOfCommutativeDevicesViewController

@synthesize designationOfCommutativeDevicesWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    designationOfCommutativeDevicesWebView.delegate = self;
    designationOfCommutativeDevicesWebView.translatesAutoresizingMaskIntoConstraints = YES;
    
    // Получаем ссылку на AppDelegate
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // Загружаем страницу
    NSURLRequest *localRequest = [NSURLRequest requestWithURL: [NSURL fileURLWithPath:delegate.automationDesignationOfCommDeviceLocalFilePath]];
    [self SetCorrectSizeForComponent];
    [designationOfCommutativeDevicesWebView loadRequest:localRequest];
    
    self.navigationItem.title = @"Обозначение коммутационных аппаратов";
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
    
    [designationOfCommutativeDevicesWebView setFrame:correctFrame];
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
