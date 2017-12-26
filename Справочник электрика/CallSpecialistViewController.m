//
//  CallSpecialistViewController.m
//  Электрика
//
//  Created by Admin on 21.08.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "CallSpecialistViewController.h"

@interface CallSpecialistViewController ()
{
    NSArray *callSpecArray;
    AppDelegate *appDelegate;
    CGFloat screenHeight;
    BOOL isTableViewWasMoved;
    BOOL isTextView;
    
    UITextField *nameTextField;
    UITextField *emailTextField;
    
    int font_size;
}

@end

@implementation CallSpecialistViewController

@synthesize backgroundImage;
@synthesize callSpecialistButton;
@synthesize callSpecialistTableView;
@synthesize topInfoView;
@synthesize questionTextView;
@synthesize underlineLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    callSpecArray = [NSArray arrayWithObjects:@"Представьтесь", @"E-Mail для ответа", @"Вопрос", nil];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    isTableViewWasMoved = false;
    isTextView = false;
    
    font_size = 18;
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"ПОДРОБНЕЕ"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    underlineLabel.attributedText = [attributeString copy];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(underlineLabelTapped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [underlineLabel addGestureRecognizer:tapGestureRecognizer];
    underlineLabel.userInteractionEnabled = YES;
    
    callSpecialistTableView.delegate = (id)self;
    callSpecialistTableView.dataSource = self;
    callSpecialistTableView.opaque = NO;
    callSpecialistTableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.35];
    
    nameTextField.delegate = self;
    emailTextField.delegate = self;
    questionTextView.delegate = self;
    
    [callSpecialistButton setHidden:YES];
    callSpecialistButton.backgroundColor = [appDelegate colorWithHexString:@"5294c3"];
    
    self.navigationItem.title = @"On-line инженер";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self SetCorrectSizeForComponent];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [callSpecArray count];
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
    
        // Добовляем text field
        if (screenHeight == 667)
            nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(300, 0, 300, 40)];
        else if (screenHeight == 736)
            nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(339, 0, 300, 40)];
        else nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(245, 0, 300, 40)];
         
        nameTextField.delegate = (id)self;
        nameTextField.borderStyle = UITextBorderStyleNone;
        nameTextField.textColor = [appDelegate colorWithHexString:@"5294c3"];
        nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Ввести" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        [nameTextField addTarget:self
                              action:@selector(nameTextFieldChanged)
                    forControlEvents:UIControlEventEditingChanged];
        nameTextField.font = [UIFont systemFontOfSize:18];
        nameTextField.placeholder = @"Ввести";
        nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        nameTextField.keyboardType = UIKeyboardTypeDefault;
        nameTextField.returnKeyType = UIReturnKeyDefault;
        nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        nameTextField.tag = 1;
         
        [cell.contentView addSubview:nameTextField];
        
    } else if (indexPath.row == 1) {
        
        // Добовляем text field
        if (screenHeight == 667)
            emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(300, 0, 200, 40)];
        else if (screenHeight == 736)
            emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(339, 0, 200, 40)];
        else emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(245, 0, 200, 40)];
        
        emailTextField.delegate = (id)self;
        emailTextField.borderStyle = UITextBorderStyleNone;
        emailTextField.textColor = [appDelegate colorWithHexString:@"5294c3"];
        emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Ввести" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        emailTextField.font = [UIFont systemFontOfSize:18];
        emailTextField.placeholder = @"Ввести";
        emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        emailTextField.keyboardType = UIKeyboardTypeDefault;
        emailTextField.returnKeyType = UIReturnKeyDefault;
        emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        emailTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        emailTextField.tag = 2;
        
        [cell.contentView addSubview:emailTextField];
        
    } else if (indexPath.row == 2) {
        
        // Добовляем label
        UILabel *label;
        
        if (screenHeight == 667)
            label = [[UILabel alloc] initWithFrame:CGRectMake(195.0f, 0.0f, 300.0f, 35.0f)];
        else if (screenHeight == 736)
            label = [[UILabel alloc] initWithFrame:CGRectMake(234.0f, 0.0f, 300.0f, 35.0f)];
        else label = [[UILabel alloc] initWithFrame:CGRectMake(140.0f, 0.0f, 300.0f, 35.0f)];
        
        label.font = [UIFont fontWithName:@"Arial" size:18];
        label.textColor = [UIColor lightGrayColor];
        label.text = @"Введите текст ниже";
        label.tag = 3;
        
        [cell.contentView addSubview:label];
    }
    
    // Делаем яцейки прозрачными
    cell.opaque = NO;
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    
    // Записываем данные
    cell.textLabel.text = [callSpecArray objectAtIndex:indexPath.row];
    
    return cell;
}

// Tap on table Row
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    UITableViewCell *cell_1 = [callSpecialistTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell *cell_2 = [callSpecialistTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    UITextField *TF1 = (UITextField*)[cell_1 viewWithTag:1];
    UITextField *TF2 = (UITextField*)[cell_2 viewWithTag:2];
    
    [TF1 resignFirstResponder];
    [TF2 resignFirstResponder];
    [questionTextView resignFirstResponder];
    
    [self ShowButoon];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITableViewCell *cell_1 = [callSpecialistTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell *cell_2 = [callSpecialistTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    UITextField *TF1 = (UITextField*)[cell_1 viewWithTag:1];
    UITextField *TF2 = (UITextField*)[cell_2 viewWithTag:2];
    
    [TF1 resignFirstResponder];
    [TF2 resignFirstResponder];
    [questionTextView resignFirstResponder];
    
    [self ShowButoon];
    
    if (isTableViewWasMoved && screenHeight == 480) {
        
        callSpecialistTableView.frame = CGRectMake(callSpecialistTableView.frame.origin.x, callSpecialistTableView.frame.origin.y + 15, callSpecialistTableView.frame.size.width, callSpecialistTableView.frame.size.height);
        topInfoView.frame = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y + 15, topInfoView.frame.size.width, topInfoView.frame.size.height);
        
        isTableViewWasMoved = false;
    }
}

-(void)nameTextFieldChanged {
    
    
}

- (void)questionTextFieldDidChange {
    
    if (!isTableViewWasMoved && screenHeight == 480) {
    
        callSpecialistTableView.frame = CGRectMake(callSpecialistTableView.frame.origin.x, callSpecialistTableView.frame.origin.y - 15, callSpecialistTableView.frame.size.width, callSpecialistTableView.frame.size.height);
        topInfoView.frame = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y - 15, topInfoView.frame.size.width, topInfoView.frame.size.height);
        
        isTableViewWasMoved = true;
    }
}

- (void)questionTextFieldChanged {
    
    if ([questionTextView.text length] > 10)
        questionTextView.frame = CGRectMake(questionTextView.frame.origin.x, questionTextView.frame.origin.y, questionTextView.frame.size.width, questionTextView.frame.size.height + 15);
}

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
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:nil];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
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

- (IBAction)CallSpec:(id)sender {

    NSString* params = [NSString stringWithFormat:@"fio=%@&phone=%@&email=%@&comment=%@", nameTextField.text, @"+70000000", emailTextField.text, questionTextView.text]; // задаем параметры POST запроса
    
    NSURL* url = [NSURL URLWithString:@"http://autonomnoe.ru/s/send-email"]; // куда отправлять
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding]; // следует обратить внимание на кодировку
    
    // теперь можно отправить запрос синхронно или асинхронно
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [conn start];
}

- (void)ShowButoon {
    
    if (![nameTextField.text isEqualToString:@""] && ![emailTextField.text isEqualToString:@""] &&
        ![questionTextView.text isEqualToString:@""]) {
        
        [callSpecialistButton setHidden:NO];
    
    } else [callSpecialistButton setHidden:YES];
}

- (void)underlineLabelTapped {
    
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    [self performSegueWithIdentifier:@"toReadMore" sender:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    [questionTextView resignFirstResponder];
    [self ShowButoon];
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    isTextView = false;
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    isTextView = true;
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
        return NO;
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSLog(@"%lu", (unsigned long)newLength);
    
    // detect backspace button
    if ([string isEqualToString:@""]) {
        
        if (newLength >= 15 && textField == emailTextField) {
            textField.font = [UIFont systemFontOfSize:++font_size];
            textField.frame = CGRectMake(textField.frame.origin.x + 1.5, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height);
        }
        else if (newLength >= 7)
            textField.frame = CGRectMake(textField.frame.origin.x + 8.5, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height);
        
    
    } else if (![string isEqualToString:@""] && newLength <= 25) {
        
        if (newLength > 15 && textField == emailTextField) {
            textField.font = [UIFont systemFontOfSize:--font_size];
            textField.frame = CGRectMake(textField.frame.origin.x - 1.5, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height);
        }
        else if (newLength > 7 && newLength <= 20)
            textField.frame = CGRectMake(textField.frame.origin.x - 8.5, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height);
        
    }
    
    if (textField == emailTextField)
        return newLength <= 25;
    
    return newLength <= 20;
}

- (void)keyboardWasShown:(NSNotification *)aNotification {
    
    if (screenHeight == 480 && isTextView) {
        
        callSpecialistTableView.frame = CGRectMake(callSpecialistTableView.frame.origin.x, callSpecialistTableView.frame.origin.y - 140, callSpecialistTableView.frame.size.width, callSpecialistTableView.frame.size.height);
        topInfoView.frame = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y - 140, topInfoView.frame.size.width, topInfoView.frame.size.height);
        questionTextView.frame = CGRectMake(questionTextView.frame.origin.x, questionTextView.frame.origin.y - 140, questionTextView.frame.size.width, questionTextView.frame.size.height);
        
        isTableViewWasMoved = false;
    
    } else if (screenHeight == 568 && isTextView) {
        
        callSpecialistTableView.frame = CGRectMake(callSpecialistTableView.frame.origin.x, callSpecialistTableView.frame.origin.y - 60, callSpecialistTableView.frame.size.width, callSpecialistTableView.frame.size.height);
        topInfoView.frame = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y - 60, topInfoView.frame.size.width, topInfoView.frame.size.height);
        questionTextView.frame = CGRectMake(questionTextView.frame.origin.x, questionTextView.frame.origin.y - 60, questionTextView.frame.size.width, questionTextView.frame.size.height);
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification {

    if (screenHeight == 480 && isTextView) {
        
        callSpecialistTableView.frame = CGRectMake(callSpecialistTableView.frame.origin.x, callSpecialistTableView.frame.origin.y + 140, callSpecialistTableView.frame.size.width, callSpecialistTableView.frame.size.height);
        topInfoView.frame = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y + 140, topInfoView.frame.size.width, topInfoView.frame.size.height);
        questionTextView.frame = CGRectMake(questionTextView.frame.origin.x, questionTextView.frame.origin.y + 140, questionTextView.frame.size.width, questionTextView.frame.size.height);
        
        isTableViewWasMoved = false;
    
    } else if (screenHeight == 568 && isTextView) {
        
        callSpecialistTableView.frame = CGRectMake(callSpecialistTableView.frame.origin.x, callSpecialistTableView.frame.origin.y + 60, callSpecialistTableView.frame.size.width, callSpecialistTableView.frame.size.height);
        topInfoView.frame = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y + 60, topInfoView.frame.size.width, topInfoView.frame.size.height);
        questionTextView.frame = CGRectMake(questionTextView.frame.origin.x, questionTextView.frame.origin.y + 60, questionTextView.frame.size.width, questionTextView.frame.size.height);
    }

}

- (void)SetCorrectSizeForComponent {
    
    backgroundImage.translatesAutoresizingMaskIntoConstraints = YES;
    callSpecialistTableView.translatesAutoresizingMaskIntoConstraints = YES;
    topInfoView.translatesAutoresizingMaskIntoConstraints = YES;
    questionTextView.translatesAutoresizingMaskIntoConstraints = YES;
    
    CGRect correctBackgroundFrame;
    CGRect correctCallSpecialistTableFrame;
    CGRect correctTopInfoView;
    CGRect correctQuestionTextViewFrame;
    
    if (screenHeight == 480)
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 320.0f, 367.0f);
    else if (screenHeight == 568)
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 320.0f, 454.0f);
    
    else if (screenHeight == 667) {
        
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 375.0f, 553.0f);
        correctCallSpecialistTableFrame = CGRectMake(callSpecialistTableView.frame.origin.x, callSpecialistTableView.frame.origin.y, 375, callSpecialistTableView.frame.size.height);
        correctTopInfoView = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y, 375, topInfoView.frame.size.height);
        correctQuestionTextViewFrame = CGRectMake(questionTextView.frame.origin.x, questionTextView.frame.origin.y, 375 - (questionTextView.frame.origin.x * 2), questionTextView.frame.size.height);
        
        callSpecialistTableView.frame = correctCallSpecialistTableFrame;
        topInfoView.frame = correctTopInfoView;
        questionTextView.frame = correctQuestionTextViewFrame;
        
    } else {
        
        correctBackgroundFrame = CGRectMake(0.0f, 64.0f, 414.0f, 623.0f);
        correctCallSpecialistTableFrame = CGRectMake(callSpecialistTableView.frame.origin.x, callSpecialistTableView.frame.origin.y, 414, callSpecialistTableView.frame.size.height);
        correctTopInfoView = CGRectMake(topInfoView.frame.origin.x, topInfoView.frame.origin.y, 414, topInfoView.frame.size.height);
        correctQuestionTextViewFrame = CGRectMake(questionTextView.frame.origin.x, questionTextView.frame.origin.y, 414 - (questionTextView.frame.origin.x * 2), questionTextView.frame.size.height);
        
        callSpecialistTableView.frame = correctCallSpecialistTableFrame;
        topInfoView.frame = correctTopInfoView;
        questionTextView.frame = correctQuestionTextViewFrame;
    }
    
    backgroundImage.frame = correctBackgroundFrame;
    [self.view insertSubview:backgroundImage atIndex:0];
}

@end
