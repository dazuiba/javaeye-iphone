//
//  JEUser.h
//  javaeye-iphone
//
//  Created by sam on 10-10-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JEUser : NSObject {
	NSString *name;
	NSString *uid;
	NSString *password;
	NSString *domain;
}
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *uid;
@property(nonatomic,retain)NSString *password;
@property(nonatomic,retain)NSString *domain;

@end
