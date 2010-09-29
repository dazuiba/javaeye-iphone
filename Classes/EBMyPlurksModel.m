#import "EBMyPlurksModel.h"
#import "ObjectivePlurk.h"

@implementation EBMyPlurksModel

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more 
{
	NSDictionary *userInfo = [[ObjectivePlurk sharedInstance] currentUserInfo];
	NSString *uid = [userInfo valueForKey:@"uid"];
	if ([uid isKindOfClass:[NSNumber class]]) {
		uid = [(NSNumber *)uid stringValue];
	}
	
	if (!self.isLoading) {
		if (!more) {
			[[ObjectivePlurk sharedInstance] retrieveMessagesWithDateOffset:nil limit:30 user:uid isResponded:NO isPrivate:NO delegate:self userInfo:nil];
			loading = YES;
			[self didStartLoad];
		}
		else {
			NSDictionary *message = [messages lastObject];
			NSString *posted = [message valueForKey:@"posted"]; 		
			NSDate *date = [self dateFromString:posted];
			[[ObjectivePlurk sharedInstance] retrieveMessagesWithDateOffset:date limit:30 user:uid isResponded:NO isPrivate:NO delegate:self userInfo:nil];
			loading = YES;
			loadingMore = YES;
			[self didStartLoad];
		}
	}
}

@end
