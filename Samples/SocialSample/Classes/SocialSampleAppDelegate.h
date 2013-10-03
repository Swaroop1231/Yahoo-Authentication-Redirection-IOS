//
//  SocialSampleAppDelegate.h
//  SocialSample
//
//  Created by Zach Graves on 3/18/09.
//  Copyright (c) 2009 Yahoo! Inc. All rights reserved.
//  
//  The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license.
//

#import <UIKit/UIKit.h>
#import "YOSSession.h"
#import "YOSRequestClient.h"
#import "YOSRequestToken.h"
#import "YOSTokenStore.h"
#import "YOSAuthRequest.h"


@class SocialSampleViewController;

@interface SocialSampleAppDelegate : NSObject <UIApplicationDelegate,YOSRequestDelegate> {
    UIWindow *window;
    SocialSampleViewController *viewController;
	
	YOSSession					*session;
	NSMutableDictionary			*oauthResponse;
	BOOL						launchDefault;
}

@property BOOL launchDefault;
@property (nonatomic, readwrite, retain) YOSSession *session;
@property (nonatomic, readwrite, retain) NSMutableDictionary *oauthResponse;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SocialSampleViewController *viewController;

@property(nonatomic,strong) YOSAuthRequest *appdelegateRequestToken;
@property(nonatomic,strong) NSURL *authorizationUrl;

- (void)getUserProfile;
- (void)createYahooSession;
- (void)handlePostLaunch;

@end

