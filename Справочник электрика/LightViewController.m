//
//  LightViewController.m
//  Справочник электрика
//
//  Created by Admin on 28.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "LightViewController.h"

#define MAXLENGTH 5

@interface LightViewController ()

@end

@implementation LightViewController
{
    NSArray *typeOfSpaceArray;
    NSArray *typeOfLightArray;
    NSArray *coefStockArray;
    NSArray *countLightArray;
    NSArray *data_typeOfLightKeysArray;
    NSArray *data_typeOfSpaceKeysArray;
    NSArray *data_typeOfLightValueArray;
    NSArray *data_typeOfSpaceValueArray;
    NSArray *pickerArray;
    CGFloat screenHeight;
    
    BOOL isEdit;
    BOOL isShownKeybourd;
    BOOL isSpaceKeybourd;
    BOOL isCoefKeybourd;
    BOOL isPickerShow;
    
    int spaceIndex;
    int lightIndex;
    
    UITextField *spaceTextField;
    UITextField *coefTextField;
    AppDelegate *delegate;
}

@synthesize backgroundImageView;
@synthesize typeOfSpaceTableView;
@synthesize typeOfLightTableView;
@synthesize coefStockTableView;
@synthesize countLightTableView;
@synthesize infoView;
@synthesize topInfoView;
@synthesize enterValuePickerView;
@synthesize enterValueView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    typeOfLightTableView.delegate = self;
    typeOfLightTableView.dataSource = self;
    typeOfLightTableView.scrollEnabled = NO;
    typeOfSpaceTableView.delegate = self;
    typeOfSpaceTableView.dataSource = self;
    typeOfSpaceTableView.scrollEnabled = NO;
    coefStockTableView.delegate = self;
    coefStockTableView.dataSource = self;
    coefStockTableView.scrollEnabled = NO;
    countLightTableView.delegate = self;
    countLightTableView.dataSource = self;
    countLightTableView.scrollEnabled = NO;
    enterValuePickerView.delegate = self;
    enterValuePickerView.dataSource = self;
    
    typeOfSpaceArray = [NSArray arrayWithObjects:@"Площадь помещения", @"Тип помещения", nil];
    typeOfLightArray = [NSArray arrayWithObject:@"Тип лампы"];
    coefStockArray = [NSArray arrayWithObject:@"Коэффициент запаса"];
    countLightArray = [NSArray arrayWithObject:@"Количество ламп"];
    
    data_typeOfLightKeysArray = [NSArray arrayWithObjects:@"Лампа накаливания 40Вт", @"Лампа накаливания 60Вт", @"Лампа накаливания 100Вт", @"Лампа накаливания 150Вт", @"Люминисцентная лампа 15Вт", @"Люминисцентная лампа 25-30Вт", @"Люминисцентная лампа 40-50Вт", @"Люминисцентная лампа 60-80Вт", @"Галогеновая лампа 42Вт", @"Галогеновая лампа 55Вт", @"Галогеновая лампа 70Вт", @"Светодиодная лампа 4-5Вт", @"Светодиодная лампа 8-10Вт", @"Светодиодная лампа 12-15Вт", @"Светодиодная лампа 18-20Вт", @"Светодиодная лампа 25-30Вт", nil];
    data_typeOfLightValueArray = [NSArray arrayWithObjects:@"415", @"750", @"1400", @"2160", @"700", @"1200", @"1800", @"2500", @"625", @"900", @"1170", @"400", @"700", @"1200", @"1800", @"2500", nil];
    data_typeOfSpaceKeysArray = [NSArray arrayWithObjects:@"Комната, спальня, гостиная, кухня", @"Детская комната", @"Кабинет, библиотека", @"Ванные, с/у, уборные", @"Лестница", @"Сауна, бассейн", @"Техническое помещение", @"Торговый зал магазина", @"Гостиный номер", @"Кабинет врача", @"Спортивный зал", @"Зал много целевого назначения", @"Зал кафе, баров, ресторанов", nil];
    data_typeOfSpaceValueArray = [NSArray arrayWithObjects:@"150", @"200", @"300", @"50", @"20", @"100", @"30", @"400", @"150", @"400", @"200", @"400", @"200", nil];
    
    // Выставляем прозрачность таблицам
    typeOfLightTableView.opaque = NO;
    typeOfLightTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    typeOfSpaceTableView.opaque = NO;
    typeOfSpaceTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    coefStockTableView.opaque = NO;
    coefStockTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    countLightTableView.opaque = NO;
    countLightTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    infoView.backgroundColor = [delegate colorWithHexString:@"5294c3"];
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    isEdit = false;
    isShownKeybourd = false;
    isSpaceKeybourd = false;
    isCoefKeybourd = false;
    isPickerShow = false;
    
    spaceIndex = 0;
    lightIndex = 0;
    
    self.navigationItem.title = @"Расчет освещенности помещения";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    
    [self SetCorrectSizeForComponent];
}

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

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    
    retval.text = pickerArray[row];
    retval.textAlignment = NSTextAlignmentCenter;
    retval.font = [UIFont systemFontOfSize:19];
    
    return retval;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == typeOfSpaceTableView)
        return [typeOfSpaceArray count];
    else if (tableView == typeOfLightTableView)
        return [typeOfLightArray count];
    else if (tableView == coefStockTableView)
        return [coefStockArray count];
    else return [countLightArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    // typeOfSpaceTableView
    if (tableView == typeOfSpaceTableView) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Добовляем text field
        if (indexPath.row == 0)
        {
            if (screenHeight == 667)
                spaceTextField = [[UITextField alloc] initWithFrame:CGRectMake(300, 5, 200, 40)];
            else if (screenHeight == 736)
                spaceTextField = [[UITextField alloc] initWithFrame:CGRectMake(339, 5, 200, 40)];
            else spaceTextField = [[UITextField alloc] initWithFrame:CGRectMake(245, 5, 200, 40)];
            
            spaceTextField.delegate = self;
            spaceTextField.borderStyle = UITextBorderStyleNone;
            spaceTextField.textColor = [delegate colorWithHexString:@"5294c3"];
            spaceTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Ввести" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
            [spaceTextField addTarget:self
                              action:@selector(spaceTextFieldDidChange)
                    forControlEvents:UIControlEventEditingDidBegin];
            spaceTextField.font = [UIFont systemFontOfSize:18];
            spaceTextField.placeholder = @"Ввести";
            spaceTextField.autocorrectionType = UITextAutocorrectionTypeNo;
            spaceTextField.keyboardType = UIKeyboardTypeNumberPad;
            spaceTextField.returnKeyType = UIReturnKeyDefault;
            spaceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            spaceTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            spaceTextField.tag = 1;
            
            [cell.contentView addSubview:spaceTextField];
        }
        // Добовляем label
        if (indexPath.row == 1)
        {
            UILabel *label;
            
            if (screenHeight == 667)
                label = [[UILabel alloc] initWithFrame:CGRectMake(300.0f, 5.0f, 100.0f, 35.0f)];
            else if (screenHeight == 736)
                label = [[UILabel alloc] initWithFrame:CGRectMake(339.0f, 5.0f, 100.0f, 35.0f)];
            else label = [[UILabel alloc] initWithFrame:CGRectMake(245.0f, 5.0f, 100.0f, 35.0f)];
            
            label.font = [UIFont fontWithName:@"Arial" size:18];
            label.textColor = [UIColor lightGrayColor];
            label.text = @"Ввести";
            label.tag = 2;
            
            [cell.contentView addSubview:label];
        }
        
        // Делаем яцейки прозрачными
        cell.opaque = NO;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        
        // Записываем данные
        cell.textLabel.text = [typeOfSpaceArray objectAtIndex:indexPath.row];
        
    }
    
    // typeOfLightTableView
    if (tableView == typeOfLightTableView) {
        
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Добовляем label
        UILabel *label;
        
        if (screenHeight == 667)
            label = [[UILabel alloc] initWithFrame:CGRectMake(300.0f, 5.0f, 100.0f, 35.0f)];
        else if (screenHeight == 736)
            label = [[UILabel alloc] initWithFrame:CGRectMake(339.0f, 5.0f, 100.0f, 35.0f)];
        else label = [[UILabel alloc] initWithFrame:CGRectMake(245.0f, 5.0f, 100.0f, 35.0f)];
        
        label.font = [UIFont fontWithName:@"Arial" size:18];
        label.textColor = [UIColor lightGrayColor];
        label.text = @"Ввести";
        label.tag = 3;
        [cell.contentView addSubview:label];
        
        // Делаем яцейки прозрачными
        cell.opaque = YES;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        
        // Записываем данные
        cell.textLabel.text = [typeOfLightArray objectAtIndex:indexPath.row];
    }
    
    // coefStockTableView
    if (tableView == coefStockTableView) {
        
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (screenHeight == 667)
            coefTextField = [[UITextField alloc] initWithFrame:CGRectMake(310.0f, 5.0f, 100.0f, 35.0f)];
        else if (screenHeight == 736)
            coefTextField = [[UITextField alloc] initWithFrame:CGRectMake(349.0f, 5.0f, 100.0f, 35.0f)];
        else coefTextField = [[UITextField alloc] initWithFrame:CGRectMake(255.0f, 5.0f, 100.0f, 35.0f)];
        
        coefTextField.delegate = self;
        coefTextField.borderStyle = UITextBorderStyleNone;
        coefTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"1.5" attributes:@{NSForegroundColorAttributeName: [delegate colorWithHexString:@"5294c3"]}];
        [coefTextField addTarget:self
        action:@selector(textFieldDidChange)
        forControlEvents:UIControlEventEditingDidBegin];
        coefTextField.font = [UIFont systemFontOfSize:18];
        coefTextField.textColor = [delegate colorWithHexString:@"5294c3"];
        coefTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        coefTextField.keyboardType = UIKeyboardTypeDecimalPad;
        coefTextField.returnKeyType = UIReturnKeyDefault;
        coefTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        coefTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        coefTextField.tag = 4;
        
        [cell.contentView addSubview:coefTextField];
        
        // Делаем яцейки прозрачными
        cell.opaque = YES;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        
        // Записываем данные
        cell.textLabel.text = [coefStockArray objectAtIndex:indexPath.row];
    }
    
    //countLightTableView
    if (tableView == countLightTableView)
    {
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Добовляем label
        UILabel *label;
        
        if (screenHeight == 667)
            label = [[UILabel alloc] initWithFrame:CGRectMake(330.0f, 5.0f, 100.0f, 35.0f)];
        else if (screenHeight == 736)
            label = [[UILabel alloc] initWithFrame:CGRectMake(369.0f, 5.0f, 100.0f, 35.0f)];
        else label = [[UILabel alloc] initWithFrame:CGRectMake(245.0f, 5.0f, 100.0f, 35.0f)];
        
        label.font = [UIFont fontWithName:@"Arial" size:18];
        label.textColor = [delegate colorWithHexString:@"5294c3"];
        label.text = @"-";
        label.tag = 5;
        
        [cell.contentView addSubview:label];

        // Делаем ячейки прозрачными
        cell.opaque = YES;
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        
        // Записываем данные
        cell.textLabel.text = [countLightArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

// Tap on table Row
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    if (tableView == typeOfSpaceTableView) {
        
        if (indexPath.row == 0) {
            
            if (!isPickerShow) {
                
                [self CheckAndAlignText];
            
                [spaceTextField resignFirstResponder];
                [coefTextField resignFirstResponder];
            
                [self CalculateAndSetUpCountLight];
            }
        }
        
        if (indexPath.row == 1)
        {
            if (isShownKeybourd) {
                
                [self CheckAndAlignText];
                
                [spaceTextField resignFirstResponder];
                [coefTextField resignFirstResponder];
                [self CalculateAndSetUpCountLight];
                
                isShownKeybourd = false;
            
            } else {
            
                if (!isPickerShow) {
                    
                    pickerArray = data_typeOfSpaceKeysArray;
                    [enterValuePickerView selectRow:spaceIndex inComponent:0 animated:YES];
                    [enterValuePickerView reloadAllComponents];
               
                    // show picker view
                    typeOfLightTableView.frame = CGRectMake(typeOfLightTableView.frame.origin.x, typeOfLightTableView.frame.origin.y + 162, typeOfLightTableView.frame.size.width, typeOfLightTableView.frame.size.height);
                    coefStockTableView.frame = CGRectMake(coefStockTableView.frame.origin.x, coefStockTableView.frame.origin.y + 162, coefStockTableView.frame.size.width, coefStockTableView.frame.size.height);
                    infoView.frame = CGRectMake(infoView.frame.origin.x, infoView.frame.origin.y + 162, infoView.frame.size.width, infoView.frame.size.height);
                    countLightTableView.frame = CGRectMake(countLightTableView.frame.origin.x, countLightTableView.frame.origin.y + 162, countLightTableView.frame.size.width, countLightTableView.frame.size.height);
                    enterValueView.frame = CGRectMake(enterValuePickerView.frame.origin.x, 204, enterValuePickerView.frame.size.width, enterValuePickerView.frame.size.height);
                
                    isPickerShow = true;
                    
                    // delete label
                    UITableViewCell *cell = [typeOfSpaceTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                    [[cell.contentView viewWithTag:2] removeFromSuperview];
                    
                    // add button
                    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [doneButton addTarget:self
                                   action:@selector(spaceDone)
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
            
            }
        }
    }
    else if (tableView == typeOfLightTableView)
    {
        if (isShownKeybourd) {
            
            [self CheckAndAlignText];
            
            [spaceTextField resignFirstResponder];
            [coefTextField resignFirstResponder];
            [self CalculateAndSetUpCountLight];
            isShownKeybourd = false;
            
        } else {
        
            if (!isPickerShow) {
                
                pickerArray = data_typeOfLightKeysArray;
                [enterValuePickerView selectRow:lightIndex inComponent:0 animated:YES];
                [enterValuePickerView reloadAllComponents];
                
                // show picker view
                coefStockTableView.frame = CGRectMake(coefStockTableView.frame.origin.x, coefStockTableView.frame.origin.y + 162, coefStockTableView.frame.size.width, coefStockTableView.frame.size.height);
                infoView.frame = CGRectMake(infoView.frame.origin.x, infoView.frame.origin.y + 162, infoView.frame.size.width, infoView.frame.size.height);
                countLightTableView.frame = CGRectMake(countLightTableView.frame.origin.x, countLightTableView.frame.origin.y + 162, countLightTableView.frame.size.width, countLightTableView.frame.size.height);
                enterValueView.frame = CGRectMake(enterValuePickerView.frame.origin.x, 248, enterValuePickerView.frame.size.width, enterValuePickerView.frame.size.height);
                
                isPickerShow = true;
                
                // delete label
                UITableViewCell *cell = [typeOfLightTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                [[cell.contentView viewWithTag:3] removeFromSuperview];
                
                // add button
                UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [doneButton addTarget:self
                               action:@selector(lightDone)
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
        
        }
    }
    
    else if (tableView == coefStockTableView)
    {
            if (!isPickerShow) {
        
                if (isCoefKeybourd) {
            
                    // Если коэфициент запаса не поменялся
                    if ([coefTextField.text isEqualToString:@""])
                        isEdit = NO;
                    
                }
        
                [self CheckAndAlignText];
        
                isCoefKeybourd = false;
                [spaceTextField resignFirstResponder];
                [coefTextField resignFirstResponder];
        
                [self CalculateAndSetUpCountLight];
            }
    }
    
    else if (tableView == countLightTableView) {
        
        if (isShownKeybourd) {
            
            [spaceTextField resignFirstResponder];
            [coefTextField resignFirstResponder];
            [self CalculateAndSetUpCountLight];
            isShownKeybourd = false;
        }
    }
}

- (void)spaceDone {
    
    // add label
    UILabel *label;
    
    if (screenHeight == 667)
        label = [[UILabel alloc] initWithFrame:CGRectMake(310.0f, 5.0f, 100.0f, 35.0f)];
    else if (screenHeight == 736)
        label = [[UILabel alloc] initWithFrame:CGRectMake(349.0f, 5.0f, 100.0f, 35.0f)];
    else label = [[UILabel alloc] initWithFrame:CGRectMake(255.0f, 5.0f, 100.0f, 35.0f)];

    spaceIndex = (int)[self.enterValuePickerView selectedRowInComponent:0];
    
    label.font = [UIFont fontWithName:@"Arial" size:18];
    label.textColor = [delegate colorWithHexString:@"5294c3"];
    label.text = [data_typeOfSpaceValueArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]];
    label.tag = 2;
    
    UITableViewCell *cell = [typeOfSpaceTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [[cell.contentView viewWithTag:2] removeFromSuperview];
    [cell.contentView addSubview:label];
    cell.selected = NO;
    
    // hide picker view
    [self SpaceHidePickerView];
    
    [self CalculateAndSetUpCountLight];
}

- (void)lightDone {
    
    // add label
    UILabel *label;
    
    if (screenHeight == 667)
        label = [[UILabel alloc] initWithFrame:CGRectMake(310.0f, 5.0f, 100.0f, 35.0f)];
    else if (screenHeight == 736)
        label = [[UILabel alloc] initWithFrame:CGRectMake(349.0f, 5.0f, 100.0f, 35.0f)];
    else label = [[UILabel alloc] initWithFrame:CGRectMake(255.0f, 5.0f, 100.0f, 35.0f)];
    
    lightIndex = (int)[self.enterValuePickerView selectedRowInComponent:0];
    
    label.font = [UIFont fontWithName:@"Arial" size:18];
    label.textColor = [delegate colorWithHexString:@"5294c3"];
    label.text = [data_typeOfLightValueArray objectAtIndex:[enterValuePickerView selectedRowInComponent:0]];
    label.tag = 3;
    
    UITableViewCell *cell = [typeOfLightTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell.contentView viewWithTag:3] removeFromSuperview];
    [cell.contentView addSubview:label];
    cell.selected = NO;
    
    // hide picker view
    [self LightHidePickerView];
    
    [self CalculateAndSetUpCountLight];
}

- (void)SpaceHidePickerView {
    
    typeOfLightTableView.frame = CGRectMake(typeOfLightTableView.frame.origin.x, typeOfLightTableView.frame.origin.y - 162, typeOfLightTableView.frame.size.width, typeOfLightTableView.frame.size.height);
    coefStockTableView.frame = CGRectMake(coefStockTableView.frame.origin.x, coefStockTableView.frame.origin.y - 162, coefStockTableView.frame.size.width, coefStockTableView.frame.size.height);
    infoView.frame = CGRectMake(infoView.frame.origin.x, infoView.frame.origin.y - 162, infoView.frame.size.width, infoView.frame.size.height);
    countLightTableView.frame = CGRectMake(countLightTableView.frame.origin.x, countLightTableView.frame.origin.y - 162, countLightTableView.frame.size.width, countLightTableView.frame.size.height);
    enterValueView.frame = CGRectMake(enterValuePickerView.frame.origin.x, 1000, enterValuePickerView.frame.size.width, enterValuePickerView.frame.size.height);
    
    isPickerShow = false;
}

- (void)LightHidePickerView {
    
    coefStockTableView.frame = CGRectMake(coefStockTableView.frame.origin.x, coefStockTableView.frame.origin.y - 162, coefStockTableView.frame.size.width, coefStockTableView.frame.size.height);
    infoView.frame = CGRectMake(infoView.frame.origin.x, infoView.frame.origin.y - 162, infoView.frame.size.width, infoView.frame.size.height);
    countLightTableView.frame = CGRectMake(countLightTableView.frame.origin.x, countLightTableView.frame.origin.y - 162, countLightTableView.frame.size.width, countLightTableView.frame.size.height);
    enterValueView.frame = CGRectMake(enterValuePickerView.frame.origin.x, 1000, enterValuePickerView.frame.size.width, enterValuePickerView.frame.size.height);
    
    isPickerShow = false;
}

- (void)CheckAndAlignText {
    
    if (isSpaceKeybourd) {
        
        // Выравниваем значения ячейки "Площадь помещения"
        UITableViewCell *cell = [typeOfSpaceTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        UITextField *textField = (UITextField*)[cell.contentView viewWithTag:1];
        
        // Если значение все же были введены
        if ([textField.text doubleValue] != 0) {
            
            if (screenHeight == 667)
                textField.frame = CGRectMake(310.0f, 5.0f, 100.0f, 35.0f);
            else if (screenHeight == 736)
                textField.frame = CGRectMake(349.0f, 5.0f, 100.0f, 35.0f);
            else textField.frame = CGRectMake(255.0f, 5.0f, 100.0f, 35.0f);
        }
        
        isSpaceKeybourd = false;
    
    } else if (isCoefKeybourd) {
        
        if (screenHeight == 480)
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 25, self.view.frame.size.width, self.view.frame.size.height);
        
        isCoefKeybourd = false;
    }
}

- (void)CalculateAndSetUpCountLight {
    
    // Получам площадь помещения
    UITableViewCell *cell1 = [typeOfSpaceTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textField1 = (UITextField*)[cell1.contentView viewWithTag:1];
    double roomSpace = [textField1.text doubleValue];
    
    // Получаем тип помещения
    UITableViewCell *cell2 = [typeOfSpaceTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UILabel *label2 = (UILabel*)[cell2.contentView viewWithTag:2];
    double typeRoom = [label2.text doubleValue];
    
    // Получаем placeholder коэфициента запаса
    UITableViewCell *cell4 = [coefStockTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *textField4 = (UITextField*)[cell4.contentView viewWithTag:4];
    double coefStock = [textField4.placeholder doubleValue];
    
    // Если коэфициент запаса был изменен, получаем его текст
    if (isEdit)
        coefStock = [textField4.text doubleValue];
    
    // Получаем тип лампы
    UITableViewCell *cell3 = [typeOfLightTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UILabel *label3 = (UILabel*)[cell3.contentView viewWithTag:3];
    double typeLight = [[label3.text stringByReplacingOccurrencesOfString:@"," withString:@"."] doubleValue];
    
    // Получаем ячейку "Кол.во ламп"
    UITableViewCell *cellCount = [countLightTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    // Проверяем введены ли все данные
    if (roomSpace != 0 && typeRoom != 0 && coefStock != 0 && typeLight != 0) {
        
        // Очищаем старый текст ячейки "Кол.во ламп"
        [[cellCount.contentView viewWithTag:5] removeFromSuperview];
        
        // Создаем label для результата
        UILabel *labelCount;
        
        if (screenHeight == 667)
            labelCount = [[UILabel alloc] initWithFrame:CGRectMake(310.0f, 5.0f, 100.0f, 35.0f)];
        else if (screenHeight == 736)
            labelCount = [[UILabel alloc] initWithFrame:CGRectMake(349.0f, 5.0f, 100.0f, 35.0f)];
        else labelCount = [[UILabel alloc] initWithFrame:CGRectMake(255.0f, 5.0f, 100.0f, 35.0f)];
        
        labelCount.font = [UIFont fontWithName:@"Arial" size:18];
        labelCount.textColor = [delegate colorWithHexString:@"5294c3"];
        
        // Корректируем результат
        double result = (roomSpace * typeRoom * coefStock / typeLight);
        if (result >= (int)result + 0.5)
            labelCount.text = [NSString stringWithFormat:@"%i", (int)result + 1];
        else labelCount.text = [NSString stringWithFormat:@"%i", (int)result];
        if ((int)result == 0)
            labelCount.text = [NSString stringWithFormat:@"1"];
        
        // Если результат слишком длинный, смещаем его
        if (result > 1000000) {
            
            if (screenHeight == 667)
                labelCount.frame = CGRectMake(300.0f, 5.0f, 100.0f, 35.0f);
            else if (screenHeight == 736)
                labelCount.frame = CGRectMake(339.0f, 5.0f, 100.0f, 35.0f);
            else labelCount.frame = CGRectMake(245.0f, 5.0f, 100.0f, 35.0f);
        }
        
        labelCount.tag = 5;
        [cellCount.contentView addSubview:labelCount];
    
    } else { // Если что то введено не корректно или не введено во обще
        
        // Очищаем старый текст ячейки "Кол.во ламп"
        [[cellCount.contentView viewWithTag:5] removeFromSuperview];
        
        // Добовляем "-"
        UILabel *label;
        
        if (screenHeight == 667)
            label = [[UILabel alloc] initWithFrame:CGRectMake(330.0f, 5.0f, 100.0f, 35.0f)];
        else if (screenHeight == 736)
            label = [[UILabel alloc] initWithFrame:CGRectMake(369.0f, 5.0f, 100.0f, 35.0f)];
        else label = [[UILabel alloc] initWithFrame:CGRectMake(275.0f, 5.0f, 100.0f, 35.0f)];

        
        label.font = [UIFont fontWithName:@"Arial" size:18];
        label.textColor = [delegate colorWithHexString:@"5294c3"];
        label.text = @"-";
        label.tag = 5;
        
        [cellCount.contentView addSubview:label];
    }
}

- (void)keyboardDidShow {
    
    isShownKeybourd = true;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self CheckAndAlignText];
    
    [spaceTextField resignFirstResponder];
    [coefTextField resignFirstResponder];
    
    if (!isPickerShow)
        [self CalculateAndSetUpCountLight];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == spaceTextField) {
        
        [spaceTextField resignFirstResponder];
        
        // Выравниваем значения ячейки "Площадь помещения"
        UITableViewCell *cell = [typeOfSpaceTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        UITextField *textField = (UITextField*)[cell.contentView viewWithTag:1];
        
        // Если значение все же были введены
        if ([textField.text doubleValue] != 0) {
            
            if (screenHeight == 667)
                textField.frame = CGRectMake(310.0f, 5.0f, 100.0f, 35.0f);
            else if (screenHeight == 736)
                textField.frame = CGRectMake(349.0f, 5.0f, 100.0f, 35.0f);
            else textField.frame = CGRectMake(255.0f, 5.0f, 100.0f, 35.0f);
        }
        
        [self CalculateAndSetUpCountLight];
    }
    else if (textField == coefTextField) {
     
        [coefTextField resignFirstResponder];

        // Если коэфициент запаса не поменялся
        if ([coefTextField.text isEqualToString:@""])
            isEdit = NO;
        
        [self CalculateAndSetUpCountLight];
    }
    
    return NO;
}

- (void)textFieldDidChange {
    
        if (screenHeight == 480)
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 25, self.view.frame.size.width, self.view.frame.size.height);
    
        coefTextField.placeholder = @"";
        isCoefKeybourd = true;
        isEdit = true;
    
}

- (void)spaceTextFieldDidChange {
    
    
        isSpaceKeybourd = true;
    
    // hide picker view
}

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == spaceTextField) {
        
        NSUInteger oldLength = [textField.text length];
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
    
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
        return newLength <= MAXLENGTH || returnKey;
    
    } else if (coefTextField) {
        
        NSUInteger oldLength = [textField.text length];
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
        
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
        
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= MAXLENGTH || returnKey;

    }
    
    return 0;
}

- (void)SetCorrectSizeForComponent {
    
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = YES;
    typeOfSpaceTableView.translatesAutoresizingMaskIntoConstraints = YES;
    typeOfLightTableView.translatesAutoresizingMaskIntoConstraints = YES;
    coefStockTableView.translatesAutoresizingMaskIntoConstraints = YES;
    countLightTableView.translatesAutoresizingMaskIntoConstraints = YES;
    topInfoView.translatesAutoresizingMaskIntoConstraints = YES;
    infoView.translatesAutoresizingMaskIntoConstraints = YES;
    enterValuePickerView.translatesAutoresizingMaskIntoConstraints = YES;
    enterValueView.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect correctBackgroundFrame;
    CGRect correctTypeOfSpaceTableFrame;
    CGRect correctTypeOfLightTableFrame;
    CGRect correctCoefStockTableFrame;
    CGRect correctCountLightTableFrame;
    CGRect correctPickerFrame;
    CGRect correctViewFrame;
    CGRect correctInfoView;
    CGRect correctTopInfoView;
    
    if (scrHeight == 480)
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 320.0f, 367.0f);
    else if (scrHeight == 568)
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 320.0f, 454.0f);
    
    else if (scrHeight == 667) {
        
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 375.0f, 553.0f);
        correctTypeOfSpaceTableFrame = CGRectMake(typeOfSpaceTableView.frame.origin.x, typeOfSpaceTableView.frame.origin.y, 375, typeOfSpaceTableView.frame.size.height);
        correctTypeOfLightTableFrame = CGRectMake(typeOfLightTableView.frame.origin.x, typeOfLightTableView.frame.origin.y, 375, typeOfLightTableView.frame.size.height);
        correctCoefStockTableFrame = CGRectMake(coefStockTableView.frame.origin.x, coefStockTableView.frame.origin.y, 375, coefStockTableView.frame.size.height);
        correctCountLightTableFrame = CGRectMake(countLightTableView.frame.origin.x, countLightTableView.frame.origin.y, 375, countLightTableView.frame.size.height);
        correctPickerFrame = CGRectMake(enterValuePickerView.frame.origin.x, enterValuePickerView.frame.origin.y, 375, enterValuePickerView.frame.size.height);
        correctViewFrame = CGRectMake(enterValueView.frame.origin.x, enterValueView.frame.origin.y, 375, enterValueView.frame.size.height);
        correctInfoView = CGRectMake(infoView.frame.origin.x, infoView.frame.origin.y, 375, infoView.frame.size.height);
        correctTopInfoView = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y, 375, topInfoView.frame.size.height);

        backgroundImageView.frame = correctBackgroundFrame;
        typeOfSpaceTableView.frame = correctTypeOfSpaceTableFrame;
        typeOfLightTableView.frame = correctTypeOfLightTableFrame;
        coefStockTableView.frame = correctCoefStockTableFrame;
        countLightTableView.frame = correctCountLightTableFrame;
        enterValuePickerView.frame = correctPickerFrame;
        enterValueView.frame = correctViewFrame;
        infoView.frame = correctInfoView;
        topInfoView.frame = correctTopInfoView;
        
    } else {
        
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 414.0f, 553.0f);
        correctTypeOfSpaceTableFrame = CGRectMake(typeOfSpaceTableView.frame.origin.x, typeOfSpaceTableView.frame.origin.y, 414, typeOfSpaceTableView.frame.size.height);
        correctTypeOfLightTableFrame = CGRectMake(typeOfLightTableView.frame.origin.x, typeOfLightTableView.frame.origin.y, 414, typeOfLightTableView.frame.size.height);
        correctCoefStockTableFrame = CGRectMake(coefStockTableView.frame.origin.x, coefStockTableView.frame.origin.y, 414, coefStockTableView.frame.size.height);
        correctCountLightTableFrame = CGRectMake(countLightTableView.frame.origin.x, countLightTableView.frame.origin.y, 414, countLightTableView.frame.size.height);
        correctPickerFrame = CGRectMake(enterValuePickerView.frame.origin.x, enterValuePickerView.frame.origin.y, 414, enterValuePickerView.frame.size.height);
        correctViewFrame = CGRectMake(enterValueView.frame.origin.x, enterValueView.frame.origin.y, 414, enterValueView.frame.size.height);
        correctInfoView = CGRectMake(infoView.frame.origin.x, infoView.frame.origin.y, 414, infoView.frame.size.height);
        correctTopInfoView = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y, 414, topInfoView.frame.size.height);
        
        backgroundImageView.frame = correctBackgroundFrame;
        typeOfSpaceTableView.frame = correctTypeOfSpaceTableFrame;
        typeOfLightTableView.frame = correctTypeOfLightTableFrame;
        coefStockTableView.frame = correctCoefStockTableFrame;
        countLightTableView.frame = correctCountLightTableFrame;
        enterValuePickerView.frame = correctPickerFrame;
        enterValueView.frame = correctViewFrame;
        infoView.frame = correctInfoView;
        topInfoView.frame = correctTopInfoView;
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
