//
//  PowerCableViewController.m
//  Справочник электрика
//
//  Created by Admin on 25.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "PowerCableViewController.h"
#import "AppDelegate.h"

@interface PowerCableViewController ()

@end

@implementation PowerCableViewController

@synthesize powerCableWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    powerCableWebView.delegate = self;
    powerCableWebView.translatesAutoresizingMaskIntoConstraints = YES;
    
    // Получаем ссылку на AppDelegate
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // Загружаем страницу
    NSURLRequest *localRequest = [NSURLRequest requestWithURL: [NSURL fileURLWithPath:delegate.electricanPowerCabelLocalFilePath]];
    [self SetCorrectSizeForComponent];
    [powerCableWebView loadRequest:localRequest];
    
    self.navigationItem.title = @"Силовой кабель";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    // Корректирует ширину отображаемого контента (для ios 7.0)
    /*if ([[UIDevice currentDevice].systemVersion floatValue] == 7.0) {
        
        CGSize contentSize = powerCableWebView.scrollView.contentSize;
        CGSize viewSize = self.view.bounds.size;
        
        float correctZoomScale = viewSize.width / contentSize.width;
        
        powerCableWebView.scrollView.minimumZoomScale = correctZoomScale;
        powerCableWebView.scrollView.maximumZoomScale = correctZoomScale;
        powerCableWebView.scrollView.zoomScale = correctZoomScale;
    }*/
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
    
    [powerCableWebView setFrame:correctFrame];
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
