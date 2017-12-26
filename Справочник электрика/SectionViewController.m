//
//  CalculatorsViewController.m
//  Справочник электрика
//
//  Created by Admin on 14.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "SectionViewController.h"

const CGRect SEGMENTED_FRAME_IPHONE4_IPHONE5 = {210, 6, 90, 30};
const CGRect SEGMENTED_FRAME_IPHONE6 = {265, 6, 90, 30};
const CGRect SEGMENTED_FRAME_IPHONE6PLUS = {304, 6, 90, 30};
const CGRect IMAGE_FRAME_IPHONE4_IPHONE5 = {209, 5, 91, 35};
const CGRect IMAGE_FRAME_IPHONE6 = {264, 5, 92, 35};
const CGRect IMAGE_FRAME_IPHONE6PLUS = {303, 5, 92, 35};

@interface SectionViewController ()

-(IBAction)showKeybourd;

@end

@implementation SectionViewController
{
    NSArray *inputLabels;
    NSArray *outputLabels;
    NSArray *pickerArray;
    NSArray *answerCuArray;
    NSArray *answerAlArray;
    NSArray *aArray;
    NSArray *data_Al_220_A;
    NSArray *data_Al_220_kBt;
    NSArray *data_Al_380_A;
    NSArray *data_Al_380_kBt;
    NSArray *data_Cu_220_A;
    NSArray *data_Cu_220_kBt;
    NSArray *data_Cu_380_A;
    NSArray *data_Cu_380_kBt;
    
    NSDictionary *all_Answers;

    //UIButton *doneButton;
    //UILabel *doneLabel;
    CGFloat screenHeight;
    
    BOOL isAl;
    BOOL is220;
    BOOL isA;
    BOOL isPickerShow;
}

@synthesize backgroundImageView;
@synthesize inputTable;
@synthesize outputTable;
@synthesize enterValuePickerView;
@synthesize enterValueView;
@synthesize infoView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    inputLabels = [NSArray arrayWithObjects:@"Материал жилы", @"Напряжение", @"Сила тока/мощность", @"Укажите силу тока:",  nil];
    outputLabels = [NSArray arrayWithObjects:@"Рекомендуемое сеч., мм²", @"Номинал автомата", nil];
    answerAlArray = [NSArray arrayWithObjects:@"2.5", @"4", @"6", @"10", @"16", @"25", @"35", @"50", @"70", @"95", @"120", nil];
    answerCuArray = [NSArray arrayWithObjects:@"1.5", @"2.5", @"4", @"6", @"10", @"16", @"25", @"35", @"50", @"70", @"95", @"120", nil];
    aArray = [NSArray arrayWithObjects:@"1", @"6", @"10", @"16", @"20", @"25", @"32", @"40", @"50", @"63", @"80", @"100", @"125", nil];
    
    data_Al_220_A = [NSArray arrayWithObjects:@"до 20 А", @"до 25 А", @"до 32 А", @"до 40 А", @"до 50 А", @"до 63 А", @"до 80 А", @"до 100 А", @"до 125 А", @"до 160 А", @"до 200 А", nil];
    data_Al_220_kBt = [NSArray arrayWithObjects:@"до 4.4 кВт", @"до 5.5 кВт", @"до 7.0 кВт", @"до 8.8 кВт", @"до 11.0 кВт", @"до 13.8 кВт", @"до 17.5 кВт", @"до 22.0 кВт", @"до 27.5 кВт", @"до 35.0 кВт", @"до 44.0 кВт", nil];
    data_Al_380_A = [NSArray arrayWithObjects:@"до 16 А", @"до 20 А", @"до 25 А", @"до 32 А", @"до 40 А", @"до 50 А", @"до 63 А", @"до 80 А", @"до 100 А", @"до 125 А", @"до 160 А", nil];
    data_Al_380_kBt = [NSArray arrayWithObjects:@"до 6.0 кВт", @"до 7.6 кВт", @"до 9.5 кВт", @"до 12.0 кВт", @"до 15.0 кВт", @"до 19.0 кВт", @"до 23.9 кВт", @"до 30.0 кВт", @"до 38.0 кВт", @"до 47.5 кВт", @"до 60.5 кВт", nil];
    data_Cu_220_A = [NSArray arrayWithObjects:@"до 10 А", @"до 16 А", @"до 20 А", @"до 25 А", @"до 32 А", @"до 40 А", @"до 50 А", @"до 63 А", @"до 80 А", @"до 100 А", @"до 125 А", @"до 160 А", nil];
    data_Cu_220_kBt = [NSArray arrayWithObjects:@"до 3.5 кВт", @"до 4.4 кВт", @"до 5.5 кВт", @"до 7.0 кВт", @"до 8.8 кВт", @"до 11.0 кВт", @"до 13.8 кВт", @"до 17.5 кВт", @"до 22.0 кВт", @"до 27.5 кВт", @"до 35.0 кВт", @"до 60.5 кВт", nil];
    data_Cu_380_A = [NSArray arrayWithObjects:@"до 16 А", @"до 20 А", @"до 25 А", @"до 32 А", @"до 40 А", @"до 50 А", @"до 63 А", @"до 80 А", @"до 100 А", @"до 125 А", @"до 160 А", @"до 200 А", nil];
    data_Cu_380_kBt = [NSArray arrayWithObjects:@"до 6.0 кВт", @"до 7.6 кВт", @"до 9.5 кВт", @"до 12.0 кВт", @"до 15.0 кВт", @"до 19.0 кВт", @"до 23.9 кВт", @"до 30.0 кВт", @"до 38.0 кВт", @"до 47.5 кВт", @"до 60.5 кВт", @"до 76.0 кВт", nil];
    pickerArray = data_Al_220_A;
    
    all_Answers = @{
                    @"data_Al_220_A_Sechenie": @[@"2.5", @"4", @"6", @"10", @"16", @"25", @"25", @"35", @"50", @"70", @"120"],
                    @"data_Al_220_A_Nominal":  @[@"20", @"25", @"32", @"40", @"50", @"63", @"80", @"100", @"125", @"160", @"200"],
                    
                    @"data_Al_220_kBt_Sechenie": @[@"2.5", @"4", @"6", @"10", @"16", @"25", @"25", @"35", @"50", @"70", @"120"],
                    @"data_Al_220_kBt_Nominal":  @[@"20", @"25", @"32", @"40", @"50", @"63", @"80", @"100", @"125", @"160", @"200"],
                    
                    @"data_Al_380_A_Sechenie": @[@"2.5", @"4", @"6", @"10", @"16", @"16", @"25", @"35", @"50", @"70", @"120"],
                    @"data_Al_380_A_Nominal":  @[@"16", @"20", @"25", @"32", @"40", @"50", @"63", @"80", @"100", @"125", @"160"],
                    
                    @"data_Al_380_kBt_Sechenie": @[@"2.5", @"2.5", @"2.5", @"2.5", @"4", @"6", @"10", @"16", @"25", @"35", @"50"],
                    @"data_Al_380_kBt_Nominal":  @[@"16", @"20", @"25", @"32", @"40", @"50", @"63", @"80", @"100", @"125", @"160"],
                    
                    @"data_Cu_220_A_Sechenie": @[@"1.5", @"1.5", @"2.5", @"2.5", @"4", @"6", @"10", @"10", @"16", @"25", @"30", @"50"],
                    @"data_Cu_220_A_Nominal":  @[@"10", @"16", @"20", @"25", @"32", @"40", @"50", @"63", @"80", @"100", @"125", @"160"],
                    
                    @"data_Cu_220_kBt_Sechenie": @[@"1.5", @"2.5", @"2.5", @"4", @"6", @"10", @"10", @"16", @"25", @"30", @"50", @"70"],
                    @"data_Cu_220_kBt_Nominal":  @[@"16", @"20", @"25", @"32", @"40", @"50", @"63", @"80", @"100", @"125", @"160", @"200"],
                    
                    @"data_Cu_380_A_Sechenie": @[@"1.5", @"2.5", @"4", @"6", @"10", @"16", @"16", @"25", @"35", @"50", @"70", @"95"],
                    @"data_Cu_380_A_Nominal":  @[@"16", @"20", @"25", @"32", @"40", @"50", @"63", @"80", @"100", @"125", @"160", @"200"],
                    
                    @"data_Cu_380_kBt_Sechenie": @[@"1.5", @"1.5", @"1.5", @"2.5", @"2.5", @"4", @"6", @"10", @"16", @"25", @"35", @"50"],
                    @"data_Cu_380_kBt_Nominal":  @[@"16", @"20", @"25", @"32", @"40", @"50", @"63", @"80", @"100", @"125", @"160", @"200"]
                    
                    };
    
    isAl = true;
    is220 = true;
    isA = true;
    isPickerShow = false;

    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    backgroundImageView.image = [UIImage imageNamed:@"backgraund.png"];
    [self SetCorrectSizeForComponent];
    
    // Выставляем прозрачность таблицам
    inputTable.opaque = NO;
    inputTable.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    outputTable.opaque = NO;
    outputTable.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    
    // Запрещаем скролл
    inputTable.scrollEnabled = NO;
    outputTable.scrollEnabled = NO;
    
    enterValuePickerView.delegate = self;
    enterValuePickerView.dataSource = self;
    
    self.navigationItem.title = @"Калькулятор подбора сечения";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerArray.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerArray[row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == inputTable)
        return [inputLabels count];
    else return [outputLabels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    // inputTable
    if (tableView == inputTable) {
    
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Добовляем segmented control
        if (indexPath.row == 0) {
            
            [cell addSubview:[self InitSegmentedControlWithTag:1001]];
            [cell addSubview:[self InitImageView:[UIImage imageNamed:@"AlCuSwitch_l@3x"] WithSelector:@selector(AlCuDetected:)]];
        
        } else if (indexPath.row == 1) {
            
            [cell addSubview:[self InitSegmentedControlWithTag:1002]];
            [cell addSubview:[self InitImageView:[UIImage imageNamed:@"220Switch_l@3x"] WithSelector:@selector(Detected220:)]];
            
        } else if (indexPath.row == 2) {
        
            [cell addSubview:[self InitSegmentedControlWithTag:1003]];
            [cell addSubview:[self InitImageView:[UIImage imageNamed:@"ABtSwitch_l@3x"] WithSelector:@selector(ABtDetected:)]];
        }
       
        // Делаем ячейки прозрачными
        cell.opaque = NO;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    
        // Записываем данные
        cell.textLabel.text = [inputLabels objectAtIndex:indexPath.row];
        
        if (indexPath.row == 3)
            cell.textColor = [UIColor grayColor];
    }
    
    // outputTable
    if (tableView == outputTable) {
        
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Добовляем label
        if (indexPath.row == 0) {
            
            if (screenHeight == 667)
                [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(330.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:1]];
            else if (screenHeight == 736)
                [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(369.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:1]];
            else [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(275.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:1]];
        }
        
        if (indexPath.row == 1) {
            
            if (screenHeight == 667)
                [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(330.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:2]];
            else if (screenHeight == 736)
                [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(369.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:2]];
            else [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(275.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:2]];
        }
        
        // Делаем яцейки прозрачными
        cell.opaque = YES;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        
        // Записываем данные
        cell.textLabel.text = [outputLabels objectAtIndex:indexPath.row];
    }
    
    return cell;
}

// Tap on table Row
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    if (indexPath.row == 3) {
        
        if (!isPickerShow) {
            
            outputTable.frame = CGRectMake(0, 1000, outputTable.bounds.size.width, outputTable.bounds.size.height);
            enterValueView.frame = CGRectMake(0, 307, enterValueView.bounds.size.width, enterValueView.bounds.size.height);
            
            UITableViewCell *cell = [inputTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
            UILabel *label = (UILabel*)[cell.contentView viewWithTag:1000];
            [label removeFromSuperview];
        
            UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [doneButton addTarget:self action:@selector(Calculate) forControlEvents:UIControlEventTouchUpInside];
            [doneButton setTitle:@"Готово" forState:UIControlStateNormal];
            doneButton.tag = 999;
            doneButton.frame = CGRectMake(215.0, 5.0, 90.0, 35.0);
        
            if (screenHeight == 667)
                doneButton.frame = CGRectMake(270.0, 5.0, 90.0, 35.0);
            else if (screenHeight == 736)
                doneButton.frame = CGRectMake(309.0, 5.0, 90.0, 35.0);
        
            [cell.contentView addSubview:doneButton];
            
            isPickerShow = true;
        }
    }
}

- (void)Calculate
{
    outputTable.frame = CGRectMake(0, 307, outputTable.bounds.size.width, outputTable.bounds.size.height);
    enterValueView.frame = CGRectMake(0, 1000, enterValueView.bounds.size.width, enterValueView.bounds.size.height);
    isPickerShow = false;
    
    UITableViewCell *cell = [inputTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    if (isA)
        cell.textLabel.text = @"Сила тока";
    else cell.textLabel.text = @"Мощность";
    
    UIButton *button = (UIButton*)[cell.contentView viewWithTag:999];
    [button removeFromSuperview];
    
    UILabel *doneLabel = [self createLabelWithFrameAndText:CGRectMake(215.0f, 5.0f, 110.0f, 35.0f) Text:[pickerArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:1000];
    
    if (screenHeight == 667)
        doneLabel = [self createLabelWithFrameAndText:CGRectMake(270.0f, 5.0f, 110.0f, 35.0f) Text:[pickerArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:1000];

    else if (screenHeight == 736)
        doneLabel = [self createLabelWithFrameAndText:CGRectMake(309.0f, 5.0f, 110.0f, 35.0f) Text:[pickerArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:1000];
    
    [cell.contentView addSubview:doneLabel];
    
    cell = [outputTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell.contentView viewWithTag:1] removeFromSuperview];
    
    /*
    if (isAl) {
    
        if (screenHeight == 667)
            [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(330.0f, 3.5f, 100.0f, 35.0f) Text:[answerAlArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:1]];

        else if (screenHeight == 736)
            [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(369.0f, 3.5f, 100.0f, 35.0f) Text:[answerAlArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:1]];
        
        else [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(275.0f, 3.5f, 100.0f, 35.0f) Text:[answerAlArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:1]];
    }
    
    else {
        
        if (screenHeight == 667)
            [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(330.0f, 3.5f, 100.0f, 35.0f) Text:[answerCuArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:1]];
        
        else if (screenHeight == 736)
            [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(369.0f, 3.5f, 100.0f, 35.0f) Text:[answerCuArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:1]];

        else [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(275.0f, 3.5f, 100.0f, 35.0f) Text:[answerCuArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:1]];
    }
    */

    //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
    NSArray *answer_Sechenie_Array = nil;
    NSArray *answer_Nominal_Array = nil;
    if (isAl && is220 && isA)
    {
        answer_Sechenie_Array = [all_Answers objectForKey:@"data_Al_220_A_Sechenie"];
        answer_Nominal_Array =  [all_Answers objectForKey:@"data_Al_220_A_Nominal"];
    }
    else if (isAl && is220 && !isA)
    {
        answer_Sechenie_Array = [all_Answers objectForKey:@"data_Al_220_kBt_Sechenie"];
        answer_Nominal_Array =  [all_Answers objectForKey:@"data_Al_220_kBt_Nominal"];
    }
    else if (isAl && !is220 && isA)
    {
        answer_Sechenie_Array = [all_Answers objectForKey:@"data_Al_380_A_Sechenie"];
        answer_Nominal_Array =  [all_Answers objectForKey:@"data_Al_380_A_Nominal"];
    }
    else if (isAl && !is220 && !isA)
    {
        answer_Sechenie_Array = [all_Answers objectForKey:@"data_Al_380_kBt_Sechenie"];
        answer_Nominal_Array =  [all_Answers objectForKey:@"data_Al_380_kBt_Nominal"];
    }
    else if (!isAl && is220 && isA)
    {
        answer_Sechenie_Array = [all_Answers objectForKey:@"data_Cu_220_A_Sechenie"];
        answer_Nominal_Array =  [all_Answers objectForKey:@"data_Cu_220_A_Nominal"];
    }
    else if (!isAl && is220 && !isA)
    {
        answer_Sechenie_Array = [all_Answers objectForKey:@"data_Cu_220_kBt_Sechenie"];
        answer_Nominal_Array =  [all_Answers objectForKey:@"data_Cu_220_kBt_Nominal"];
    }
    else if (!isAl && !is220 && isA)
    {
        answer_Sechenie_Array = [all_Answers objectForKey:@"data_Cu_380_A_Sechenie"];
        answer_Nominal_Array =  [all_Answers objectForKey:@"data_Cu_380_A_Nominal"];
    }
    else if (!isAl && !is220 && !isA)
    {
        answer_Sechenie_Array = [all_Answers objectForKey:@"data_Cu_380_kBt_Sechenie"];
        answer_Nominal_Array =  [all_Answers objectForKey:@"data_Cu_380_kBt_Nominal"];
    }
    
    if (screenHeight == 667)
        [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(330.0f, 3.5f, 100.0f, 35.0f) Text:[answer_Sechenie_Array objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:1]];
    
    else if (screenHeight == 736)
        [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(369.0f, 3.5f, 100.0f, 35.0f) Text:[answer_Sechenie_Array objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:1]];
    
    else [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(275.0f, 3.5f, 100.0f, 35.0f) Text:[answer_Sechenie_Array objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:1]];
    
    //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
    cell = [outputTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [[cell.contentView viewWithTag:2] removeFromSuperview];
    
    /*
    double A = 0;
    if (!isA && is220) {
        
        A = [self CorrectA:[pickerArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]]] / 0.22;
        
        if (A < 125) {
            for (int i = 0; i < [aArray count] - 1; i++)
            {
                if (A <= [[aArray objectAtIndex:i] doubleValue]) {
                    A = [[aArray objectAtIndex:i] doubleValue];
                    break;
                }
            }
        }
    }
    
    if (!isA && !is220) {
        
        A = [self CorrectA:[pickerArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]]] / 0.66;
        
        if (A < 125) {
            for (int i = 0; i < [aArray count] - 1; i++)
            {
                if (A <= [[aArray objectAtIndex:i] doubleValue]) {
                    A = [[aArray objectAtIndex:i] doubleValue];
                    break;
                }
            }
        }
    }
    
    if (isA) {
        
        A = [self CorrectA:[pickerArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]]];
        
        if (A < 125) {
            for (int i = 0; i < [aArray count] - 1; i++)
            {
                if (A <= [[aArray objectAtIndex:i] doubleValue]) {
                    A = [[aArray objectAtIndex:i] doubleValue];
                    break;
                }
            }
        }
    }


    if (A < 125) {
        
        if (screenHeight == 667)
            
            [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(330.0f, 3.5f, 100.0f, 35.0f) Text:[NSString stringWithFormat:@"%i", (int)A] Tag:2]];

        else if (screenHeight == 736)
            [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(369.0f, 3.5f, 100.0f, 35.0f) Text:[NSString stringWithFormat:@"%i", (int)A] Tag:2]];
        
        else [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(275.0f, 3.5f, 100.0f, 35.0f) Text:[NSString stringWithFormat:@"%i", (int)A] Tag:2]];

    }
    else {
        
        if (screenHeight == 667)
            [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(340.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:2]];
        
        else if (screenHeight == 736)
           [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(379.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:2]];
        
        else [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(285.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:2]];
    }
    */
    
    if (screenHeight == 667)
        [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(330.0f, 3.5f, 100.0f, 35.0f) Text:[answer_Nominal_Array objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:2]];
    
    else if (screenHeight == 736)
        [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(369.0f, 3.5f, 100.0f, 35.0f) Text:[answer_Nominal_Array objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:2]];
    
    else [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(275.0f, 3.5f, 100.0f, 35.0f) Text:[answer_Nominal_Array objectAtIndex:[enterValuePickerView selectedRowInComponent:0]] Tag:2]];
}

- (double)CorrectA:(NSString*)_input {

    NSRange preffix;
    NSString *answer;
    
    if (isA) {
        
        preffix = [_input rangeOfString:@"А"];
        answer = [_input substringWithRange:NSMakeRange(3, preffix.location - 3)];
        return [answer doubleValue];
    
    } else {
        
        preffix = [_input rangeOfString:@"кВт"];
        answer = [_input substringWithRange:NSMakeRange(3, preffix.location - 3)];
        return [answer doubleValue];
    }
}

- (UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

- (UISegmentedControl*)InitSegmentedControlWithTag:(int)_tag {
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", @"", nil]];
    segmentedControl.frame = SEGMENTED_FRAME_IPHONE4_IPHONE5;
    
    if (screenHeight == 667)
        segmentedControl.frame = SEGMENTED_FRAME_IPHONE6;
    else if (screenHeight == 736)
        segmentedControl.frame = SEGMENTED_FRAME_IPHONE6PLUS;
    
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [self colorWithHexString:@"5294c3"];
    segmentedControl.tag = _tag;
    
    return segmentedControl;
}

- (UIImageView*)InitImageView:(UIImage*)_image WithSelector:(SEL)_selector {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:IMAGE_FRAME_IPHONE4_IPHONE5];
    
    if (screenHeight == 667)
        imageView.frame = IMAGE_FRAME_IPHONE6;
    else if (screenHeight == 736)
        imageView.frame = IMAGE_FRAME_IPHONE6PLUS;
    
    imageView.image = _image;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:_selector];     singleTap.numberOfTapsRequired = 1;
    [imageView setUserInteractionEnabled:YES];
    [imageView addGestureRecognizer:singleTap];
    
    return imageView;
}

- (void)ClearResults {
    
    UITableViewCell *out_cell_0 = [outputTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell *out_cell_1 = [outputTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell *in_cell_3 = [inputTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    UILabel *label = (UILabel*)[in_cell_3 viewWithTag:1000];
    UILabel *label2 = (UILabel*)[out_cell_0 viewWithTag:1];
    UILabel *label3 = (UILabel*)[out_cell_1 viewWithTag:2];
    
    [label removeFromSuperview];
    [label2 removeFromSuperview];
    [label3 removeFromSuperview];
    
    if (screenHeight == 667) {
        
        [out_cell_0.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(330.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:1]];
        [out_cell_1.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(330.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:2]];
    }
    else if (screenHeight == 736) {
        
        [out_cell_0.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(369.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:1]];
        [out_cell_1.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(369.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:2]];
    }
    else {
        
        [out_cell_0.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(275.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:1]];
        [out_cell_1.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(275.0f, 3.5f, 100.0f, 35.0f) Text:@"-" Tag:2]];
    }
}

- (void)AlCuDetected:(UITapGestureRecognizer*)sender {
    
    UITableViewCell *cell = [inputTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UISegmentedControl *segment = (UISegmentedControl*)[cell viewWithTag:1001];
    UIImageView *AlCuImageView = (UIImageView*)sender.view;
    
    if (isAl) {
        
        AlCuImageView.image = [UIImage imageNamed:@"AlCuSwitch_r@3x.png"];
        isAl = false;
        [segment setSelectedSegmentIndex:1];
        
        [self ReloadPickerView];
        [self ClearResults];
    
    } else {
        
        AlCuImageView.image = [UIImage imageNamed:@"AlCuSwitch_l@3x.png"];
        isAl = true;
        [segment setSelectedSegmentIndex:0];
        
        [self ReloadPickerView];
        [self ClearResults];
    }
}

- (void)Detected220:(UITapGestureRecognizer*)sender {
    
    UITableViewCell *cell = [inputTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UISegmentedControl *segment = (UISegmentedControl*)[cell viewWithTag:1002];
    UIImageView *imageView220 = (UIImageView*)sender.view;
    
    if (is220) {
        
        imageView220.image = [UIImage imageNamed:@"220Switch_r@3x.png"];
        is220 = false;
        [segment setSelectedSegmentIndex:1];
        
        [self ReloadPickerView];
        [self ClearResults];
        
    } else {
        
        imageView220.image = [UIImage imageNamed:@"220Switch_l@3x.png"];
        is220 = true;
        [segment setSelectedSegmentIndex:0];
        
        [self ReloadPickerView];
        [self ClearResults];
    }
}

- (void)ABtDetected:(UITapGestureRecognizer*)sender {
    
    UITableViewCell *in_cell_2 = [inputTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UISegmentedControl *segment = (UISegmentedControl*)[in_cell_2 viewWithTag:1003];
    
    UITableViewCell *in_cell_3 = [inputTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    UIImageView *ABtImageView = (UIImageView*)sender.view;
    
    if (isA) {
        
        ABtImageView.image = [UIImage imageNamed:@"ABtSwitch_r@3x.png"];
        isA = false;
        [segment setSelectedSegmentIndex:1];
        in_cell_3.textLabel.text = @"Укажите мощность:";
        
        [self ReloadPickerView];
        [self ClearResults];
        
    } else {
        
        ABtImageView.image = [UIImage imageNamed:@"ABtSwitch_l@3x.png"];
        isA = true;
        [segment setSelectedSegmentIndex:0];
        in_cell_3.textLabel.text = @"Укажите силу тока:";
        
        [self ReloadPickerView];
        [self ClearResults];
    }
}

- (void)ReloadPickerView {
    
    if (isAl && is220 && isA)
        pickerArray = data_Al_220_A;
    else if (isAl && is220 && !isA)
        pickerArray = data_Al_220_kBt;
    else if (isAl && !is220 && isA)
        pickerArray = data_Al_380_A;
    else if (isAl && !is220 && !isA)
        pickerArray = data_Al_380_kBt;
    else if (!isAl && is220 && isA)
        pickerArray = data_Cu_220_A;
    else if (!isAl && is220 && !isA)
        pickerArray = data_Cu_220_kBt;
    else if (!isAl && !is220 && isA)
        pickerArray = data_Cu_380_A;
    else if (!isAl && !is220 && !isA)
        pickerArray = data_Cu_380_kBt;
    
    [enterValuePickerView reloadAllComponents];
}

- (UILabel*)createLabelWithFrameAndText:(CGRect)frame Text:(NSString*)text Tag:(NSInteger)tag {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont fontWithName:@"Arial" size:18];
    label.textColor = [self colorWithHexString:@"5294c3"];
    label.text = text;
    label.tag = tag;

    return label;
}

- (void)SetCorrectSizeForComponent {
    
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = YES;
    inputTable.translatesAutoresizingMaskIntoConstraints = YES;
    outputTable.translatesAutoresizingMaskIntoConstraints = YES;
    enterValuePickerView.translatesAutoresizingMaskIntoConstraints = YES;
    enterValueView.translatesAutoresizingMaskIntoConstraints = YES;
    infoView.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect correctBackgroundFrame;
    CGRect correctInputTableFrame;
    CGRect correctOutputTableFrame;
    CGRect correctPickerFrame;
    CGRect correctViewFrame;
    CGRect correctInfoView;
    
    if (scrHeight == 480)
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 320.0f, 367.0f);
    else if (scrHeight == 568)
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 320.0f, 454.0f);
    
    else if (scrHeight == 667) {
        
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 375.0f, 553.0f);
        correctInputTableFrame = CGRectMake(inputTable.frame.origin.x, inputTable.frame.origin.y, 375, inputTable.frame.size.height);
        correctOutputTableFrame = CGRectMake(outputTable.frame.origin.x, outputTable.frame.origin.y, 375, outputTable.frame.size.height);
        correctPickerFrame = CGRectMake(enterValuePickerView.frame.origin.x, enterValuePickerView.frame.origin.y, 375, enterValuePickerView.frame.size.height);
        correctViewFrame = CGRectMake(enterValueView.frame.origin.x, enterValueView.frame.origin.y, 375, enterValueView.frame.size.height);
        correctInfoView = CGRectMake(infoView.frame.origin.x, infoView.frame.origin.y, 375, infoView.frame.size.height);
        
        inputTable.frame = correctInputTableFrame;
        outputTable.frame = correctOutputTableFrame;
        enterValuePickerView.frame = correctPickerFrame;
        enterValueView.frame = correctViewFrame;
        infoView.frame = correctInfoView;
    
    } else {
        
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 414.0f, 623.0f);
        correctInputTableFrame = CGRectMake(inputTable.frame.origin.x, inputTable.frame.origin.y, 414, inputTable.frame.size.height);
        correctOutputTableFrame = CGRectMake(outputTable.frame.origin.x, outputTable.frame.origin.y, 414, outputTable.frame.size.height);
        correctPickerFrame = CGRectMake(enterValuePickerView.frame.origin.x, enterValuePickerView.frame.origin.y, 414, enterValuePickerView.frame.size.height);
        correctViewFrame = CGRectMake(enterValueView.frame.origin.x, enterValueView.frame.origin.y, 414, enterValueView.frame.size.height);
        correctInfoView = CGRectMake(infoView.frame.origin.x, infoView.frame.origin.y, 414, infoView.frame.size.height);

        inputTable.frame = correctInputTableFrame;
        outputTable.frame = correctOutputTableFrame;
        enterValuePickerView.frame = correctPickerFrame;
        enterValueView.frame = correctViewFrame;
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
