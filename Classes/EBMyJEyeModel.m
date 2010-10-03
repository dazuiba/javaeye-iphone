#import "EBMyJEyeModel.h"
#import "ObjectiveJEye.h"

@implementation EBMyJEyeModel

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more 
{
	NSDictionary *userInfo = [[ObjectiveJEye sharedInstance] currentUserInfo];
	NSString *uid = [userInfo valueForKey:@"uid"];
	if ([uid isKindOfClass:[NSNumber class]]) {
		uid = [(NSNumber *)uid stringValue];
	}
	
	if (!self.isLoading) {
		if (!more) {
			[[ObjectiveJEye sharedInstance] retrieveMessagesWithIDOffset:nil limit:30 user:uid isResponded:NO isPrivate:NO delegate:self userInfo:nil];
			loading = YES;
			[self didStartLoad];
		}
		else {
			NSDictionary *message = [messages lastObject];
			NSString *posted = [message valueForKey:@"posted"]; 		
			NSDate *date = [self dateFromString:posted];
			[[ObjectiveJEye sharedInstance] retrieveMessagesWithIDOffset:date limit:30 user:uid isResponded:NO isPrivate:NO delegate:self userInfo:nil];
			loading = YES;
			loadingMore = YES;
			[self didStartLoad];
		}
	}
}

@end
