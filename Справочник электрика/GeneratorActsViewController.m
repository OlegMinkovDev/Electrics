//
//  GeneratorActsViewController.m
//  Электрика
//
//  Created by Admin on 31.08.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "GeneratorActsViewController.h"

#define CELL_HEIGHT ((int) 44)

@interface GeneratorActsViewController ()
{
    NSArray *typeArray;
    NSArray *viewArray;
    NSArray *docArray;
    NSArray *pickerArray;
    NSDictionary *typeDataKeys;
    NSDictionary *viewDataKeys;
    NSDictionary *docDataKeys;
    
    int typeIndex;
    int viewIndex;
    int docIndex;
    
    AppDelegate *appDelegate;
    CGFloat screenHeight;
    BOOL isPickerShow;
    BOOL isReloadData;
    NSData *contentOfLocalFile;
    CGRect frame;
    int tableNumber;
    int linesCount;
}

@end

@implementation GeneratorActsViewController

@synthesize backgroundImageView;
@synthesize topInfoView;
@synthesize typeTableView;
@synthesize viewTableView;
@synthesize docTableView;
@synthesize enterValuePickerView;
@synthesize openButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    typeTableView.delegate = self;
    typeTableView.dataSource = self;
    viewTableView.delegate = self;
    viewTableView.dataSource = self;
    docTableView.delegate = self;
    docTableView.dataSource = self;
    enterValuePickerView.delegate = self;
    enterValuePickerView.dataSource = self;
    
    typeTableView.opaque = NO;
    typeTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    typeTableView.scrollEnabled = NO;
    viewTableView.opaque = NO;
    viewTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    viewTableView.scrollEnabled = NO;
    docTableView.opaque = NO;
    docTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    docTableView.scrollEnabled = NO;
    
    typeArray = [NSArray arrayWithObjects:@"Тип документа", nil];
    viewArray = [NSArray arrayWithObjects:@"Вид документа", nil];
    docArray = [NSArray arrayWithObjects:@"Документ", nil];
    
    typeIndex = 0;
    viewIndex = 0;
    docIndex = 0;
    tableNumber = 0;
    linesCount = 1;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    [openButton setHidden:YES];
    openButton.backgroundColor = [appDelegate colorWithHexString:@"5294c3"];
    
    isPickerShow = false;
    isReloadData = false;
    enterValuePickerView.translatesAutoresizingMaskIntoConstraints = YES;
    
    self.navigationItem.title = @"Документы";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSString *pathStringToLocalFile = [[NSBundle mainBundle] pathForResource:@"document" ofType:@"json"];
    NSURL *localFileURL = [NSURL fileURLWithPath:pathStringToLocalFile];
    contentOfLocalFile = [NSData dataWithContentsOfURL:localFileURL];
    
    [self SetCorrectSizeForComponent];
}

- (NSDictionary *)parseDocumentJSON:(NSString *)key1 key2:(NSString *)key2 {
 
    NSDictionary *documentArray = [NSJSONSerialization JSONObjectWithData:contentOfLocalFile options:kNilOptions error:nil];

    if (key1 != nil) {
     
        NSDictionary *subArray = [documentArray objectForKey:key1];
        
        if (key2 != nil) {
        
            NSDictionary *subSubArray = [subArray objectForKey:key2];
    
            return subSubArray;
        }
        
        else return subArray;
    }
    
    else return documentArray;
}

#pragma mark - UITableView Delegat Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier1 = @"Cell1";
    static NSString *cellIdentifier2 = @"Cell2";
    static NSString *cellIdentifier3 = @"Cell3";
    UITableViewCell *cell;
    
    if (screenHeight == 667)
        frame = CGRectMake(300.0f, 5, 100.0f, 35.0f);
    else if (screenHeight == 736)
        frame = CGRectMake(339.0f, 5, 100.0f, 35.0f);
    else frame = CGRectMake(245.0f, 5, 100.0f, 35.0f);

    if (tableView == typeTableView) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        // Добовляем label
        [cell.contentView addSubview:[self createLabelWithFrameAndText:frame Text:@"Ввести" Tag:1]];
        
        // Делаем яцейки прозрачными
        cell.opaque = NO;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    
        // Записываем данные
        cell.textLabel.text = [typeArray objectAtIndex:indexPath.row];
    }
    
    if (tableView == viewTableView) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Добовляем label
        if (!isReloadData)
            [cell.contentView addSubview:[self createLabelWithFrameAndText:frame Text:@"Ввести" Tag:2]];
        
        // Делаем яцейки прозрачными
        cell.opaque = NO;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        
        // Записываем данные
        cell.textLabel.text = [viewArray objectAtIndex:indexPath.row];
    }

    if (tableView == docTableView) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Добовляем label
        if (!isReloadData)
            [cell.contentView addSubview:[self createLabelWithFrameAndText:frame Text:@"Ввести" Tag:3]];
        
        // Делаем яцейки прозрачными
        cell.opaque = NO;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        
        // Записываем данные
        cell.textLabel.text = [docArray objectAtIndex:indexPath.row];
    }

    return cell;
}

// Tap on table Row
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    if (tableView == typeTableView) {
        
        tableNumber = 1;
        
        enterValuePickerView.delegate = self;
        enterValuePickerView.dataSource = self;
        
        docTableView.frame = CGRectMake(docTableView.frame.origin.x, docTableView.frame.origin.y, docTableView.frame.size.width, CELL_HEIGHT);
        
        isReloadData = true;
        [docTableView reloadData];
        
        if (!isPickerShow) {
            
            [openButton setHidden:YES];
            
            UITableViewCell *cell2 = [viewTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[cell2.contentView viewWithTag:2] removeFromSuperview];
            [cell2.contentView addSubview:[self createLabelWithFrameAndText:frame Text:@"Ввести" Tag:2]];
            
            UITableViewCell *cell3 = [docTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[cell3.contentView viewWithTag:3] removeFromSuperview];
            [cell3.contentView addSubview:[self createLabelWithFrameAndText:frame Text:@"Ввести" Tag:3]];
            
            typeDataKeys = [self parseDocumentJSON:nil key2:nil];
            pickerArray = [typeDataKeys allKeys];
            
            [enterValuePickerView reloadAllComponents];
            
            // show picker view
            enterValuePickerView.frame = CGRectMake(enterValuePickerView.frame.origin.x, 188, enterValuePickerView.frame.size.width, enterValuePickerView.frame.size.height);
            viewTableView.frame = CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y + 162, viewTableView.frame.size.width, viewTableView.frame.size.height);
            docTableView.frame = CGRectMake(docTableView.frame.origin.x, docTableView.frame.origin.y + 162, docTableView.frame.size.width, docTableView.frame.size.height);
            
            isPickerShow = true;
            
            // delete label
            UITableViewCell *cell = [typeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[cell.contentView viewWithTag:1] removeFromSuperview];
            
            // add button
            UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [doneButton addTarget:self
                           action:@selector(typeDone)
                 forControlEvents:UIControlEventTouchUpInside];
            [doneButton setTitle:@"Готово" forState:UIControlStateNormal];
            
            if (screenHeight == 667)
                doneButton.frame = CGRectMake(285.0f, 5.0f, 90.0f, 35.0f);
            else if (screenHeight == 736)
                doneButton.frame = CGRectMake(324.0f, 5.0f, 90.0f, 35.0f);
            else doneButton.frame = CGRectMake(230.0f, 5.0f, 90.0f, 35.0f);
            
            doneButton.tag = 1;
            [cell.contentView addSubview:doneButton];
        }
    } //typeTableView

    if (tableView == viewTableView) {
        
        tableNumber = 2;
        
        enterValuePickerView.delegate = self;
        enterValuePickerView.dataSource = self;
        
        docTableView.frame = CGRectMake(docTableView.frame.origin.x, docTableView.frame.origin.y, docTableView.frame.size.width, CELL_HEIGHT);
        
        isReloadData = true;
        [docTableView reloadData];
        
        [openButton setHidden:YES];
        
        UITableViewCell *cell1 = [typeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        UILabel *label1 = (UILabel*)[cell1.contentView viewWithTag:1];
        
        UITableViewCell *cell3 = [docTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [[cell3.contentView viewWithTag:3] removeFromSuperview];
        [cell3.contentView addSubview:[self createLabelWithFrameAndText:frame Text:@"Ввести" Tag:3]];
        
        if (!isPickerShow && (![label1.text isEqualToString:@""] && ![label1.text isEqualToString:@"Ввести"])) {
            
            UITableViewCell *cell1 = [typeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            UILabel *label1 = (UILabel*)[cell1.contentView viewWithTag:1];
            
            viewDataKeys = [self parseDocumentJSON:label1.text key2:nil];
            pickerArray = [viewDataKeys allKeys];
            
            //[enterValuePickerView selectRow:0 inComponent:0 animated:YES];
            [enterValuePickerView reloadAllComponents];
                
            // show picker view
            enterValuePickerView.frame = CGRectMake(enterValuePickerView.frame.origin.x, 232, enterValuePickerView.frame.size.width, enterValuePickerView.frame.size.height);
            docTableView.frame = CGRectMake(docTableView.frame.origin.x, docTableView.frame.origin.y + 162, docTableView.frame.size.width, docTableView.frame.size.height);
                
            isPickerShow = true;
                
            // delete label
            UITableViewCell *cell = [viewTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[cell.contentView viewWithTag:2] removeFromSuperview];
                
            // add button
            UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [doneButton addTarget:self
                         action:@selector(viewDone)
                forControlEvents:UIControlEventTouchUpInside];
            [doneButton setTitle:@"Готово" forState:UIControlStateNormal];
                
            if (screenHeight == 667)
                doneButton.frame = CGRectMake(285.0f, 5.0f, 90.0f, 35.0f);
            else if (screenHeight == 736)
                doneButton.frame = CGRectMake(324.0f, 5.0f, 90.0f, 35.0f);
            else doneButton.frame = CGRectMake(230.0f, 5.0f, 90.0f, 35.0f);
                
            doneButton.tag = 2;
            [cell.contentView addSubview:doneButton];
        }
    } //viewTableView
    
    if (tableView == docTableView) {
        
        tableNumber = 3;
        
        enterValuePickerView.delegate = self;
        enterValuePickerView.dataSource = self;
        
        [openButton setHidden:YES];
        
        UITableViewCell *cell2 = [viewTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        UILabel *label2 = (UILabel*)[cell2.contentView viewWithTag:2];
                
        if (!isPickerShow && (![label2.text isEqualToString:@""] && ![label2.text isEqualToString:@"Ввести"])) {
            
            UITableViewCell *cell1 = [typeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            UILabel *label1 = (UILabel*)[cell1.contentView viewWithTag:1];
            
            UITableViewCell *cell2 = [viewTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            UILabel *label2 = (UILabel*)[cell2.contentView viewWithTag:2];
            
            docDataKeys = [self parseDocumentJSON:label1.text key2:label2.text];
            pickerArray = [docDataKeys allKeys];
            
            //[enterValuePickerView selectRow:docIndex inComponent:0 animated:YES];
            [enterValuePickerView reloadAllComponents];
                    
            // show picker view
            enterValuePickerView.frame = CGRectMake(enterValuePickerView.frame.origin.x, 276, enterValuePickerView.frame.size.width, enterValuePickerView.frame.size.height);
                    
            isPickerShow = true;
                    
            // delete label
            UITableViewCell *cell = [docTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[cell.contentView viewWithTag:3] removeFromSuperview];
                    
            // add button
            UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [doneButton addTarget:self
                            action:@selector(docDone)
                    forControlEvents:UIControlEventTouchUpInside];
            [doneButton setTitle:@"Готово" forState:UIControlStateNormal];
                    
            if (screenHeight == 667)
                doneButton.frame = CGRectMake(285.0f, 5.0f, 90.0f, 35.0f);
            else if (screenHeight == 736)
                doneButton.frame = CGRectMake(324.0f, 5.0f, 90.0f, 35.0f);
            else doneButton.frame = CGRectMake(230.0f, 5.0f, 90.0f, 35.0f);
                    
            doneButton.tag = 3;
            [cell.contentView addSubview:doneButton];
        }
    } //docTableView
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == docTableView) {
     
        if ((tableNumber == 2 || tableNumber == 1) && tableView == docTableView)
            return CELL_HEIGHT;
        
        if (linesCount >= 3) {
            
            int cellHeight = linesCount / 3;
            return ++cellHeight * CELL_HEIGHT;
        }
    }
    
    return CELL_HEIGHT;
}

#pragma mark - DONE Buttons

- (void)typeDone {
    
    // add label
    UILabel *label;
    label.translatesAutoresizingMaskIntoConstraints = YES;
    
    if (screenHeight == 667)
        label = [[UILabel alloc] initWithFrame:CGRectMake(195.0f, 5.0f, 175.0f, 35.0f)];
    else if (screenHeight == 736)
        label = [[UILabel alloc] initWithFrame:CGRectMake(195.0f, 5.0f, 175.0f, 35.0f)];
    else label = [[UILabel alloc] initWithFrame:CGRectMake(140.0f, 5.0f, 175.0f, 35.0f)];
    
    typeIndex = (int)[self.enterValuePickerView selectedRowInComponent:0];
    
    NSInteger row;
    row = [enterValuePickerView selectedRowInComponent:0];
    
    label.font = [UIFont fontWithName:@"Arial" size:14];
    label.textColor = [appDelegate colorWithHexString:@"5294c3"];
    label.text = [pickerArray objectAtIndex:row];
    label.tag = 1;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    
    UITableViewCell *cell = [typeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell.contentView viewWithTag:1] removeFromSuperview];
    [cell.contentView addSubview:label];
    cell.selected = NO;
    
    // hide picker view
    enterValuePickerView.frame = CGRectMake(enterValuePickerView.frame.origin.x, 5000, enterValuePickerView.frame.size.width, enterValuePickerView.frame.size.height);
    viewTableView.frame = CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y - 162, viewTableView.frame.size.width, viewTableView.frame.size.height);
    docTableView.frame = CGRectMake(docTableView.frame.origin.x, docTableView.frame.origin.y - 162, docTableView.frame.size.width, docTableView.frame.size.height);
    
    isPickerShow = false;
    
    [self ShowButton];
}

- (void)viewDone {
    
    // add label
    UILabel *label;
    
    if (screenHeight == 667)
        label = [[UILabel alloc] initWithFrame:CGRectMake(195.0f, 5.0f, 170.0f, 35.0f)];
    else if (screenHeight == 736)
        label = [[UILabel alloc] initWithFrame:CGRectMake(195.0f, 5.0f, 170.0f, 35.0f)];
    else label = [[UILabel alloc] initWithFrame:CGRectMake(145.0f, 5.0f, 170.0f, 35.0f)];
    
    viewIndex = (int)[self.enterValuePickerView selectedRowInComponent:0];
    
    NSInteger row;
    row = [enterValuePickerView selectedRowInComponent:0];
    
    label.font = [UIFont fontWithName:@"Arial" size:14];
    label.textColor = [appDelegate colorWithHexString:@"5294c3"];
    label.text = [pickerArray objectAtIndex:row];
    label.tag = 2;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    
    UITableViewCell *cell = [viewTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell.contentView viewWithTag:2] removeFromSuperview];
    [cell.contentView addSubview:label];
    cell.selected = NO;
    
    // hide picker view
    enterValuePickerView.frame = CGRectMake(enterValuePickerView.frame.origin.x, 5000, enterValuePickerView.frame.size.width, enterValuePickerView.frame.size.height);
    docTableView.frame = CGRectMake(docTableView.frame.origin.x, docTableView.frame.origin.y - 162, docTableView.frame.size.width, docTableView.frame.size.height);
    
    isPickerShow = false;
    
    [self ShowButton];
}

- (void)docDone {
    
    // add label
    UILabel *label = [[UILabel alloc] init];
    
    docIndex = (int)[self.enterValuePickerView selectedRowInComponent:0];
    
    label.font = [UIFont fontWithName:@"Arial" size:14];
    label.textColor = [appDelegate colorWithHexString:@"5294c3"];
    label.text = [pickerArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]];
    label.tag= 3;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    
    linesCount = (int)round((unsigned long)label.text.length / 25.0f);
    if (linesCount == 0) linesCount++;
    
    if (screenHeight == 667)
        label.frame = CGRectMake(155.0f, 10.0f, 215.0f, linesCount * 18);
    else if (screenHeight == 736)
        label.frame = CGRectMake(155.0f, 10.0f, 215.0f, linesCount * 18);
    else label.frame = CGRectMake(100.0f, 10.0f, 215.0f, linesCount * 18);
    
    docTableView.frame = CGRectMake(docTableView.frame.origin.x, docTableView.frame.origin.y, docTableView.frame.size.width, CELL_HEIGHT + linesCount * 18);
    
    UITableViewCell *cell = [docTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell.contentView viewWithTag:3] removeFromSuperview];
    [cell.contentView addSubview:label];
    cell.selected = NO;
    
    // hide picker view
    enterValuePickerView.frame = CGRectMake(enterValuePickerView.frame.origin.x, 5000, enterValuePickerView.frame.size.width, enterValuePickerView.frame.size.height);
    
    isPickerShow = false;
    
    [self ShowButton];
    
    isReloadData = true;
    [docTableView reloadData];
}

#pragma mark - UIPickerView Delegat Methods

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerArray.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerArray[row];
}

 - (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
     if (tableNumber == 1 || tableNumber == 2)
         return 25;
     if (tableNumber == 3)
         return 85;
     
     return 25;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *pickerText = (id)view;
    if (!pickerText) {
        pickerText= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height + 50)];
    }
    
    pickerText.text = pickerArray[row];
    pickerText.textAlignment = NSTextAlignmentCenter;
    pickerText.font = [UIFont systemFontOfSize:16];
    
    pickerText.lineBreakMode = NSLineBreakByWordWrapping;
    pickerText.numberOfLines = 0;
    
    return pickerText;
}

- (UILabel*)createLabelWithFrameAndText:(CGRect)frame Text:(NSString*)text Tag:(NSInteger)tag {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont fontWithName:@"Arial" size:18];
    label.textColor = [UIColor lightGrayColor];
    label.text = text;
    label.tag = tag;
    
    return label;
}

- (void)ShowButton {
    
    // Получам все поля
    UITableViewCell *cell1 = [typeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UILabel *label1 = (UILabel*)[cell1.contentView viewWithTag:1];
    
    UITableViewCell *cell2 = [viewTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UILabel *label2 = (UILabel*)[cell2.contentView viewWithTag:2];
    
    UITableViewCell *cell3 = [docTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UILabel *label3 = (UILabel*)[cell3.contentView viewWithTag:3];
    
    // Проверяем все ли поля заполнены
    if ((![label1.text isEqualToString:@""] && ![label1.text isEqualToString:@"Ввести"]) &&
        (![label2.text isEqualToString:@""] && ![label2.text isEqualToString:@"Ввести"]) &&
        (![label3.text isEqualToString:@""] && ![label3.text isEqualToString:@"Ввести"])) {
        
        [openButton setHidden:NO];
    }
}

- (IBAction)OpenClick:(id)sender {

    UITableViewCell *cell1 = [typeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UILabel *label1 = (UILabel*)[cell1.contentView viewWithTag:1];
    
    UITableViewCell *cell2 = [viewTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UILabel *label2 = (UILabel*)[cell2.contentView viewWithTag:2];
    
    UITableViewCell *cell3 = [docTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UILabel *label3 = (UILabel*)[cell3.contentView viewWithTag:3];
    
    NSDictionary *dict = [self parseDocumentJSON:label1.text key2:label2.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dict objectForKey:label3.text]]];
}

- (void)SetCorrectSizeForComponent {
    
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = YES;
    typeTableView.translatesAutoresizingMaskIntoConstraints = YES;
    viewTableView.translatesAutoresizingMaskIntoConstraints = YES;
    docTableView.translatesAutoresizingMaskIntoConstraints = YES;
    topInfoView.translatesAutoresizingMaskIntoConstraints = YES;
    enterValuePickerView.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect correctBackgroundFrame;
    CGRect correctTypeTableFrame;
    CGRect correctViewTableFrame;
    CGRect correctDocTableFrame;
    CGRect correctTopInfoViewFrame;
    CGRect correctEnterValuePickerViewFrame;
    
    if (scrHeight == 480)
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 320.0f, 367.0f);
    else if (scrHeight == 568)
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 320.0f, 454.0f);
    
    else if (scrHeight == 667) {
        
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 375.0f, 553.0f);
        correctTypeTableFrame = CGRectMake(typeTableView.frame.origin.x, typeTableView.frame.origin.y, 375, typeTableView.frame.size.height);
        correctViewTableFrame = CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, 375, viewTableView.frame.size.height);
        correctDocTableFrame = CGRectMake(docTableView.frame.origin.x, docTableView.frame.origin.y, 375, docTableView.frame.size.height);
        correctTopInfoViewFrame = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y, 375, topInfoView.frame.size.height);
        correctEnterValuePickerViewFrame = CGRectMake(enterValuePickerView.frame.origin.x, enterValuePickerView.frame.origin.y, 375, enterValuePickerView.frame.size.height);
        
        backgroundImageView.frame = correctBackgroundFrame;
        typeTableView.frame = correctTypeTableFrame;
        viewTableView.frame = correctViewTableFrame;
        docTableView.frame = correctDocTableFrame;
        topInfoView.frame = correctTopInfoViewFrame;
        enterValuePickerView.frame = correctEnterValuePickerViewFrame;
        
    } else {
        
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 414.0f, 623.0f);
        correctTypeTableFrame = CGRectMake(typeTableView.frame.origin.x, typeTableView.frame.origin.y, 414, typeTableView.frame.size.height);
        correctViewTableFrame = CGRectMake(viewTableView.frame.origin.x, viewTableView.frame.origin.y, 414, viewTableView.frame.size.height);
        correctDocTableFrame = CGRectMake(docTableView.frame.origin.x, docTableView.frame.origin.y, 414, docTableView.frame.size.height);
        correctTopInfoViewFrame = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y, 414, topInfoView.frame.size.height);
        correctEnterValuePickerViewFrame = CGRectMake(enterValuePickerView.frame.origin.x, enterValuePickerView.frame.origin.y, 414, enterValuePickerView.frame.size.height);
        
        backgroundImageView.frame = correctBackgroundFrame;
        typeTableView.frame = correctTypeTableFrame;
        viewTableView.frame = correctViewTableFrame;
        docTableView.frame = correctDocTableFrame;
        topInfoView.frame = correctTopInfoViewFrame;
        enterValuePickerView.frame = correctEnterValuePickerViewFrame;
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
