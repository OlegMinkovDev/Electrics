//
//  DiametrSectionViewController.m
//  Электрика
//
//  Created by Admin on 09.10.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "DiametrSectionViewController.h"

@interface DiametrSectionViewController ()
{
    AppDelegate *appDelegate;
    CGFloat screenHeight;
}

@end

@implementation DiametrSectionViewController

@synthesize diametrSectionTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    diametrSectionTableView.delegate = self;
    diametrSectionTableView.dataSource = self;
    diametrSectionTableView.scrollEnabled = false;
    
    diametrSectionTableView.opaque = NO;
    diametrSectionTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    self.navigationItem.title = @"Расчёт: диаметр-сечение";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self SetCorrectSizeForComponent];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cell1";
    static NSString *CellIdentifier2 = @"Cell2";
    
    // [tableView setSeparatorInset:UIEdgeInsetsZero];
    
    if (indexPath.row == 0) {
        
    
    //поиск ячейки
        DiametrCell *cell = (DiametrCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            
            //если ячейка не найдена - создаем новую
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DiametrCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.opaque = NO;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.diametrValueLabel.textColor = [appDelegate colorWithHexString:@"5294c3"];
        cell.minusLabel.textColor = [appDelegate colorWithHexString:@"5294c3"];
        cell.plusLabel.textColor  = [appDelegate colorWithHexString:@"5294c3"];
        cell.diametrSlider.tintColor = [appDelegate colorWithHexString:@"5294c3"];
        
        cell.diametrSlider.maximumValue = 130;
        cell.diametrSlider.value = 80;
        [cell.diametrSlider addTarget:self action:@selector(diametrValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        cell.diametrValueLabel.translatesAutoresizingMaskIntoConstraints = YES;
        cell.plusLabel.translatesAutoresizingMaskIntoConstraints = YES;
        cell.diametrSlider.translatesAutoresizingMaskIntoConstraints = YES;
        
        if (screenHeight == 667) {
            
            cell.diametrValueLabel.frame = CGRectMake(cell.diametrValueLabel.frame.origin.x + 65, cell.diametrValueLabel.frame.origin.y, cell.diametrValueLabel.frame.size.width, cell.diametrValueLabel.frame.size.height);
            cell.plusLabel.frame = CGRectMake(cell.plusLabel.frame.origin.x + 60, cell.plusLabel.frame.origin.y, cell.plusLabel.frame.size.width, cell.plusLabel.frame.size.height);
            cell.diametrSlider.frame = CGRectMake(cell.diametrSlider.frame.origin.x, cell.diametrSlider.frame.origin.y, cell.diametrSlider.frame.size.width + 60, cell.diametrSlider.frame.size.height);
            
        } else if (screenHeight == 736) {
            
            cell.diametrValueLabel.frame = CGRectMake(cell.diametrValueLabel.frame.origin.x + 105, cell.diametrValueLabel.frame.origin.y, cell.diametrValueLabel.frame.size.width, cell.diametrValueLabel.frame.size.height);
            cell.plusLabel.frame = CGRectMake(cell.plusLabel.frame.origin.x + 100, cell.plusLabel.frame.origin.y, cell.plusLabel.frame.size.width, cell.plusLabel.frame.size.height);
            cell.diametrSlider.frame = CGRectMake(cell.diametrSlider.frame.origin.x, cell.diametrSlider.frame.origin.y, cell.diametrSlider.frame.size.width + 100, cell.diametrSlider.frame.size.height);
        }
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        
        //поиск ячейки
        SectionCell *cell = (SectionCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil) {
            
            //если ячейка не найдена - создаем новую
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SectionCell"owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.opaque = NO;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.sectionValueLabel.textColor = [appDelegate colorWithHexString:@"5294c3"];
        cell.minusLabel.textColor = [appDelegate colorWithHexString:@"5294c3"];
        cell.plusLabel.textColor  = [appDelegate colorWithHexString:@"5294c3"];
        cell.sectionSlider.tintColor = [appDelegate colorWithHexString:@"5294c3"];
        
        cell.sectionSlider.maximumValue = 130;
        cell.sectionSlider.value = 50;
        
        [cell.sectionSlider addTarget:self
                               action:@selector(sectionValueChange:)
                                 forControlEvents:UIControlEventValueChanged];
        
        cell.sectionValueLabel.translatesAutoresizingMaskIntoConstraints = YES;
        cell.plusLabel.translatesAutoresizingMaskIntoConstraints = YES;
        cell.sectionSlider.translatesAutoresizingMaskIntoConstraints = YES;
        
        if (screenHeight == 667) {
            
            cell.sectionValueLabel.frame = CGRectMake(cell.sectionValueLabel.frame.origin.x + 65, cell.sectionValueLabel.frame.origin.y, cell.sectionValueLabel.frame.size.width, cell.sectionValueLabel.frame.size.height);
            cell.plusLabel.frame = CGRectMake(cell.plusLabel.frame.origin.x + 60, cell.plusLabel.frame.origin.y, cell.plusLabel.frame.size.width, cell.plusLabel.frame.size.height);
            cell.sectionSlider.frame = CGRectMake(cell.sectionSlider.frame.origin.x, cell.sectionSlider.frame.origin.y, cell.sectionSlider.frame.size.width + 60, cell.sectionSlider.frame.size.height);
            
        } else if (screenHeight == 736) {
            
            cell.sectionValueLabel.frame = CGRectMake(cell.sectionValueLabel.frame.origin.x + 105, cell.sectionValueLabel.frame.origin.y, cell.sectionValueLabel.frame.size.width, cell.sectionValueLabel.frame.size.height);
            cell.plusLabel.frame = CGRectMake(cell.plusLabel.frame.origin.x + 100, cell.plusLabel.frame.origin.y, cell.plusLabel.frame.size.width, cell.plusLabel.frame.size.height);
            cell.sectionSlider.frame = CGRectMake(cell.sectionSlider.frame.origin.x, cell.sectionSlider.frame.origin.y, cell.sectionSlider.frame.size.width + 100, cell.sectionSlider.frame.size.height);
        }

        
        return cell;
    }
    
    return nil;
}

- (void)diametrValueChanged:(UISlider *)sender {

    DiametrCell *diametrCell = (DiametrCell*)[diametrSectionTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UILabel *diametrLabel = (UILabel*)[diametrCell viewWithTag:1];
    diametrLabel.text = [NSString stringWithFormat:@"%.1f мм", sender.value / 10];
    
    SectionCell *sectionCell = (SectionCell*)[diametrSectionTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UISlider *sectionSlider = (UISlider*)[sectionCell viewWithTag:3];
    int res = (int)((([diametrLabel.text doubleValue] / 2) * ([diametrLabel.text doubleValue] / 2)) * 3.14);
    sectionSlider.value = res;
    UILabel *sectionLabel = (UILabel*)[sectionCell viewWithTag:2];
    sectionLabel.text = [NSString stringWithFormat:@"%i мм²", res];
}

- (void)sectionValueChange:(UISlider *)sender {
    
    float res = sqrt(sender.value / 3.14) * 2;
    DiametrCell *diametrCell = (DiametrCell*)[diametrSectionTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UISlider *diametrSlider = (UISlider*)[diametrCell viewWithTag:4];
    diametrSlider.value = res * 10;
    
    [self diametrValueChanged:diametrSlider];
}

- (void)SetCorrectSizeForComponent {
    
    diametrSectionTableView.translatesAutoresizingMaskIntoConstraints = YES;
    
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect correctDiametrSectionTableFrame;
    
    if (scrHeight == 667) {
        
        correctDiametrSectionTableFrame = CGRectMake(diametrSectionTableView.frame.origin.x, diametrSectionTableView.frame.origin.y, 375, diametrSectionTableView.frame.size.height);
        
        diametrSectionTableView.frame = correctDiametrSectionTableFrame;
        
        
    } else if (scrHeight > 667) {
        
        correctDiametrSectionTableFrame = CGRectMake(diametrSectionTableView.frame.origin.x, diametrSectionTableView.frame.origin.y, 414, diametrSectionTableView.frame.size.height);
        
        diametrSectionTableView.frame = correctDiametrSectionTableFrame;
    }
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
