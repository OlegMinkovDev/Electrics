//
//  ElectricianViewController.m
//  Справочник электрика
//
//  Created by Admin on 14.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "ElectricianViewController.h"

@interface ElectricianViewController ()

@end

@implementation ElectricianViewController
{
    NSArray *electricanArray;
    AppDelegate *delegate;
}

@synthesize electricanTableView;

- (AppDelegate*)appdelegate {
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    electricanTableView.delegate = self;
    electricanTableView.dataSource = self;
    //electricanTableView.scrollEnabled = NO;
    
    electricanArray = [NSArray arrayWithObjects:@"Силовой кабель", @"Обозначения на схеме", @"Выдержки из СНиП Электротехнические устройства", @"Заземление", @"Основы безопасности", @"Таблица потребителей", @"Соеденение проводов", @"Собираем шкаф", @"Автоматические выключатели", @"Таблица сечений кабеля", @"Защита IP", @"Кабель для судостраителей", @"Электромонтаж у себя дома", nil];
    
    electricanTableView.opaque = NO;
    electricanTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    
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
    
    NSLog(@"ElectricanViewController");
}

-(void)viewWillAppear:(BOOL)animated {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        delegate.isShowBanner = [delegate CheckInternetConnection];
    });
    
    if (delegate.isBanner == false)
     delegate.isShowBanner = false;
    
    //dispatch_async(dispatch_get_main_queue(), ^{
        self.UIiAD = [[self appdelegate] iAd];
        self.UIiAD.delegate = self;
    //});
    
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
    return [electricanArray count];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:
(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
    
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
    if ([electricanTableView respondsToSelector:@selector(setSeparatorInset:)])
        [electricanTableView setSeparatorInset:UIEdgeInsetsZero];
    
    if ([electricanTableView respondsToSelector:@selector(setLayoutMargins:)])
        [electricanTableView setLayoutMargins:UIEdgeInsetsZero];
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
    cell.textLabel.text = [electricanArray objectAtIndex:indexPath.row];
    
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
        
        [self performSegueWithIdentifier:@"toPowerCable" sender:self];
    }
    if (indexPath.row == 1) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toDesignation" sender:self];
    }

    if (indexPath.row == 2) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toSNIP" sender:self];
    }
    if (indexPath.row == 3) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toGround" sender:self];
    }
    if (indexPath.row == 4) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toSecurity" sender:self];
    }
    if (indexPath.row == 5) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toTableCabel" sender:self];
    }
    if (indexPath.row == 6) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toConcatenateWires" sender:self];
    }
    if (indexPath.row == 7) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toCollectCabinet" sender:self];
    }
    if (indexPath.row == 8) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toCircuitBreakers" sender:self];
    }
    if (indexPath.row == 9) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toTableOfCableCrossSection" sender:self];
    }
    if (indexPath.row == 10) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toProtectionIP" sender:self];
    }
    if (indexPath.row == 11) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toCablesForShipbuilders" sender:self];
    }
    if (indexPath.row == 12) {
        
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStyleBordered
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
        
        [self performSegueWithIdentifier:@"toWiringAtHome" sender:self];
    }
}

- (void)SetCorrectSizeForComponent {
    
    electricanTableView.translatesAutoresizingMaskIntoConstraints = YES;
    //self.UIiAD.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect myImageRect;
    CGRect myTableRect;
    
    if (delegate.isBanner)
        if (delegate.isShowBanner)
            myTableRect = CGRectMake(0, 64 + 50, 320, electricanTableView.frame.size.height);
        else myTableRect = CGRectMake(0, 64, 320, electricanTableView.frame.size.height);
    else myTableRect = CGRectMake(0, 64, 320, electricanTableView.frame.size.height);
    
    if (scrHeight == 480) {
        
        myImageRect = CGRectMake(0.0f, 64.0f, 320.0f, 367.0f);
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 64 + 50, 320, electricanTableView.frame.size.height);
            else myTableRect = CGRectMake(0, 64, 320, electricanTableView.frame.size.height + 44 - 22);
        else myTableRect = CGRectMake(0, 64, 320, electricanTableView.frame.size.height + 44 - 22);
        
        self.UIiAD.frame = CGRectMake(0, 64, 320, 44);
    }
    else if (scrHeight == 568) {
        
        myImageRect = CGRectMake(0.0f, 64.0f, 320.0f, 454.0f);
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 64 + 50, 320, electricanTableView.frame.size.height + 44);
            else myTableRect = CGRectMake(0, 64, 320, electricanTableView.frame.size.height + 88 - 22);
        else myTableRect = CGRectMake(0, 64, 320, electricanTableView.frame.size.height + 88 - 22);
        
        self.UIiAD.frame = CGRectMake(0, 64, 320, 44);
    }
    else if (scrHeight == 667) {
        
        myImageRect = CGRectMake(0.0f, 64.0f, 375.0f, 553.0f);
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 64 + 50, 375, 44 * 12 - 22);
            else {
                
                myTableRect = CGRectMake(0, 64, 375, 44 * 12);
                electricanTableView.scrollEnabled = NO;
            }
        else {
                
            myTableRect = CGRectMake(0, 64, 375, 44 * 12);
            electricanTableView.scrollEnabled = NO;
        }
        
        self.UIiAD.frame = CGRectMake(0, 64, 375, 44);
    }
    else {
        
        electricanTableView.scrollEnabled = NO;
        myImageRect = CGRectMake(0.0f, 64.0f, 414.0f, 623.0f);
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 64 + 50, 414, 44 * [electricanArray count]);
            else myTableRect = CGRectMake(0, 64, 414, 44 * [electricanArray count]);
        else myTableRect = CGRectMake(0, 64, 414, 44 * [electricanArray count]);

        self.UIiAD.frame = CGRectMake(0, 64, 414, 44);
    }
    
    [electricanTableView setFrame:myTableRect];
        
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:myImageRect];
    [backgroundImageView setImage:[UIImage imageNamed:@"backgraund.png"]];
    [self.view addSubview:backgroundImageView];
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
