#import "EBRespondedPlurksModel.h"

@implementation EBRespondedPlurksModel

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more 
{
	if (!self.isLoading) {
		if (!more) {
			[[ObjectivePlurk sharedInstance] retrieveMessagesWithDateOffset:nil limit:30 user:nil isResponded:YES isPrivate:NO delegate:self userInfo:nil];
			loading = YES;
			[self didStartLoad];
		}
		else {
			NSDictionary *message = [messages lastObject];
			NSString *posted = [message valueForKey:@"posted"]; 		
			NSDate *date = [self dateFromString:posted];
			[[ObjectivePlurk sharedInstance] retrieveMessagesWithDateOffset:date limit:30 user:nil isResponded:YES isPrivate:NO delegate:self userInfo:nil];
			loading = YES;
			loadingMore = YES;
			[self didStartLoad];
		}
	}
}

@end
