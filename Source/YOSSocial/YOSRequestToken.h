//
//  YOSRequestToken.h
//  YOSSocial
//
//  Created by Zach Graves on 2/14/09.
//  Copyright (c) 2009 Yahoo! Inc. All rights reserved.
//  
//  The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license.
//

#import "YOAuthToken.h"

/**
 * YOSRequestToken is a sub-class of YOAuthToken that contains the request token key and secret, along 
 * with extensions for the <code>request_auth</code> URL and token expiration dates.
 */
@interface YOSRequestToken : YOAuthToken
{
@protected
	/**
	 * Returns the URL generated by the service-provider to redirect the user to allow access to the application.
	 */
	NSString		*requestAuthUrl;
	
	/**
	 * Returns an integer of the UNIX time that the token will expire. 
	 */
	NSInteger		tokenExpires;
	
	/**
	 * Returns a NSDate representing the expiry date of this token. 
	 */
	NSDate			*tokenExpiresDate;
	
	/**
	 * Returns a Boolean indicating whether the callback was received by the service provider.
	 */
	BOOL			callbackConfirmed;
}

@property (nonatomic, readwrite, retain) NSString *requestAuthUrl;
@property (nonatomic, readwrite) NSInteger tokenExpires;
@property (nonatomic, readwrite, retain) NSDate *tokenExpiresDate;
@property (nonatomic, readwrite) BOOL callbackConfirmed;

/**
 * Returns a new request token for the specified response data object.
 * @param responseData		A NSData object containing the response from the service provider.
 * @return					The initialized request token.
 */
+ (YOSRequestToken *)tokenFromResponse:(NSData *)responseData;

/**
 * Returns a new request token for the specified dictionary.
 * @param tokenDictionary	A dictionary object containing the request token data.
 * @return					The initialized request token.
 */
+ (YOSRequestToken *)tokenFromStoredDictionary:(NSDictionary *)tokenDictionary;

/**
 * Creates a mutable dictionary containing the token data. 
 * @return					A dictionary containing request token variables. 
 */
- (NSMutableDictionary *)tokenAsDictionary;

/**
 * Returns true if the token has expired.
 */
- (BOOL)tokenHasExpired;

@end
