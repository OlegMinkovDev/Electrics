//
//  CalculatorsViewController.m
//  Справочник электрика
//
//  Created by Admin on 25.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "CalculatorsViewController.h"

@interface CalculatorsViewController ()

@end

@implementation CalculatorsViewController
{
    NSArray *kindOfCalc;
    AppDelegate *delegate;
}

@synthesize calculatorsTableView;
@synthesize backgroundImageView;
@synthesize UIiAD;

- (AppDelegate*)appdelegate {
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    calculatorsTableView.delegate = self;
    calculatorsTableView.dataSource = self;
    calculatorsTableView.scrollEnabled = NO;
    
    calculatorsTableView.opaque = NO;
    calculatorsTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    
    kindOfCalc = [NSArray arrayWithObjects:@"Калькулятор подбора сечения", @"Расчет освещенности помещения", @"Расчет скорости асинхронного двигателя", @"Калькулятор выбора УЗО", @"Диаметр-сечение", @"Online инженер", @"Документы", nil];
    
    [backgroundImageView setImage:[UIImage imageNamed:@"backgraund.png"]];
    
    // Получаем ссылку на AppDelegate
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        delegate.isShowBanner = [delegate CheckInternetConnection];
    });
    
    if (!delegate.isShowBanner)
        self.UIiAD.hidden = YES;
    else self.UIiAD.hidden = NO;
    
    [MKStoreManager sharedManager].delegate = (id)self;
    
    if ([MKStoreManager featureAPurchased])
        delegate.isBanner = false;

    
    [self SetCorrectSizeForComponent];
}

-(void)viewWillAppear:(BOOL)animated {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        delegate.isShowBanner = [delegate CheckInternetConnection];
    });
    
    if (delegate.isBanner == false)
        delegate.isShowBanner = false;
    
    
    self.UIiAD = [[self appdelegate] iAd];
    self.UIiAD.delegate = self;
    
    
    if (!delegate.isBanner)
        self.UIiAD.hidden = YES;
    if (!delegate.isShowBanner)
        self.UIiAD.hidden = YES;
    else self.UIiAD.hidden = NO;
    
    [self SetCorrectSizeForComponent];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    //dispatch_async(dispatch_get_main_queue(), ^{
    self.UIiAD.delegate = nil;
    self.UIiAD = nil;
    [self.UIiAD removeFromSuperview];
    //});
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [kindOfCalc count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    

    // Делаем ячейки прозрачными
    cell.opaque = NO;
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];

    // Записываем данные
    cell.textLabel.text = [kindOfCalc objectAtIndex:indexPath.row];

    return cell;
}

// Tap on table Row
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {

    if (indexPath.row == 0) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toSection" sender:self];
    }
    
    if (indexPath.row == 1) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toLight" sender:self];
    }
    
    if (indexPath.row == 2) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toSpeed" sender:self];
    }
    
    if (indexPath.row == 3) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toUZO" sender:self];
    }
    
    if (indexPath.row == 4) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toDiametrSection" sender:self];
    }

    if (indexPath.row == 5) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toSpec" sender:self];
    }
    
    if (indexPath.row == 6) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toGenerator" sender:self];
    }
}

- (void)SetCorrectSizeForComponent {
    
    calculatorsTableView.translatesAutoresizingMaskIntoConstraints = YES;
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = YES;
    self.UIiAD.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect myImageRect;
    CGRect myTableRect;
    
    if (delegate.isBanner)
        if (delegate.isShowBanner)
            myTableRect = CGRectMake(0, 64 + 50, 320, calculatorsTableView.frame.size.height);
        else myTableRect = CGRectMake(0, 64, 320, calculatorsTableView.frame.size.height);
        else myTableRect = CGRectMake(0, 64, 320, calculatorsTableView.frame.size.height);

    
    if (scrHeight == 480) {
        
        self.UIiAD.frame = CGRectMake(0, 64, 320, 44);
        myImageRect = CGRectMake(0.0f, 64.0f, 320.0f, 367.0f);
    }
    else if (scrHeight == 568) {
        
        self.UIiAD.frame = CGRectMake(0, 64, 320, 44);
        myImageRect = CGRectMake(0.0f, 64.0f, 320.0f, 454.0f);
    }
    else if (scrHeight == 667) {
        
        myImageRect = CGRectMake(0.0f, 64.0f, 375.0f, 553.0f);
        myTableRect = CGRectMake(0, 64, 375, calculatorsTableView.frame.size.height);
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 64 + 50, 375, calculatorsTableView.frame.size.height);
            else myTableRect = CGRectMake(0, 64, 375, calculatorsTableView.frame.size.height);
            else myTableRect = CGRectMake(0, 64, 375, calculatorsTableView.frame.size.height);
        
        self.UIiAD.frame = CGRectMake(0, 64, 375, 44);
    }
    else {
        
        myImageRect = CGRectMake(0.0f, 64.0f, 414.0f, 623.0f);
        myTableRect = CGRectMake(0, 64, 414, calculatorsTableView.frame.size.height);
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 64 + 50, 414, calculatorsTableView.frame.size.height);
            else myTableRect = CGRectMake(0, 64, 414, calculatorsTableView.frame.size.height);
            else myTableRect = CGRectMake(0, 64, 414, calculatorsTableView.frame.size.height);
        
        self.UIiAD.frame = CGRectMake(0, 64, 414, 44);
    }
    
    [backgroundImageView setFrame:myImageRect];
    [calculatorsTableView setFrame:myTableRect];
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    [self.view addSubview:self.UIiAD];
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
