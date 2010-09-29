#import "EBTimelineItem.h"

@implementation EBTimelineItem

- (void)dealloc
{
	TT_RELEASE_SAFELY(username);
	TT_RELEASE_SAFELY(avatarImageURL);
	TT_RELEASE_SAFELY(message);
	TT_RELEASE_SAFELY(URL);
	TT_RELEASE_SAFELY(dateString);
	[super dealloc];
}


+ (id)itemWithUsername:(NSString *)inUsername avatarImageURL:(NSString *)inAvatarImageURL date:(NSString *)inDateString message:(NSString *)inMessage URL:(NSString *)inURL;
{
	EBTimelineItem *item = [[EBTimelineItem alloc] init];
	item.username = inUsername;
	item.avatarImageURL = inAvatarImageURL;
	item.dateString = inDateString;
	item.message = inMessage;
	item.URL = inURL;
	return [item autorelease];
}

- (id)init
{
	self = [super init];
	if (self != nil) {
		username = nil;
		avatarImageURL = nil;
		message = nil;
		URL = nil;
		dateString = nil;
	}
	return self;
}

- (TTStyledText *)styledMessage
{
	return [TTStyledText textFromXHTML:self.message lineBreaks:YES URLs:YES];
}

@synthesize username;
@synthesize avatarImageURL;
@synthesize message;
@synthesize URL;
@synthesize dateString;

@end
