//
//  AppDelegate.m
//  Справочник электрика
//
//  Created by Admin on 13.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize automationDesignationLocalFilePath;
@synthesize automationLowCurrentCabelLocalFilePath;
@synthesize automationTemperatureLocalFilePath;
@synthesize automationDesignationOfCommDeviceLocalFilePath;
@synthesize automateITPLocalFilePath;
@synthesize automationExceptsFromSNIPFilePath;
@synthesize automationPowerAndCurrentEngineFilePath;
@synthesize automationResistanceThermometrsFilePath;
@synthesize automationTableOfFuseLinksFilePath;

@synthesize electricanDesignationLocalFilePath;
@synthesize electricanPowerCabelLocalFilePath;
@synthesize electricanSNIPLocalFilePath;
@synthesize electricanGroundLocalFilePath;
@synthesize electricanSecurityLocalFilePath;
@synthesize electricanTableComsumersLocalFilePath;
@synthesize electricanConcatenateWiresLocalFilePath;
@synthesize electricanCollectCabinetLocalFilePath;
@synthesize electricanCircuitBreakersLocalFilePath;
@synthesize electricanTableOfCableCrossSectionsLocalFilePath;
@synthesize electricanProtectionIPLocalFilePath;
@synthesize electricanCablesForShipbuildersLocalFilePath;
@synthesize electricanWiringAtHomeLocalFilePath;

@synthesize aboutProjectLocalFilePath;
@synthesize aboutProjectResponsibilityLocalFilePath;

@synthesize onlineHelpLocalFilePath;

@synthesize isBanner;
@synthesize isShowBanner;
@synthesize iAd;

@synthesize SEGMENTED_FRAME_IPHONE4_IPHONE5;
@synthesize SEGMENTED_FRAME_IPHONE6;
@synthesize SEGMENTED_FRAME_IPHONE6PLUS;
@synthesize IMAGE_FRAME_IPHONE4_IPHONE5;
@synthesize IMAGE_FRAME_IPHONE6;
@synthesize IMAGE_FRAME_IPHONE6PLUS;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Указываем какой tab грузить по умолчанию
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    tabBarController.selectedIndex = 1;
    
    SEGMENTED_FRAME_IPHONE4_IPHONE5 = CGRectMake(215, 15, 90, 30);
    SEGMENTED_FRAME_IPHONE6 = CGRectMake(270, 15, 90, 30);
    SEGMENTED_FRAME_IPHONE6PLUS = CGRectMake(309, 15, 90, 30);
    IMAGE_FRAME_IPHONE4_IPHONE5 = CGRectMake(214, 14, 91, 35);
    IMAGE_FRAME_IPHONE6 = CGRectMake(269, 14, 92, 35);
    IMAGE_FRAME_IPHONE6PLUS = CGRectMake(308, 14, 92, 35);
    
    // Перед началом стартовой страницы, загружаем весь контент
    automationDesignationLocalFilePath = [[NSBundle mainBundle] pathForResource:@"авт. Обозначения на схеме" ofType:@"html"];
    automationLowCurrentCabelLocalFilePath = [[NSBundle mainBundle] pathForResource:@"слаботочый кабель" ofType:@"html"];
    automationTemperatureLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Температурные датчики" ofType:@"html"];
    automationDesignationOfCommDeviceLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Условные обозначения. Коммутационные устройства и контактные соединения (ГОСТ 2.755-87) _ electromonter.info" ofType:@"html"];
    automateITPLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Автоматизация ИТП" ofType:@"html"];
    automationExceptsFromSNIPFilePath = [[NSBundle mainBundle] pathForResource:@"Выдержки из СНиП" ofType:@"html"];
    automationPowerAndCurrentEngineFilePath = [[NSBundle mainBundle] pathForResource:@"Мощность и токи двигателя" ofType:@"html"];
    automationTableOfFuseLinksFilePath = [[NSBundle mainBundle] pathForResource:@"Таблица плавких вставок" ofType:@"html"];
    automationResistanceThermometrsFilePath = [[NSBundle mainBundle] pathForResource:@"Сопротивление термометров" ofType:@"html"];

    electricanDesignationLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Обозначения" ofType:@"html"];
    electricanPowerCabelLocalFilePath = [[NSBundle mainBundle] pathForResource:@"силовой кабель" ofType:@"html"];
    electricanSNIPLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Э Выдержки из СНиП" ofType:@"html"];
    electricanGroundLocalFilePath = [[NSBundle mainBundle] pathForResource:@"заземление" ofType:@"html"];
    electricanSecurityLocalFilePath = [[NSBundle mainBundle] pathForResource:@"основы безопасности" ofType:@"html"];
    electricanTableComsumersLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Таблица потребителей" ofType:@"html"];
    electricanConcatenateWiresLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Соединение проводов" ofType:@"html"];
    electricanCollectCabinetLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Собираем шкаф" ofType:@"html"];
    electricanCircuitBreakersLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Автоматические выключатели" ofType:@"html"];
    electricanTableOfCableCrossSectionsLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Таблица сечений кабеля" ofType:@"html"];
    electricanProtectionIPLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Защита IP" ofType:@"html"];
    electricanCablesForShipbuildersLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Кабель для судостроителей" ofType:@"html"];
    electricanWiringAtHomeLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Электромонтаж у себя дома" ofType:@"html"];
    
    aboutProjectLocalFilePath = [[NSBundle mainBundle] pathForResource:@"О проекте" ofType:@"html"];
    aboutProjectResponsibilityLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Ответственность" ofType:@"html"];
    
    onlineHelpLocalFilePath = [[NSBundle mainBundle] pathForResource:@"Справка онлайн помощника" ofType:@"html"];
    
    [[UINavigationBar appearance] setBarTintColor:[self colorWithHexString:@"5294c3"]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    isBanner = true;
    isShowBanner = true;
    
    NSLog(@"AppDelegate");
    iAd = [[ADBannerView alloc] init];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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

- (BOOL)CheckInternetConnection {
    
    NSURL *scriptUrl = [NSURL URLWithString:@"https://www.google.ru"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data)
        return YES;
    else
        return NO;
}

@end
