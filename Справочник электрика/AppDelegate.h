//
//  AppDelegate.h
//  Справочник электрика
//
//  Created by Admin on 13.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, ADBannerViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *automationDesignationLocalFilePath;
@property (strong, nonatomic) NSString *automationLowCurrentCabelLocalFilePath;
@property (strong, nonatomic) NSString *automationTemperatureLocalFilePath;
@property (strong, nonatomic) NSString *automationDesignationOfCommDeviceLocalFilePath;
@property (strong, nonatomic) NSString *automateITPLocalFilePath;
@property (strong, nonatomic) NSString *automationExceptsFromSNIPFilePath;
@property (strong, nonatomic) NSString *automationPowerAndCurrentEngineFilePath;
@property (strong, nonatomic) NSString *automationResistanceThermometrsFilePath;
@property (strong, nonatomic) NSString *automationTableOfFuseLinksFilePath;

@property (strong, nonatomic) NSString *electricanPowerCabelLocalFilePath;
@property (strong, nonatomic) NSString *electricanDesignationLocalFilePath;
@property (strong, nonatomic) NSString *electricanSNIPLocalFilePath;
@property (strong, nonatomic) NSString *electricanGroundLocalFilePath;
@property (strong, nonatomic) NSString *electricanSecurityLocalFilePath;
@property (strong, nonatomic) NSString *electricanTableComsumersLocalFilePath;
@property (strong, nonatomic) NSString *electricanConcatenateWiresLocalFilePath;
@property (strong, nonatomic) NSString *electricanCollectCabinetLocalFilePath;
@property (strong, nonatomic) NSString *electricanCircuitBreakersLocalFilePath;
@property (strong, nonatomic) NSString *electricanTableOfCableCrossSectionsLocalFilePath;
@property (strong, nonatomic) NSString *electricanProtectionIPLocalFilePath;
@property (strong, nonatomic) NSString *electricanCablesForShipbuildersLocalFilePath;
@property (strong, nonatomic) NSString *electricanWiringAtHomeLocalFilePath;

@property (strong, nonatomic) NSString *aboutProjectLocalFilePath;
@property (strong, nonatomic) NSString *aboutProjectResponsibilityLocalFilePath;

@property (strong, nonatomic) NSString *onlineHelpLocalFilePath;

@property (assign, nonatomic) CGRect SEGMENTED_FRAME_IPHONE4_IPHONE5;
@property (assign, nonatomic) CGRect SEGMENTED_FRAME_IPHONE6;
@property (assign, nonatomic) CGRect SEGMENTED_FRAME_IPHONE6PLUS;
@property (assign, nonatomic) CGRect IMAGE_FRAME_IPHONE4_IPHONE5;
@property (assign, nonatomic) CGRect IMAGE_FRAME_IPHONE6;
@property (assign, nonatomic) CGRect IMAGE_FRAME_IPHONE6PLUS;

@property (assign, nonatomic) BOOL isBanner;
@property (assign, nonatomic) BOOL isShowBanner;
@property (strong, nonatomic) ADBannerView *iAd;

- (UIColor*)colorWithHexString:(NSString*)hex;
- (BOOL)CheckInternetConnection;

@end

