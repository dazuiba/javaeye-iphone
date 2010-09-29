//
//  EBTabbarController.m
//  ExplosiveBanana
//
//  Created by zonble on 8/11/10.
//  Copyright 2010 Lithoglyph Inc. All rights reserved.
//

#import "EBTabbarController.h"

@implementation EBTabbarController

- (void)viewDidLoad
{
	[self setTabURLs:[NSArray arrayWithObjects:@"banana://timeline",
					  @"banana://my",
					  @"banana://private",
					  @"banana://responded",
					  nil]];
}


@end
