//
//  NewsViewController.m
//  Электрика
//
//  Created by Admin on 06.08.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()
{
    AppDelegate *delegate;
    NSArray *newsArray;
    int index;
    UIRefreshControl *refreshControl;
}

@end

@implementation NewsViewController

@synthesize newsTableView;

- (AppDelegate*)appdelegate {
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://autonomnoe.ru/newsjson.js"]];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
    
    newsTableView.delegate = (id)self;
    newsTableView.dataSource = self;
    newsTableView.opaque = NO;
    newsTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    
    newsArray = [NSArray array];
    index = 0;
    
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
    
    // Initialize the refresh control.
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor whiteColor];
    refreshControl.tintColor = [UIColor lightGrayColor];
    [refreshControl addTarget:self
                            action:@selector(refreshTable)
                  forControlEvents:UIControlEventValueChanged];

    [newsTableView addSubview:refreshControl];

    [self SetCorrectSizeForComponent];
}

- (void)refreshTable {
    //TODO: refresh your data
    
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://autonomnoe.ru/newsjson.js"]];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
    
    // End the refreshing
    if (refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor lightGrayColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        refreshControl.attributedTitle = attributedTitle;
        
        [refreshControl endRefreshing];
    }
    
    [self.newsTableView reloadData];
}

- (void)reloadData
{
    // Reload table data
    [self.newsTableView reloadData];
    
    // End the refreshing
    if (refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        refreshControl.attributedTitle = attributedTitle;
        
        [refreshControl endRefreshing];
    }
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

#pragma mark NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
   
    newsArray = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:nil];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    [newsTableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //поиск ячейки
    NewsCell *cell = (NewsCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        
        //если ячейка не найдена - создаем новую
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewsCell"owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [self SetCorrectSizeForCell:cell];
    
    // Делаем ячейки прозрачными
    cell.opaque = NO;
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    
    // Изменяем цвет выделения ячейки
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [delegate colorWithHexString:@"fafafa"];
    cell.selectedBackgroundView = view;
    
    // Записываем данные
    NSDictionary *dict = [newsArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [dict objectForKey:@"name"];
        
    // Async
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        // Get Image
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dict objectForKey:@"image"]]]];
        
        // Update UI
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.picturesImageView.image = image;
            
            if (image == nil)
                cell.picturesImageView.image = [UIImage imageNamed:@"Icon-76@2x.png"];
        });
    });
    
    NSString *parseStr = [dict objectForKey:@"date"];
    NSString *year = [parseStr substringToIndex:4];
    NSString *month = [parseStr substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [parseStr substringWithRange:NSMakeRange(8, 2)];
    
    cell.dateLabel.text = [self GetCorrectDate:year Month:month Day:day];
    
    return cell;
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

// Tap on table Row
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    index = (int)indexPath.row;
    
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    [self performSegueWithIdentifier:@"toDetailNews" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"toDetailNews"])
    {
        // Get reference to the destination view controller
        DetailNewsViewController *DetailVC = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        DetailVC.newsInfo = [newsArray objectAtIndex:index];
    }
}

- (void)refresh {
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}

- (void)addItem {
    // Add a new time
    [self.newsTableView reloadData];
    
    //[self stopLoading];
}

- (void)SetCorrectSizeForCell:(NewsCell *)cell {
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    cell.picturesImageView.translatesAutoresizingMaskIntoConstraints = YES;
    cell.nameView.translatesAutoresizingMaskIntoConstraints = YES;
    cell.upImageView.translatesAutoresizingMaskIntoConstraints = YES;
    cell.dateView.translatesAutoresizingMaskIntoConstraints = YES;
    cell.downImageView.translatesAutoresizingMaskIntoConstraints = YES;
    
    if (scrHeight == 568) {
        
        cell.picturesImageView.frame = CGRectMake(cell.picturesImageView.frame.origin.x, cell.picturesImageView.frame.origin.y, 320, cell.picturesImageView.frame.size.height);
        
    }
    
    if (scrHeight == 667) {
        
        cell.picturesImageView.frame = CGRectMake(cell.picturesImageView.frame.origin.x, cell.picturesImageView.frame.origin.y, 375, cell.picturesImageView.frame.size.height);
        cell.nameView.frame = CGRectMake(cell.nameView.frame.origin.x, cell.nameView.frame.origin.y, 375 - 40, cell.nameView.frame.size.height);
        cell.upImageView.frame = CGRectMake(cell.upImageView.frame.origin.x, cell.upImageView.frame.origin.y, 375 - 19, cell.upImageView.frame.size.height);
        cell.dateView.frame = CGRectMake(cell.dateView.frame.origin.x, cell.dateView.frame.origin.y, 375 - 40, cell.dateView.frame.size.height);
        cell.downImageView.frame = CGRectMake(cell.downImageView.frame.origin.x, cell.downImageView.frame.origin.y, 375 - 19, cell.downImageView.frame.size.height);
    }
    
    else if (scrHeight > 667) {
        
        cell.picturesImageView.frame = CGRectMake(cell.picturesImageView.frame.origin.x, cell.picturesImageView.frame.origin.y, 414, cell.picturesImageView.frame.size.height);
        cell.nameView.frame = CGRectMake(cell.nameView.frame.origin.x, cell.nameView.frame.origin.y, 414 - 40, cell.nameView.frame.size.height);
        cell.upImageView.frame = CGRectMake(cell.upImageView.frame.origin.x, cell.upImageView.frame.origin.y, 414 - 19, cell.upImageView.frame.size.height);
        cell.dateView.frame = CGRectMake(cell.dateView.frame.origin.x, cell.dateView.frame.origin.y, 414 - 40, cell.dateView.frame.size.height);
        cell.downImageView.frame = CGRectMake(cell.downImageView.frame.origin.x, cell.downImageView.frame.origin.y, 414 - 19, cell.downImageView.frame.size.height);
    }
}

- (void)SetCorrectSizeForComponent {
    
    newsTableView.translatesAutoresizingMaskIntoConstraints = YES;
    self.UIiAD.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect myTableRect;
    
    if (scrHeight == 480) {
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 50, 320, 480 - 50);
            else myTableRect = CGRectMake(0, 0, 320, 480);
        else myTableRect = CGRectMake(0, 0, 320, 480);
        
        self.UIiAD.frame = CGRectMake(0, 64, 320, 44);
    }
    else if (scrHeight == 568) {
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 50, 320, 568 - 50);
            else myTableRect = CGRectMake(0, 0, 320, 568);
        else myTableRect = CGRectMake(0, 0, 320, 568);
        
        self.UIiAD.frame = CGRectMake(0, 64, 320, 44);
    }
    else if (scrHeight == 667) {
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 50, 375, 667 - 50);
            else myTableRect = CGRectMake(0, 0, 375, 667);
        else myTableRect = CGRectMake(0, 0, 375, 667);
        
        self.UIiAD.frame = CGRectMake(0, 64, 375, 44);
    }
    else {
        
        if (delegate.isBanner)
            if (delegate.isShowBanner)
                myTableRect = CGRectMake(0, 50, 414, 729 - 50);
            else myTableRect = CGRectMake(0, 0, 414, 729);
        else myTableRect = CGRectMake(0, 0, 414, 729);
        
        self.UIiAD.frame = CGRectMake(0, 64, 414, 44);
    }
    
    [newsTableView setFrame:myTableRect];
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
