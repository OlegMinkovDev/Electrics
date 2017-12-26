//
//  CalculateSpeedViewController.m
//  Справочник электрика
//
//  Created by Admin on 03.05.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "CalculateSpeedViewController.h"

const CGRect SEPARATOR_FRAME_IPHONE4_IPHONE5 = {0, 0, 320, 1.05};
const CGRect SEPARATOR_FRAME_IPHONE6 = {0, 0, 375, 1.05};
const CGRect SEPARATOR_FRAME_IPHONE6PLUS = {0, 0, 414, 1.05};

@interface CalculateSpeedViewController ()

@end

@implementation CalculateSpeedViewController
{
    AppDelegate *delegate;
    CGFloat screenHeight;
}

@synthesize calculateSpeedTableView;
@synthesize backgroundImageView;
@synthesize infoView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    calculateSpeedTableView.opaque = NO;
    calculateSpeedTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    calculateSpeedTableView.scrollEnabled = NO;
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self.navigationItem.title = @"Расчет скорости асинхронного двигателя";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    [self SetCorrectSizeForComponent];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:
(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
        [cell setLayoutMargins:UIEdgeInsetsZero];
    
    UIView* separatorLineView;

    if (indexPath.row == 2) {
        
        if (screenHeight == 667)
            separatorLineView = [[UIView alloc] initWithFrame:SEPARATOR_FRAME_IPHONE6];
        else if (screenHeight == 736)
            separatorLineView = [[UIView alloc] initWithFrame:SEPARATOR_FRAME_IPHONE6PLUS];
        else separatorLineView = [[UIView alloc] initWithFrame:SEPARATOR_FRAME_IPHONE4_IPHONE5];
    
        separatorLineView.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1];
        [cell.contentView addSubview:separatorLineView];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([calculateSpeedTableView respondsToSelector:@selector(setSeparatorInset:)])
        [calculateSpeedTableView setSeparatorInset:UIEdgeInsetsZero];
    
    if ([calculateSpeedTableView respondsToSelector:@selector(setLayoutMargins:)])
        [calculateSpeedTableView setLayoutMargins:UIEdgeInsetsZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cell1";
    static NSString *CellIdentifier2 = @"Cell2";
    static NSString *CellIdentifier3 = @"Cell3";
    
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    
    if (indexPath.row == 0) {
        
        //поиск ячейки
        FrequencyCell *cell = (FrequencyCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            
            //если ячейка не найдена - создаем новую
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FrequencyCell"owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.opaque = NO;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.HertzLabel.textColor = [delegate colorWithHexString:@"5294c3"];
        cell.minusLabel.textColor = [delegate colorWithHexString:@"5294c3"];
        cell.plusLabel.textColor  = [delegate colorWithHexString:@"5294c3"];
        cell.FrequencySlider.tintColor = [delegate colorWithHexString:@"5294c3"];
        
        cell.FrequencySlider.maximumValue = 120;
        cell.FrequencySlider.value = 60;
        [cell.FrequencySlider addTarget:self action:@selector(frequencySliderValueChanged:) forControlEvents:UIControlEventValueChanged];
            
        cell.HertzLabel.text = @"60 Гц";
        
        cell.HertzLabel.translatesAutoresizingMaskIntoConstraints = YES;
        cell.plusLabel.translatesAutoresizingMaskIntoConstraints = YES;
        cell.FrequencySlider.translatesAutoresizingMaskIntoConstraints = YES;
        
        if (screenHeight == 667) {
            
            cell.HertzLabel.frame = CGRectMake(cell.HertzLabel.frame.origin.x + 65, cell.HertzLabel.frame.origin.y, cell.HertzLabel.frame.size.width, cell.HertzLabel.frame.size.height);
            cell.plusLabel.frame = CGRectMake(cell.plusLabel.frame.origin.x + 60, cell.plusLabel.frame.origin.y, cell.plusLabel.frame.size.width, cell.plusLabel.frame.size.height);
            cell.FrequencySlider.frame = CGRectMake(cell.FrequencySlider.frame.origin.x, cell.FrequencySlider.frame.origin.y, cell.FrequencySlider.frame.size.width + 60, cell.FrequencySlider.frame.size.height);
        
        } else if (screenHeight == 736) {
            
            cell.HertzLabel.frame = CGRectMake(cell.HertzLabel.frame.origin.x + 105, cell.HertzLabel.frame.origin.y, cell.HertzLabel.frame.size.width, cell.HertzLabel.frame.size.height);
            cell.plusLabel.frame = CGRectMake(cell.plusLabel.frame.origin.x + 100, cell.plusLabel.frame.origin.y, cell.plusLabel.frame.size.width, cell.plusLabel.frame.size.height);
            cell.FrequencySlider.frame = CGRectMake(cell.FrequencySlider.frame.origin.x, cell.FrequencySlider.frame.origin.y, cell.FrequencySlider.frame.size.width + 100, cell.FrequencySlider.frame.size.height);
        }

        return cell;
    }
    else if (indexPath.row == 1) {
        
        //поиск ячейки
        CountCell *cell = (CountCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil) {
                
            //если ячейка не найдена - создаем новую
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CountCell"owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
            
        cell.opaque = NO;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.countPoleSegmentedControl.tintColor = [delegate colorWithHexString:@"5294c3"];
        [cell.countPoleSegmentedControl addTarget:self
                             action:@selector(segmentedControlValueChange)
                   forControlEvents:UIControlEventValueChanged];
        
        cell.countPoleSegmentedControl.translatesAutoresizingMaskIntoConstraints = YES;
        
        if (screenHeight == 667) {
            
            cell.countPoleSegmentedControl.frame = CGRectMake(cell.countPoleSegmentedControl.frame.origin.x, cell.countPoleSegmentedControl.frame.origin.y, cell.countPoleSegmentedControl.frame.size.width + 60, cell.countPoleSegmentedControl.frame.size.height);
        
        } else if (screenHeight == 736) {
        
            cell.countPoleSegmentedControl.frame = CGRectMake(cell.countPoleSegmentedControl.frame.origin.x, cell.countPoleSegmentedControl.frame.origin.y, cell.countPoleSegmentedControl.frame.size.width + 100, cell.countPoleSegmentedControl.frame.size.height);
        }
        
        return cell;
    }
    else {
        
        //поиск ячейки
        SpeedCell *cell = (SpeedCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil) {
            
            //если ячейка не найдена - создаем новую
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SpeedCell"owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.opaque = NO;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        
        cell.revLabel.textColor = [delegate colorWithHexString:@"5294c3"];
        cell.minusLabel.textColor = [delegate colorWithHexString:@"5294c3"];
        cell.plusLabel.textColor  = [delegate colorWithHexString:@"5294c3"];
        cell.speedSlider.tintColor = [delegate colorWithHexString:@"5294c3"];
        
        cell.revLabel.translatesAutoresizingMaskIntoConstraints = YES;
        cell.plusLabel.translatesAutoresizingMaskIntoConstraints = YES;
        cell.speedSlider.translatesAutoresizingMaskIntoConstraints = YES;
        
        [cell.speedSlider addTarget:self action:@selector(speedSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        if (screenHeight == 667) {
            
            cell.revLabel.frame = CGRectMake(cell.revLabel.frame.origin.x + 60, cell.revLabel.frame.origin.y, cell.revLabel.frame.size.width, cell.revLabel.frame.size.height);
            cell.plusLabel.frame = CGRectMake(cell.plusLabel.frame.origin.x + 60, cell.plusLabel.frame.origin.y, cell.plusLabel.frame.size.width, cell.plusLabel.frame.size.height);
            cell.speedSlider.frame = CGRectMake(cell.speedSlider.frame.origin.x, cell.speedSlider.frame.origin.y, cell.speedSlider.frame.size.width + 60, cell.speedSlider.frame.size.height);
        
        } else if (screenHeight == 736) {
            
            cell.revLabel.frame = CGRectMake(cell.revLabel.frame.origin.x + 100, cell.revLabel.frame.origin.y, cell.revLabel.frame.size.width, cell.revLabel.frame.size.height);
            cell.plusLabel.frame = CGRectMake(cell.plusLabel.frame.origin.x + 100, cell.plusLabel.frame.origin.y, cell.plusLabel.frame.size.width, cell.plusLabel.frame.size.height);
            cell.speedSlider.frame = CGRectMake(cell.speedSlider.frame.origin.x, cell.speedSlider.frame.origin.y, cell.speedSlider.frame.size.width + 100, cell.speedSlider.frame.size.height);
        }

        
        return cell;
    }

    return nil;
}

- (void)frequencySliderValueChanged:(UISlider *)sender {
    
    FrequencyCell *frequencyCell = (FrequencyCell*)[calculateSpeedTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UILabel *frequencyLabel = (UILabel*)[frequencyCell viewWithTag:1];
    frequencyLabel.text = [NSString stringWithFormat:@"%i Гц", (int)sender.value];
    
    CountCell *countCell = (CountCell*)[calculateSpeedTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UISegmentedControl *segment = (UISegmentedControl*)[countCell viewWithTag:2];
    int countPole = [[segment titleForSegmentAtIndex:segment.selectedSegmentIndex] intValue];
    
    SpeedCell *speedCell = (SpeedCell*)[calculateSpeedTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UILabel *speedLabel = (UILabel*)[speedCell viewWithTag:3];
    UISlider *speedSlider = (UISlider*)[speedCell viewWithTag:4];
    speedSlider.maximumValue = (int)sender.maximumValue;
    speedSlider.value = sender.value;
    speedLabel.text = [NSString stringWithFormat:@"%i об/мин", (int)((int)sender.value * 60 / countPole)];
}

- (void)speedSliderValueChanged:(UISlider *)sender {
    
    FrequencyCell *frequencyCell = (FrequencyCell*)[calculateSpeedTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    UISlider *frequencySlider = (UISlider*)[frequencyCell viewWithTag:5];
    frequencySlider.value = sender.value;
    
    [self frequencySliderValueChanged:frequencySlider];
}

- (void)segmentedControlValueChange {
    
    FrequencyCell *frequencyCell = (FrequencyCell*)[calculateSpeedTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UISlider *frequencySlider = (UISlider*)[frequencyCell viewWithTag:5];
    
    CountCell *countCell = (CountCell*)[calculateSpeedTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UISegmentedControl *segment = (UISegmentedControl*)[countCell viewWithTag:2];
    int countPole = [[segment titleForSegmentAtIndex:segment.selectedSegmentIndex] intValue];
    
    SpeedCell *speedCell = (SpeedCell*)[calculateSpeedTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UILabel *speedLabel = (UILabel*)[speedCell viewWithTag:3];
    speedLabel.text = [NSString stringWithFormat:@"%i об/мин", (int)((int)frequencySlider.value * 60 / countPole)];
}

- (void)SetCorrectSizeForComponent {
    
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = YES;
    calculateSpeedTableView.translatesAutoresizingMaskIntoConstraints = YES;
    infoView.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect correctBackgroundFrame;
    CGRect correctSpeedTableFrame;
    CGRect correctInfoView;
    
    if (scrHeight == 480)
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 320.0f, 367.0f);
    else if (scrHeight == 568)
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 320.0f, 454.0f);
    
    else if (scrHeight == 667) {
        
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 375.0f, 553.0f);
        correctSpeedTableFrame = CGRectMake(calculateSpeedTableView.frame.origin.x, calculateSpeedTableView.frame.origin.y, 375, calculateSpeedTableView.frame.size.height);
        correctInfoView = CGRectMake(infoView.frame.origin.x, infoView.frame.origin.y, 375, infoView.frame.size.height);
        
        backgroundImageView.frame = correctBackgroundFrame;
        calculateSpeedTableView.frame = correctSpeedTableFrame;
        infoView.frame = correctInfoView;
        
    } else {
        
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 414.0f, 553.0f);
        correctSpeedTableFrame = CGRectMake(calculateSpeedTableView.frame.origin.x, calculateSpeedTableView.frame.origin.y, 414, calculateSpeedTableView.frame.size.height);
        correctInfoView = CGRectMake(infoView.frame.origin.x, infoView.frame.origin.y, 414, infoView.frame.size.height);
        
        backgroundImageView.frame = correctBackgroundFrame;
        calculateSpeedTableView.frame = correctSpeedTableFrame;
        infoView.frame = correctInfoView;
    }
    
    backgroundImageView.frame = correctBackgroundFrame;
    [self.view insertSubview:backgroundImageView atIndex:0];
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
