//
//  AboutProjectViewController.m
//  Справочник электрика
//
//  Created by Admin on 14.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "AboutProjectViewController.h"

#define YOUR_APP_STORE_ID 998289589 //Change this one to your ID

@interface AboutProjectViewController ()
{
    BOOL isAboutProject;
    NSURLRequest *localRequest;
    AppDelegate *delegate;
}

@end

@implementation AboutProjectViewController

@synthesize aboutProjectSegmentedControl;
@synthesize aboutProjectWebView;
@synthesize rateButton;
@synthesize removeiIdButton;
@synthesize indicator;
@synthesize lockView;
@synthesize isInternetConnection;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    rateButton.tintColor = [delegate colorWithHexString:@"5294c3"];
    removeiIdButton.tintColor = [delegate colorWithHexString:@"5294c3"];
    
    aboutProjectSegmentedControl.tintColor = [delegate colorWithHexString:@"5294c3"];
    [aboutProjectSegmentedControl addTarget:self
                                       action:@selector(segmentedControlValueChange)
                             forControlEvents:UIControlEventValueChanged];
    
    aboutProjectWebView.delegate = self;
    aboutProjectWebView.translatesAutoresizingMaskIntoConstraints = YES;
    
    // Загружаем страницу
    localRequest = [NSURLRequest requestWithURL: [NSURL fileURLWithPath:delegate.aboutProjectLocalFilePath]];
    [self SetCorrectSizeForComponent];
    [aboutProjectWebView loadRequest:localRequest];

    isAboutProject = false;
    isInternetConnection = false;
    
    [MKStoreManager sharedManager].delegate = (id)self;
    
    if ([MKStoreManager featureAPurchased])
    {
        delegate.isBanner = false;
    }
    
    [removeiIdButton setBackgroundColor:[delegate colorWithHexString:@"5294c3"]];
    [removeiIdButton setTitle:@"Убрать рекламу или восстановить покупку" forState:UIControlStateNormal];
    removeiIdButton.titleLabel.numberOfLines = 2;
    removeiIdButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    removeiIdButton.titleLabel.textColor = [UIColor whiteColor];
    removeiIdButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    removeiIdButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    removeiIdButton.frame = CGRectMake(5, 380, 152.5, 40);
    
    [rateButton setBackgroundColor:[delegate colorWithHexString:@"5294c3"]];
    [rateButton setTitle:@"Оставить отзыв в App Store" forState:UIControlStateNormal];
    rateButton.titleLabel.numberOfLines = 2;
    rateButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    rateButton.titleLabel.textColor = [UIColor whiteColor];
    rateButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    rateButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    rateButton.frame = CGRectMake(162.5, 380, 152.5, 40);
    
    [self SetCorrectSizeForComponent];
    
    [indicator setHidden:YES];
    [lockView setHidden:YES];
    
    aboutProjectWebView.scrollView.delegate = self;
    [aboutProjectWebView.scrollView setContentInset:UIEdgeInsetsMake(-60,0,0,0)];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ( navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    
    return YES;
}
- (void)segmentedControlValueChange {

    if (isAboutProject) {
        
        localRequest = [NSURLRequest requestWithURL: [NSURL fileURLWithPath:delegate.aboutProjectLocalFilePath]];
        [aboutProjectWebView loadRequest:localRequest];
        isAboutProject = false;
    
    } else {
        
        localRequest = [NSURLRequest requestWithURL: [NSURL fileURLWithPath:delegate.aboutProjectResponsibilityLocalFilePath]];
        [aboutProjectWebView loadRequest:localRequest];
        isAboutProject = true;
    }
}

- (void)SetCorrectSizeForComponent {
    
    rateButton.translatesAutoresizingMaskIntoConstraints = YES;
    removeiIdButton.translatesAutoresizingMaskIntoConstraints = YES;
    aboutProjectSegmentedControl.translatesAutoresizingMaskIntoConstraints = YES;
    lockView.translatesAutoresizingMaskIntoConstraints = YES;
    indicator.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect correctFrame;
    
    if (scrHeight == 480) {
     
        correctFrame = CGRectMake(0, 120, 320, 480 - 230);
        [rateButton setFrame:CGRectMake(5 + removeiIdButton.frame.size.width + 5, 480 - 100, rateButton.frame.size.width, rateButton.frame.size.height)];
        [removeiIdButton setFrame:CGRectMake(5, 480 - 100, removeiIdButton.frame.size.width, removeiIdButton.frame.size.height)];
        [aboutProjectSegmentedControl setFrame:CGRectMake(320 - 283, 80, aboutProjectSegmentedControl.frame.size.width, aboutProjectSegmentedControl.frame.size.height)];
        lockView.frame = CGRectMake(0, 0, 320, 480);
    }
    else if (scrHeight == 568) {
        
        correctFrame = CGRectMake(0, 120, 320, 568 - 230);
        [rateButton setFrame:CGRectMake(5 + removeiIdButton.frame.size.width + 5, 568 - 100, rateButton.frame.size.width, rateButton.frame.size.height)];
        [removeiIdButton setFrame:CGRectMake(5, 568 - 100, removeiIdButton.frame.size.width, removeiIdButton.frame.size.height)];
        [aboutProjectSegmentedControl setFrame:CGRectMake(320 - 283, 80, aboutProjectSegmentedControl.frame.size.width, aboutProjectSegmentedControl.frame.size.height)];
        lockView.frame = CGRectMake(0, 0, 320, 568);
        indicator.frame = CGRectMake(320 / 2 - 10, 568 / 2 - 10, indicator.frame.size.width, indicator.frame.size.height);
    }
    else if (scrHeight == 667) {
        
        correctFrame = CGRectMake(0, 120, 375, 667 - 230);
        [removeiIdButton setFrame:CGRectMake(5, 667 - 100, removeiIdButton.frame.size.width + 27.5, removeiIdButton.frame.size.height)];
        [rateButton setFrame:CGRectMake(5 + removeiIdButton.frame.size.width + 5, 667 - 100, rateButton.frame.size.width + 27.5, rateButton.frame.size.height)];
        [aboutProjectSegmentedControl setFrame:CGRectMake(375/2 - aboutProjectSegmentedControl.frame.size.width/2, 80, aboutProjectSegmentedControl.frame.size.width, aboutProjectSegmentedControl.frame.size.height)];
        lockView.frame = CGRectMake(0, 0, 375, 667);
        indicator.frame = CGRectMake(375 / 2 - 10, 667 / 2 - 10, indicator.frame.size.width, indicator.frame.size.height);
    }
    else {
        
        correctFrame = CGRectMake(0, 120, 414, 736 - 230);
        [removeiIdButton setFrame:CGRectMake(5, 736 - 100, removeiIdButton.frame.size.width + 46, removeiIdButton.frame.size.height)];
        [rateButton setFrame:CGRectMake(5 + removeiIdButton.frame.size.width + 5, 736 - 100, rateButton.frame.size.width + 46, rateButton.frame.size.height)];
        [aboutProjectSegmentedControl setFrame:CGRectMake(414/2 - aboutProjectSegmentedControl.frame.size.width/2, 80, aboutProjectSegmentedControl.frame.size.width, aboutProjectSegmentedControl.frame.size.height)];
        lockView.frame = CGRectMake(0, 0, 414, 736);
        indicator.frame = CGRectMake(414 / 2 - 10, 736 / 2 - 10, indicator.frame.size.width, indicator.frame.size.height);
    }
    
    [aboutProjectWebView setFrame:correctFrame];
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

- (IBAction)RemoveiAdBanner:(id)sender {

    [self showLockView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        isInternetConnection = [delegate CheckInternetConnection];
        
        if (isInternetConnection) {
            
            [[MKStoreManager sharedManager] buyFeatureA];
            
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Сообщение" message:@"Отсутствует интернет соеденение. Пожалуйста, повторите попытку позже" delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil];
            [alert show];
            
            [self hideLockView];
        }
        
    });
}

- (IBAction)RateApp:(id)sender {
    
    [self showLockView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        isInternetConnection = [delegate CheckInternetConnection];
        
        if (isInternetConnection) {
            
            static NSString *const iOS7AppStoreURLFormat = @"itms-apps://itunes.apple.com/app/id%d";
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[NSString stringWithFormat:iOS7AppStoreURLFormat, YOUR_APP_STORE_ID]]];
            [self hideLockView];
            
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Сообщение" message:@"Отсутствует интернет соеденение. Пожалуйста, повторите попытку позже" delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil];
            [alert show];
            
            [self hideLockView];
        }
        
    });
    
}

- (void)productAPurchased
{
    [self hideLockView];
    delegate.isBanner = false;
}

// покупка не прошла, либо была отменена
- (void)failed
{
    [self hideLockView];
}

-(void)showLockView
{
    lockView.hidden = NO;
    indicator.hidden = NO;
    [indicator startAnimating];
    
    [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:FALSE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
}

-(void)hideLockView
{
    lockView.hidden = YES;
    indicator.hidden = YES;
    [indicator stopAnimating];
    
    [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:TRUE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
}
@end
