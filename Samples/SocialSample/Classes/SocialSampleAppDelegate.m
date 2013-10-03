//
//  SocialSampleAppDelegate.m
//  SocialSample
//
//  Created by Zach Graves on 3/18/09.
//  Copyright (c) 2009 Yahoo! Inc. All rights reserved.
//  
//  The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license.
//

#import "SocialSampleAppDelegate.h"
#import "SocialSampleViewController.h"

#import "YOSUser.h"
#import "YOSUserRequest.h"
#import "NSString+SBJSON.h"
#import "YOSAuthRequest.h"
@implementation SocialSampleAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize session;
@synthesize launchDefault;
@synthesize oauthResponse;
@synthesize authorizationUrl;
@synthesize appdelegateRequestToken;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	launchDefault = YES;
	[self performSelector:@selector(handlePostLaunch) withObject:nil afterDelay:0.0];
}

/*
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    launchDefault = NO;
	
	if (!url)
    {
		return NO;
	}
	
	NSArray *pairs = [[url query] componentsSeparatedByString:@"&"];
	NSMutableDictionary *response = [NSMutableDictionary dictionary];
	
	for (NSString *item in pairs)
    {
		NSArray *fields = [item componentsSeparatedByString:@"="];
		NSString *name = [fields objectAtIndex:0];
		NSString *value = [[fields objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		
		[response setObject:value forKey:name];
	}
	
	self.oauthResponse = response;
	
	[self createYahooSession];
	
	return YES;

}
*/

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url 
{
	launchDefault = NO;
	
	if (!url)
    {
		return NO; 
	}
	
	NSArray *pairs = [[url query] componentsSeparatedByString:@"&"];
	NSMutableDictionary *response = [NSMutableDictionary dictionary];
	
	for (NSString *item in pairs)
    {
		NSArray *fields = [item componentsSeparatedByString:@"="];
		NSString *name = [fields objectAtIndex:0];
		NSString *value = [[fields objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		
		[response setObject:value forKey:name];
	}
	
	self.oauthResponse = response;
    /*
    YOSRequestToken *requestToken = [YOSRequestToken tokenFromResponse:response.data];

    
    YOSAuthRequest *tokenAuthRequest = [YOSAuthRequest requestWithSession:session];
     
    
    
    NSString *tempStr=[self.oauthResponse valueForKey:@"oauth_verifier"];
    
    YOSAccessToken *newAccessToken = [tokenAuthRequest fetchAccessToken:self.appdelegateRequestToken  withVerifier:tempStr];
    
    
    NSLog(@"New Access token is %@",newAccessToken);
 */
    NSLog(@"oauthResponse in app delegate is %@",self.oauthResponse);
    
[self createYahooSession];
	
	return YES;
}

- (void)handlePostLaunch
{
    
    
    NSLog(@"----Default launch is %c",self.launchDefault);
    
    
	if(self.launchDefault)
    {
		[self createYahooSession];
	}
}

- (void)createYahooSession
{
	// create session with consumer key, secret and application id
	// set up a new app here: https://developer.yahoo.com/dashboard/createKey.html
	// because the default values here won't work
	self.session = [YOSSession sessionWithConsumerKey:@"dj0yJmk9VXI4M21RWGtjNmlKJmQ9WVdrOWMxZDZaR1V6TldNbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD04MQ--"
                                    andConsumerSecret:@"927035f3fd779525fbbdfeca8b5f2ad5db9cde72"
                                     andApplicationId:@"sWzde35c"];
	
	if(oauthResponse)
    {
		NSString *verifier = [self.oauthResponse valueForKey:@"oauth_verifier"];
        NSLog(@"Verifier in userdefaults is %@",verifier);
        
		[self.session setVerifier:verifier];
	}
	
	BOOL hasSession = [self.session resumeSession];
	
    
    NSLog(@"@@@@@@@@@@@@@@ Has Session is %c",hasSession);
    
	if(!hasSession)
    {
        // NSString *myString = [appDelegate.authorizationUrl absoluteString];
        //http://www.myappdemo.net/test/yredirect.php
        //http://www.yahoomail.com
        
        //  NSURL *urlstr=[NSURL URLWithString:@"http://www.myappdemo.net/test/yredirect.php"];
        [self.session sendUserToAuthorizationWithCallbackUrl:@"http://www.myappdemo.net/test/yredirect.php"];
        
        //[self getUserProfile];
        
		//[self.session sendUserToAuthorizationWithCallbackUrl:appDelegate.authorizationUrl];
	} else
    {
		[self getUserProfile];
	}
    
}

- (void)getUserProfile
{
	// initialize the profile request with our user.
	YOSUserRequest *userRequest = [YOSUserRequest requestWithSession:self.session];
	// get the users profile
	[userRequest fetchProfileWithDelegate:self];
}

- (void)requestDidFinishLoading:(YOSResponseData *)data
{
	NSDictionary *userProfile = [[data.responseText JSONValue] objectForKey:@"profile"];
	 NSLog(@"User Profile is %@",[userProfile description]);
	if(userProfile)
    {
		[viewController setUserProfile:userProfile];
	}
}


- (void)dealloc
{
    [viewController release];
    [window release];
    [super dealloc];
}


@end
