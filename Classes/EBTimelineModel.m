#import "EBTimelineModel.h"

@implementation EBTimelineModel

- (void)dealloc
{
	[users release];
	[messages release];
	[dateFormatter release];
	[super dealloc];
}

- (id)init
{
	self = [super init];
	if (self != nil) {
		users = [[NSMutableDictionary alloc] init];
		messages = [[NSMutableArray alloc] init];
		loaded = NO;
	}
	return self;
}

- (NSDate *)parseDate:(NSString *)dateString
{
	// Setup Date & Formatter
	NSDate *date = nil;
	static NSDateFormatter *formatter = nil;
	if (!formatter) {
		NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
		formatter = [[NSDateFormatter alloc] init];
		[formatter setLocale:en_US_POSIX];
		[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		[en_US_POSIX release];
	}
	
	/*
	 * RFC3339
	 */
	
	NSString *RFC3339String = [[NSString stringWithString:dateString] uppercaseString];
	RFC3339String = [RFC3339String stringByReplacingOccurrencesOfString:@"Z" withString:@"-0000"];
	
	// Remove colon in timezone as iOS 4+ NSDateFormatter breaks
	// See https://devforums.apple.com/thread/45837
	if (RFC3339String.length > 20) {
		RFC3339String = [RFC3339String stringByReplacingOccurrencesOfString:@":"
																 withString:@""
																	options:0
																	  range:NSMakeRange(20, RFC3339String.length-20)];
	}
	
	//       2010/09/21 08:59:00 +0800
	if (!date) { // 1937-01-01T12:00:27
		[formatter setDateFormat:@"yyyy'/'MM'/'dd' 'HH':'mm':'ss ZZZ"];
		date = [formatter dateFromString:RFC3339String];
	}
	
	
	if (!date) { // 1996-12-19T16:39:57-0800
		[formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"];
		date = [formatter dateFromString:RFC3339String];
	}
	if (!date) { // 1937-01-01T12:00:27.87+0020
		[formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZZZ"];
		date = [formatter dateFromString:RFC3339String];
	}
	if (!date) { // 1937-01-01T12:00:27
		[formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
		date = [formatter dateFromString:RFC3339String];
	}
	if (date) return date;
	
	/*
	 * RFC822
	 */
	
	NSString *RFC822String = [[NSString stringWithString:dateString] uppercaseString];
	if (!date) { // Sun, 19 May 02 15:21:36 GMT
		[formatter setDateFormat:@"EEE, d MMM yy HH:mm:ss zzz"];
		date = [formatter dateFromString:RFC822String];
	}
	if (!date) { // Sun, 19 May 2002 15:21:36 GMT
		[formatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss zzz"];
		date = [formatter dateFromString:RFC822String];
	}
	if (!date) { // Sun, 19 May 2002 15:21 GMT
		[formatter setDateFormat:@"EEE, d MMM yyyy HH:mm zzz"];
		date = [formatter dateFromString:RFC822String];
	}
	if (!date) { // 19 May 2002 15:21:36 GMT
		[formatter setDateFormat:@"d MMM yyyy HH:mm:ss zzz"];
		date = [formatter dateFromString:RFC822String];
	}
	if (!date) { // 19 May 2002 15:21 GMT
		[formatter setDateFormat:@"d MMM yyyy HH:mm zzz"];
		date = [formatter dateFromString:RFC822String];
	}
	if (!date) { // 19 May 2002 15:21:36
		[formatter setDateFormat:@"d MMM yyyy HH:mm:ss"];
		date = [formatter dateFromString:RFC822String];
	}
	if (!date) { // 19 May 2002 15:21
		[formatter setDateFormat:@"d MMM yyyy HH:mm"];
		date = [formatter dateFromString:RFC822String];
	}
	if (date) return date;
	
	// Failed
	return nil;
}

- (NSDate *)dateFromString:(NSString *)string
{
	//  "Tue, 10 Aug 2010 16:12:31 GMT";
	if (!dateFormatter) {
		dateFormatter = [[NSDateFormatter alloc] init];
	}
	[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en"] autorelease]];
	[dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
	return [dateFormatter dateFromString:string];
}

- (NSString *)stringFromDate:(NSDate *)date
{
	if (!dateFormatter) {
		dateFormatter = [[NSDateFormatter alloc] init];
	}
	[dateFormatter setLocale:[NSLocale currentLocale]];
	[dateFormatter setDateStyle:kCFDateFormatterShortStyle];
	[dateFormatter setTimeStyle:kCFDateFormatterShortStyle];
	return [dateFormatter stringFromDate:date];
}


- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more 
{
	if (!self.isLoading) {
		if (!more) {
			if ([messages count]) {
				NSDictionary *message = [messages objectAtIndex:0];
				[[ObjectiveJEye sharedInstance] retrieveMessagesWithIDOffset:[message objectForKey:@"id"] limit:30 user:nil isResponded:NO isPrivate:NO delegate:self userInfo:nil];
				loadingMore = YES;
			}else {
				[[ObjectiveJEye sharedInstance] retrieveMessagesWithIDOffset:nil limit:30 user:nil isResponded:NO isPrivate:NO delegate:self userInfo:nil];
			}

			loading = YES;
			[self didStartLoad];
		}
		else {
			NSDictionary *message = [messages lastObject];
			NSString *id = [message valueForKey:@"id"]; 		
			[[ObjectiveJEye sharedInstance] retrieveMessagesWithIDOffset:id limit:30 user:nil isResponded:NO isPrivate:NO delegate:self userInfo:nil];
			loading = YES;
			loadingMore = YES;
			[self didStartLoad];
		}
	}
}

- (void)jeye:(ObjectiveJEye *)jeye didRetrieveMessages:(NSDictionary *)result
{
	if (!loadingMore) {
		[users removeAllObjects];
		[messages removeAllObjects];
	}
	//[users addEntriesFromDictionary:[result valueForKey:@"plurk_users"]];
	[messages addObjectsFromArray:[result valueForKey:@"array"]];	
	loading = NO;
	loaded = YES;
	wasLoadingMore = loadingMore;
	loadingMore = NO;
	[self didFinishLoad];
}
- (void)jeye:(ObjectiveJEye *)jeye didFailRetrievingMessages:(NSError *)error
{
	loading = NO;
	loaded = YES;
	loadingMore = NO;
	[self didFailLoadWithError:error];
}

- (NSArray *)messageItems
{
	NSMutableArray *array = [NSMutableArray array];
	for (NSDictionary *message in messages) {
		
		NSString *body = [message valueForKey:@"body"];
		NSString *rawDateString = [message valueForKey:@"created_at"];
		NSString *dateString = [self stringFromDate:[self parseDate:rawDateString]];

		NSDictionary *user = [message valueForKey:@"user"];
		NSString *name = [user valueForKey:@"name"];
		NSString *imageURL = [user valueForKey:@"logo"];
		
		EBTimelineItem *item = [EBTimelineItem itemWithUsername:name avatarImageURL:[ObjectivePlurkAPIURLString stringByAppendingString:imageURL] date:dateString message:body URL:nil];
		[array addObject:item];
	}
	
	TTTableMoreButton *moreButton = [TTTableMoreButton itemWithText:NSLocalizedString(@"More...", @"")];
	[array addObject:moreButton];
	
	return array;
}

- (BOOL)isLoaded
{
	return loaded;
}
- (BOOL)isLoading
{
	return loading;
}
- (BOOL)isLoadingMore
{
	return loadingMore;
}

@synthesize wasLoadingMore;


@end
