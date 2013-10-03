//
//  SocialSampleViewController.h
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

#import "SocialSampleAppDelegate.h"

@interface SocialSampleViewController : UIViewController<YOSRequestDelegate>
{
@private
	UILabel				*nicknameLabel;
    
    YOSSession					*session;
	NSMutableDictionary			*oauthResponse;
	BOOL						launchDefault;
    SocialSampleAppDelegate *appDelegate;
}

@property (nonatomic, retain) IBOutlet UILabel *nicknameLabel;

- (void)setUserProfile:(NSDictionary *)data;

-(IBAction)yahooButtonClicked:(id)sender;

-(IBAction)getDetailsClicked:(id)sender;

@property BOOL launchDefault;
@property (nonatomic, readwrite, retain) YOSSession *session;
@property (nonatomic, readwrite, retain) NSMutableDictionary *oauthResponse;
- (void)getUserProfile;
- (void)createYahooSession;
- (void)handlePostLaunch;

@end

