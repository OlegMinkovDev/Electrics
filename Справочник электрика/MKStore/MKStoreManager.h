//
//  StoreManager.h
//  MKSync
//
//  Created by Mugunth Kumar on 17-Oct-09.
//  Copyright 2009 MK Inc. All rights reserved.
//  mugunthkumar.com

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "MKStoreObserver.h"
#import "AboutProjectViewController.h"

@protocol MKStoreKitDelegate <NSObject>
@optional
- (void)productAPurchased;
- (void)failed;
@end

@interface MKStoreManager : NSObject<SKProductsRequestDelegate> {

	NSMutableArray *purchasableObjects;
	MKStoreObserver *storeObserver;
	id<MKStoreKitDelegate> delegate;
    NSTimer *myTimer;
}

@property (nonatomic, retain) id<MKStoreKitDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *purchasableObjects;
@property (nonatomic, retain) MKStoreObserver *storeObserver;

- (void) requestProductData;

- (void) buyFeatureA;

// do not call this directly. This is like a private method
- (void) buyFeature:(NSString*) featureId;

-(void)paymentCanceled;

- (void) failedTransaction: (SKPaymentTransaction *)transaction;
-(void) provideContent: (NSString*) productIdentifier;

+ (MKStoreManager*)sharedManager;

+ (BOOL) featureAPurchased;

+(void) loadPurchases;
+(void) updatePurchases;

@end
