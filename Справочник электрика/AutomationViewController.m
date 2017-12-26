//
//  ViewController.m
//  Справочник электрика
//
//  Created by Admin on 13.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "AutomationViewController.h"

@interface AutomationViewController ()
{
    NSArray *automationArray;
    AppDelegate *delegate;
}

@end

@implementation AutomationViewController

@synthesize automationTableView;
@synthesize UIiAD;

- (AppDelegate*)appdelegate {
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    automationTableView.delegate = self;
    automationTableView.dataSource = self;
    automationTableView.scrollEnabled = YES;
    
    automationTableView.opaque = NO;
    automationTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    
    automationArray = [NSArray arrayWithObjects:@"Слаботочный кабель", @"Обозначение на схеме", @"Температурные датчики", @"Автоматизируем ИТП", @"Выдержки из СНиП", @"Мощность и токи двигателя", @"Обозн. коммут. аппаратов", @"Сопротивление термометров", @"Таблица плавких вставок", nil];
    
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
    return [automationArray count];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:
(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
            [cell setSeparatorInset:UIEdgeInsetsZero];
        
        if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
            [cell setLayoutMargins:UIEdgeInsetsZero];
        
    } else {
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
        
        if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
            [cell setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 0)];
        
    }
}

-(void)viewDidLayoutSubviews
{
    if ([automationTableView respondsToSelector:@selector(setSeparatorInset:)])
        [automationTableView setSeparatorInset:UIEdgeInsetsZero];
    
    if ([automationTableView respondsToSelector:@selector(setLayoutMargins:)])
        [automationTableView setLayoutMargins:UIEdgeInsetsZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Делаем яцейки прозрачными
    cell.opaque = NO;
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    
    // Записываем данные
    cell.textLabel.text = [automationArray objectAtIndex:indexPath.row];
    
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
        
        [self performSegueWithIdentifier:@"toLowCurrent" sender:self];
    }
    if (indexPath.row == 1) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toDesignationAuto" sender:self];
    }
    if (indexPath.row == 2) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toTemperature" sender:self];
    }
    if (indexPath.row == 3) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toAutomateITP" sender:self];
    }
    if (indexPath.row == 4) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toExcerptsFromSNIP" sender:self];
    }
    if (indexPath.row == 5) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toPowerAndCurrentEngine" sender:self];
    }
    if (indexPath.row == 6) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toDesignitionOfCommDevice" sender:self];
    }
    if (indexPath.row == 7) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toResistanceThermometrs" sender:self];
    }
    if (indexPath.row == 8) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toTableOfFuseLinks" sender:self];
    }
}

- (void)SetCorrectSizeForComponent {
    
    automationTableView.translatesAutoresizingMaskIntoConstraints = YES;
    self.UIiAD.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect myImageRect;
    CGRect myTableRect;
    
    /*if (delegate.isBanner)
        if (delegate.isShowBanner)
            myTableRect = CGRectMake(0, 64 + 50, 320, automationTableView.frame.size.height);
        else myTableRect = CGRectMake(0, 64, 320, automationTableView.frame.size.height);
    else myTableRect = CGRectMake(0, 64, 320, automationTableView.frame.size.height);*/
    
    if (scrHeight == 480) {
        
        myImageRect = CGRectMake(0.0f, 64.0f, 320.0f, 367.0f);
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 64 + 50, 320, ([automationArray count] * 44) - 88);
            else myTableRect = CGRectMake(0, 64, 320, ([automationArray count] * 44) - 50);
        else myTableRect = CGRectMake(0, 64, 320, [automationArray count] * 44 - 50);
        
        self.UIiAD.frame = CGRectMake(0, 64, 320, 44);
    }
    else if (scrHeight == 568) {
        
        automationTableView.scrollEnabled = false;
        myImageRect = CGRectMake(0.0f, 64.0f, 320.0f, 454.0f);
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 64 + 50, 320, ([automationArray count] * 44));
            else myTableRect = CGRectMake(0, 64, 320, ([automationArray count] * 44));
        else myTableRect = CGRectMake(0, 64, 320, ([automationArray count] * 44));
        
        self.UIiAD.frame = CGRectMake(0, 64, 320, 44);

    }
    else if (scrHeight == 667) {
        
        automationTableView.scrollEnabled = false;
        myImageRect = CGRectMake(0.0f, 64.0f, 375.0f, 553.0f);
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 64 + 50, 375, ([automationArray count] * 44));
            else myTableRect = CGRectMake(0, 64, 375, ([automationArray count] * 44));
        else myTableRect = CGRectMake(0, 64, 375, ([automationArray count] * 44));
        
        self.UIiAD.frame = CGRectMake(0, 64, 375, 44);

    }
    else {
        
        automationTableView.scrollEnabled = false;
        myImageRect = CGRectMake(0.0f, 64.0f, 414.0f, 623.0f);
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 64 + 50, 414, ([automationArray count] * 44));
            else myTableRect = CGRectMake(0, 64, 414, ([automationArray count] * 44));
        else myTableRect = CGRectMake(0, 64, 414, ([automationArray count] * 44));
        
        self.UIiAD.frame = CGRectMake(0, 64, 414, 44);
    }
    
    [automationTableView setFrame:myTableRect];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:myImageRect];
    [backgroundImageView setImage:[UIImage imageNamed:@"backgraund.png"]];
    [self.view addSubview:backgroundImageView];
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    [self.view addSubview:self.UIiAD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
