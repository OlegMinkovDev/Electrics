//
//  UZOViewController.m
//  Электрика
//
//  Created by Admin on 04.08.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "UZOViewController.h"

//const CGRect SEGMENTED_FRAME_IPHONE4_IPHONE5 = {210, 6, 90, 30};
//const CGRect SEGMENTED_FRAME_IPHONE6 = {265, 6, 90, 30};
//const CGRect SEGMENTED_FRAME_IPHONE6PLUS = {304, 6, 90, 30};
//const CGRect IMAGE_FRAME_IPHONE4_IPHONE5 = {209, 5, 91, 35};
//const CGRect IMAGE_FRAME_IPHONE6 = {264, 5, 92, 35};
//const CGRect IMAGE_FRAME_IPHONE6PLUS = {303, 5, 92, 35};

@interface UZOViewController ()
{
    NSArray *uzoArray;
    AppDelegate *appDelegate;
    CGFloat screenHeight;
    BOOL isA;
    BOOL isKeybourdWasMoved;
    UITextField *amperageTextField;
    UITextField *lenghtTextField;
}

@end

@implementation UZOViewController

@synthesize backgroundImageView;
@synthesize uzoTableView;
@synthesize topInfoView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    uzoTableView.delegate = self;
    uzoTableView.dataSource = self;
    
    uzoTableView.opaque = NO;
    uzoTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    uzoTableView.scrollEnabled = NO;
    
    uzoArray = [NSArray arrayWithObjects:@"Сила тока/мощность", @"Укажите силу тока, А:", @"Укажите длину\r\nпроводника, М:", @"Минимальное значение\r\nдифф. тока УЗО, мА", nil];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    isA = true;
    isKeybourdWasMoved = false;
    
    self.navigationItem.title = @"Калькулятор выбора УЗО";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self SetCorrectSizeForComponent];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [uzoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        // Добовляем segmented control
        [cell addSubview:[self InitSegmentedControlWithTag:1010]];
        [cell addSubview:[self InitImageView:[UIImage imageNamed:@"ABtSwitch_l@3x"] WithSelector:@selector(ABtDetected:)]];
        
    } else if (indexPath.row == 1) {
        
        // Добовляем text field
        if (screenHeight == 667)
            amperageTextField = [[UITextField alloc] initWithFrame:CGRectMake(300, 10, 200, 40)];
        else if (screenHeight == 736)
            amperageTextField = [[UITextField alloc] initWithFrame:CGRectMake(339, 10, 200, 40)];
        else amperageTextField = [[UITextField alloc] initWithFrame:CGRectMake(245, 10, 200, 40)];
        
        amperageTextField.delegate = (id)self;
        amperageTextField.borderStyle = UITextBorderStyleNone;
        amperageTextField.textColor = [appDelegate colorWithHexString:@"5294c3"];
        amperageTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Ввести" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        [amperageTextField addTarget:self
                           action:@selector(amperageTextFieldDidChange)
                 forControlEvents:UIControlEventEditingDidBegin];
        amperageTextField.font = [UIFont systemFontOfSize:18];
        amperageTextField.placeholder = @"Ввести";
        amperageTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        amperageTextField.keyboardType = UIKeyboardTypeNumberPad;
        amperageTextField.returnKeyType = UIReturnKeyDefault;
        amperageTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        amperageTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        amperageTextField.tag = 1;
        
        [cell.contentView addSubview:amperageTextField];
        
    } else if (indexPath.row == 2) {
        
        // Добовляем text field
        if (screenHeight == 667)
            lenghtTextField = [[UITextField alloc] initWithFrame:CGRectMake(300, 10, 200, 40)];
        else if (screenHeight == 736)
            lenghtTextField = [[UITextField alloc] initWithFrame:CGRectMake(339, 10, 200, 40)];
        else lenghtTextField = [[UITextField alloc] initWithFrame:CGRectMake(245, 10, 200, 40)];
        
        lenghtTextField.delegate = (id)self;
        lenghtTextField.borderStyle = UITextBorderStyleNone;
        lenghtTextField.textColor = [appDelegate colorWithHexString:@"5294c3"];
        lenghtTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Ввести" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        [lenghtTextField addTarget:self
                              action:@selector(lenghtTextFieldDidChange)
                    forControlEvents:UIControlEventEditingDidBegin];
        lenghtTextField.font = [UIFont systemFontOfSize:18];
        lenghtTextField.placeholder = @"Ввести";
        lenghtTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        lenghtTextField.keyboardType = UIKeyboardTypeNumberPad;
        lenghtTextField.returnKeyType = UIReturnKeyDefault;
        lenghtTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        lenghtTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        lenghtTextField.tag = 2;
        
        [cell.contentView addSubview:lenghtTextField];
    
    } else if (indexPath.row == 3) {
        
        // Добовляем label
        if (screenHeight == 667)
            [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(330.0f, 10, 100.0f, 35.0f) Text:@"-" Tag:3]];
        else if (screenHeight == 736)
            [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(369.0f, 10, 100.0f, 35.0f) Text:@"-" Tag:3]];
        else [cell.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(275.0f, 10, 100.0f, 35.0f) Text:@"-" Tag:3]];
    }
    
    // Делаем яцейки прозрачными
    cell.opaque = NO;
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        
    // Записываем данные
    cell.textLabel.text = [uzoArray objectAtIndex:indexPath.row];
        
    if (indexPath.row == 3 || indexPath.row == 2) {
        
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
    }
    
    return cell;
}

// Tap on table Row
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {

    UITableViewCell *cell_1 = [uzoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell *cell_2 = [uzoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    UITextField *TF1 = (UITextField*)[cell_1 viewWithTag:1];
    UITextField *TF2 = (UITextField*)[cell_2 viewWithTag:2];
    
    [TF1 resignFirstResponder];
    [TF2 resignFirstResponder];
    
    if (screenHeight == 480 && isKeybourdWasMoved) {
        
        uzoTableView.frame = CGRectMake(uzoTableView.frame.origin.x, uzoTableView.frame.origin.y + 50, uzoTableView.frame.size.width, uzoTableView.frame.size.height);
        topInfoView.frame = CGRectMake(uzoTableView.frame.origin.x, topInfoView.frame.origin.y + 50, topInfoView.frame.size.width, topInfoView.frame.size.height);
        isKeybourdWasMoved = false;
    }

    [self Calculate];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITableViewCell *cell_1 = [uzoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell *cell_2 = [uzoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    UITextField *TF1 = (UITextField*)[cell_1 viewWithTag:1];
    UITextField *TF2 = (UITextField*)[cell_2 viewWithTag:2];
    
    [TF1 resignFirstResponder];
    [TF2 resignFirstResponder];
    
    if (screenHeight == 480 && isKeybourdWasMoved) {
        
        uzoTableView.frame = CGRectMake(uzoTableView.frame.origin.x, uzoTableView.frame.origin.y + 50, uzoTableView.frame.size.width, uzoTableView.frame.size.height);
        topInfoView.frame = CGRectMake(uzoTableView.frame.origin.x, topInfoView.frame.origin.y + 50, topInfoView.frame.size.width, topInfoView.frame.size.height);
        isKeybourdWasMoved = false;
    }
    
    [self Calculate];
}

- (void)ABtDetected:(UITapGestureRecognizer*)sender {
    
    UITableViewCell *in_cell_0 = [uzoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UISegmentedControl *segment = (UISegmentedControl*)[in_cell_0 viewWithTag:1010];
    
    UITableViewCell *in_cell_1 = [uzoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    UIImageView *ABtImageView = (UIImageView*)sender.view;
    
    if (isA) {
        
        ABtImageView.image = [UIImage imageNamed:@"ABtSwitch_r@3x.png"];
        isA = false;
        [segment setSelectedSegmentIndex:1];
        in_cell_1.textLabel.text = @"Укажите мощность, кВт";
        
        [self ClearResults];
        
    } else {
        
        ABtImageView.image = [UIImage imageNamed:@"ABtSwitch_l@3x.png"];
        isA = true;
        [segment setSelectedSegmentIndex:0];
        in_cell_1.textLabel.text = @"Укажите силу тока, A";
        
        [self ClearResults];
    }
}

- (void)ClearResults {
    
    UITableViewCell *cell_1 = [uzoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell *cell_2 = [uzoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITableViewCell *cell_3 = [uzoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    UITextField *TF1 = (UITextField*)[cell_1 viewWithTag:1];
    UITextField *TF2 = (UITextField*)[cell_2 viewWithTag:2];
    UILabel *L3 = (UILabel*)[cell_3 viewWithTag:3];
    
    [TF1 removeFromSuperview];
    [TF2 removeFromSuperview];
    [L3 removeFromSuperview];
    
    CGRect frame;
    if (screenHeight == 667)
        frame = CGRectMake(300, 10, 200, 40);
    else if (screenHeight == 736)
        frame = CGRectMake(339, 10, 200, 40);
    else frame = CGRectMake(245, 10, 200, 40);
    
    if (screenHeight == 667) {
        
        [cell_1.contentView addSubview:[self createTextFieldWithFrame:frame Tag:1]];
        [cell_2.contentView addSubview:[self createTextFieldWithFrame:frame Tag:2]];
        [cell_3.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(330.0f, 10, 100.0f, 35.0f) Text:@"-" Tag:3]];
    }
    else if (screenHeight == 736) {
        
        [cell_1.contentView addSubview:[self createTextFieldWithFrame:frame Tag:1]];
        [cell_2.contentView addSubview:[self createTextFieldWithFrame:frame Tag:2]];
        [cell_3.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(369.0f, 10, 100.0f, 35.0f) Text:@"-" Tag:3]];
    }
    else {
        
        [cell_1.contentView addSubview:[self createTextFieldWithFrame:frame Tag:1]];
        [cell_2.contentView addSubview:[self createTextFieldWithFrame:frame Tag:2]];
        [cell_3.contentView addSubview:[self createLabelWithFrameAndText:CGRectMake(275.0f, 10, 100.0f, 35.0f) Text:@"-" Tag:3]];
    }
}

- (void)amperageTextFieldDidChange {
    
}

- (void)lenghtTextFieldDidChange {
    
    if (screenHeight == 480) {
        
        uzoTableView.frame = CGRectMake(uzoTableView.frame.origin.x, uzoTableView.frame.origin.y - 50, uzoTableView.frame.size.width, uzoTableView.frame.size.height);
        topInfoView.frame = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y - 50, topInfoView.frame.size.width, topInfoView.frame.size.height);
        isKeybourdWasMoved = true;
    }
}

- (UISegmentedControl*)InitSegmentedControlWithTag:(int)_tag {
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", @"", nil]];
    segmentedControl.frame = appDelegate.SEGMENTED_FRAME_IPHONE4_IPHONE5;
    
    if (screenHeight == 667)
        segmentedControl.frame = appDelegate.SEGMENTED_FRAME_IPHONE6;
    else if (screenHeight == 736)
        segmentedControl.frame = appDelegate.SEGMENTED_FRAME_IPHONE6PLUS;
    
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [appDelegate colorWithHexString:@"5294c3"];
    segmentedControl.tag = _tag;
    
    return segmentedControl;
}

- (UIImageView*)InitImageView:(UIImage*)_image WithSelector:(SEL)_selector {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: appDelegate.IMAGE_FRAME_IPHONE4_IPHONE5];
    
    if (screenHeight == 667)
        imageView.frame = appDelegate.IMAGE_FRAME_IPHONE6;
    else if (screenHeight == 736)
        imageView.frame = appDelegate.IMAGE_FRAME_IPHONE6PLUS;
    
    imageView.image = _image;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:_selector];     singleTap.numberOfTapsRequired = 1;
    [imageView setUserInteractionEnabled:YES];
    [imageView addGestureRecognizer:singleTap];
    
    return imageView;
}

- (UITextField*)createTextFieldWithFrame:(CGRect)_frame Tag:(int)_tag {
    
    // Добовляем text field
    UITextField *textField = [[UITextField alloc] initWithFrame:_frame];
    textField.delegate = (id)self;
    textField.borderStyle = UITextBorderStyleNone;
    textField.textColor = [appDelegate colorWithHexString:@"5294c3"];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Ввести" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    [textField addTarget:self
                          action:@selector(lenghtTextFieldDidChange)
                forControlEvents:UIControlEventEditingDidBegin];
    textField.font = [UIFont systemFontOfSize:18];
    textField.placeholder = @"Ввести";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.returnKeyType = UIReturnKeyDefault;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.tag = _tag;

    return textField;
}

- (UILabel*)createLabelWithFrameAndText:(CGRect)frame Text:(NSString*)text Tag:(NSInteger)tag {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont fontWithName:@"Arial" size:18];
    label.textColor = [appDelegate colorWithHexString:@"5294c3"];
    label.text = text;
    label.tag = tag;
    
    return label;
}

- (void)SetCorrectSizeForComponent {
    
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = YES;
    uzoTableView.translatesAutoresizingMaskIntoConstraints = YES;
    topInfoView.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGFloat scrHeight = [[UIScreen mainScreen] bounds].size.height;
    CGRect correctBackgroundFrame;
    CGRect correctUZOTableFrame;
    CGRect correctTopInfoView;
    
    if (scrHeight == 480)
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 320.0f, 367.0f);
    else if (scrHeight == 568)
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 320.0f, 454.0f);
    
    else if (scrHeight == 667) {
        
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 375.0f, 553.0f);
        correctUZOTableFrame = CGRectMake(uzoTableView.frame.origin.x, uzoTableView.frame.origin.y, 375, uzoTableView.frame.size.height);
        correctTopInfoView = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y, 375, topInfoView.frame.size.height);
        
        backgroundImageView.frame = correctBackgroundFrame;
        uzoTableView.frame = correctUZOTableFrame;
        topInfoView.frame = correctTopInfoView;
        
    } else {
        
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 414.0f, 553.0f);
        correctUZOTableFrame = CGRectMake(uzoTableView.frame.origin.x, uzoTableView.frame.origin.y, 414, uzoTableView.frame.size.height);
        correctTopInfoView = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y, 414, topInfoView.frame.size.height);
        
        backgroundImageView.frame = correctBackgroundFrame;
        uzoTableView.frame = correctUZOTableFrame;
        topInfoView.frame = correctTopInfoView;
    }
    
    backgroundImageView.frame = correctBackgroundFrame;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

- (void)Calculate {
 
    double result = 0;
    
    UITableViewCell *cell_1 = [uzoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell *cell_2 = [uzoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITableViewCell *cell_3 = [uzoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    UITextField *TF1 = (UITextField*)[cell_1 viewWithTag:1];
    UITextField *TF2 = (UITextField*)[cell_2 viewWithTag:2];
    UILabel *L3 = (UILabel*)[cell_3 viewWithTag:3];
    
    if (![TF1.text isEqualToString:@""] && ![TF2.text isEqualToString:@""])
    {
        if (isA)
            result = (0.4 * [TF1.text intValue] + 0.01 * [TF2.text intValue]) * 3;
        else result = (1.82 * [TF1.text intValue] + 0.01 * [TF2.text intValue]) * 3;
    
        if (screenHeight == 667)
            L3.frame = CGRectMake(330.0f - 15, 10, 100.0f, 35.0f);
        else if (screenHeight == 736)
            L3.frame = CGRectMake(369.0f - 15, 10, 100.0f, 35.0f);
        else L3.frame = CGRectMake(275.0f - 15, 10, 100.0f, 35.0f);

        L3.frame = CGRectMake(L3.frame.origin.x - 30, L3.frame.origin.y, L3.frame.size.width, L3.frame.size.height);
        L3.text = [NSString stringWithFormat:@"%.2f", result];
    }
}

// ограничиваем колличество вводимых знаков
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 4;
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
