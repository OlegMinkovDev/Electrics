//
//  DetailNewsViewController.m
//  Электрика
//
//  Created by Admin on 07.08.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "DetailNewsViewController.h"

@interface DetailNewsViewController ()

@end

@implementation DetailNewsViewController

@synthesize newsInfo;
@synthesize nameLabel;
@synthesize pictureImageView;
@synthesize dateLabel;
@synthesize scrollView;
@synthesize nameView;
@synthesize upImageView;
@synthesize dateView;
@synthesize downImageView;
@synthesize contentWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    contentWebView.delegate = self;
    
    nameLabel.text = [newsInfo objectForKey:@"name"];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[newsInfo objectForKey:@"image"]]]];
    
    pictureImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[newsInfo objectForKey:@"image"]]]];
    pictureImageView.contentMode = UIViewContentModeScaleToFill;
    
    if (image == nil)
        pictureImageView.image = [UIImage imageNamed:@"Icon-76@2x.png"];
    
    NSString *parseStr = [newsInfo objectForKey:@"date"];
    NSString *year = [parseStr substringToIndex:4];
    NSString *month = [parseStr substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [parseStr substringWithRange:NSMakeRange(8, 2)];
    
    dateLabel.text = [self GetCorrectDate:year Month:month Day:day];
    [contentWebView loadHTMLString:[newsInfo objectForKey:@"content"] baseURL:nil];
    
    contentWebView.translatesAutoresizingMaskIntoConstraints = YES;
    contentWebView.scrollView.scrollEnabled = NO;
    
    self.navigationItem.title = @"Детали новости";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self SetCorrectSizeForComponent];
}

- (NSString *)GetCorrectDate:(NSString *)_year Month: (NSString *)_month Day:(NSString *)_day {
    
    NSString *correctMonth = @"";
    
    if ([_month isEqualToString:@"01"])
        correctMonth = @"января";
    if ([_month isEqualToString:@"02"])
        correctMonth = @"февраля";
    if ([_month isEqualToString:@"03"])
        correctMonth = @"марта";
    if ([_month isEqualToString:@"04"])
        correctMonth = @"апреля";
    if ([_month isEqualToString:@"05"])
        correctMonth = @"мая";
    if ([_month isEqualToString:@"06"])
        correctMonth = @"июня";
    if ([_month isEqualToString:@"07"])
        correctMonth = @"июля";
    if ([_month isEqualToString:@"08"])
        correctMonth = @"августа";
    if ([_month isEqualToString:@"09"])
        correctMonth = @"сентября";
    if ([_month isEqualToString:@"10"])
        correctMonth = @"октября";
    if ([_month isEqualToString:@"11"])
        correctMonth = @"ноября";
    if ([_month isEqualToString:@"12"])
        correctMonth = @"декабря";
       
    return [NSString stringWithFormat:@"%i %@ %@г.", [_day intValue], correctMonth, _year];
}

- (void) webViewDidFinishLoad:(UIWebView *)webview
{
    int h = [[contentWebView stringByEvaluatingJavaScriptFromString:@"document.height"] floatValue];
    
    contentWebView.frame = CGRectMake(contentWebView.frame.origin.x, contentWebView.frame.origin.y, contentWebView.frame.size.width, h);
    
    CGFloat scrollViewHeight = 0.0f;
    for (UIView* view in scrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    [scrollView setContentSize:(CGSizeMake(320, scrollViewHeight))];
}

- (void)SetCorrectSizeForComponent {
    
    scrollView.translatesAutoresizingMaskIntoConstraints = YES;
    pictureImageView.translatesAutoresizingMaskIntoConstraints = YES;
    nameView.translatesAutoresizingMaskIntoConstraints = YES;
    upImageView.translatesAutoresizingMaskIntoConstraints = YES;
    dateView.translatesAutoresizingMaskIntoConstraints = YES;
    downImageView.translatesAutoresizingMaskIntoConstraints = YES;
    contentWebView.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect myScrollRect;
    
    if (scrHeight == 480 || scrHeight == 568)
        myScrollRect = CGRectMake(0.0f, 0.0f, 320.0f, scrHeight - 25);
    else if (scrHeight == 667) {
        
        myScrollRect = CGRectMake(0.0f, 0.0f, 375.0f, scrHeight - 25);
        contentWebView.frame = CGRectMake(contentWebView.frame.origin.x, contentWebView.frame.origin.y, 375, contentWebView.frame.size.height);
        
        pictureImageView.frame = CGRectMake(pictureImageView.frame.origin.x, pictureImageView.frame.origin.y, 375, pictureImageView.frame.size.height);
        nameView.frame = CGRectMake(nameView.frame.origin.x, nameView.frame.origin.y, 375 - 40, nameView.frame.size.height);
        upImageView.frame = CGRectMake(upImageView.frame.origin.x, upImageView.frame.origin.y, 375 - 19, upImageView.frame.size.height);
        dateView.frame = CGRectMake(dateView.frame.origin.x, dateView.frame.origin.y, 375 - 40, dateView.frame.size.height);
        downImageView.frame = CGRectMake(downImageView.frame.origin.x, downImageView.frame.origin.y, 375 - 19, downImageView.frame.size.height);
    }
    else {
        
        myScrollRect = CGRectMake(0.0f, 0.0f, 414.0f, scrHeight - 25);
        contentWebView.frame = CGRectMake(contentWebView.frame.origin.x, contentWebView.frame.origin.y, 414, contentWebView.frame.size.height);
        
        pictureImageView.frame = CGRectMake(pictureImageView.frame.origin.x, pictureImageView.frame.origin.y, 414, pictureImageView.frame.size.height);
        nameView.frame = CGRectMake(nameView.frame.origin.x, nameView.frame.origin.y, 414 - 40, nameView.frame.size.height);
        upImageView.frame = CGRectMake(upImageView.frame.origin.x, upImageView.frame.origin.y, 414 - 19, upImageView.frame.size.height);
        dateView.frame = CGRectMake(dateView.frame.origin.x, dateView.frame.origin.y, 414 - 40, dateView.frame.size.height);
        downImageView.frame = CGRectMake(downImageView.frame.origin.x, downImageView.frame.origin.y, 414 - 19, downImageView.frame.size.height);
    }
    
    [scrollView setFrame:myScrollRect];
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
