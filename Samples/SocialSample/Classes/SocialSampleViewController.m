//
//  SocialSampleViewController.m
//  SocialSample
//
//  Created by Zach Graves on 3/18/09.
//  Copyright (c) 2009 Yahoo! Inc. All rights reserved.
//  
//  The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license.
//

#import "SocialSampleViewController.h"
#import "NSString+SBJSON.h"
#import "YOSUser.h"
#import "YOSUserRequest.h"


@implementation SocialSampleViewController

@synthesize nicknameLabel;
@synthesize session;
@synthesize launchDefault;
@synthesize oauthResponse;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//[nicknameLabel setText:@"loading..."];
}

- (void)setUserProfile:(NSDictionary *)data
{
	NSString *welcomeText = [NSString stringWithFormat:@"Hey %@ %@!", 
							 [[data objectForKey:@"profile"] objectForKey:@"givenName"],
							 [[data objectForKey:@"profile"] objectForKey:@"familyName"]];
		
	[nicknameLabel setText:welcomeText];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


/*
 
 
 -(IBAction)yahooButtonClicked:(id)sender
 {
 launchDefault = YES;
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
	
	if(appDelegate.oauthResponse)
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


-(IBAction)getDetailsClicked:(id)sender
{
    
    [self getUserProfile];
}

- (void)getUserProfile
{
	// initialize the profile request with our user.
    
    NSLog(@"session in social view controller is  %@",self.session);
    
	YOSUserRequest *userRequest = [YOSUserRequest requestWithSession:self.session];
	
	// get the users profile
	[userRequest fetchProfileWithDelegate:self];
}

- (void)requestDidFinishLoading:(YOSResponseData *)data
{
	NSDictionary *userProfile = [[data.responseText JSONValue] objectForKey:@"profile"];
	 NSLog(@"userProfile   %@",[userProfile description]);
	if(userProfile)
    {
		[self setUserProfile:userProfile];
	}
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    launchDefault = NO;
	
	if (!url)
    {
		return NO;
	}
	
	NSArray *pairs = [[url query] componentsSeparatedByString:@"&"];
	NSMutableDictionary *response = [NSMutableDictionary dictionary];
	
	for (NSString *item in pairs) {
		NSArray *fields = [item componentsSeparatedByString:@"="];
		NSString *name = [fields objectAtIndex:0];
		NSString *value = [[fields objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		
		[response setObject:value forKey:name];
	}
	
	self.oauthResponse = response;
	
	[self createYahooSession];
	
	return YES;
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
	launchDefault = NO;
	
	if (!url)
    {
		return NO;
	}
	
	NSArray *pairs = [[url query] componentsSeparatedByString:@"&"];
	NSMutableDictionary *response = [NSMutableDictionary dictionary];
	
	for (NSString *item in pairs) {
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc
{
    [super dealloc];
}

@end
