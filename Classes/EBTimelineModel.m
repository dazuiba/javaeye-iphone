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
			[[ObjectivePlurk sharedInstance] retrieveMessagesWithDateOffset:nil limit:30 user:nil isResponded:NO isPrivate:NO delegate:self userInfo:nil];
			loading = YES;
			[self didStartLoad];
		}
		else {
			NSDictionary *message = [messages lastObject];
			NSString *posted = [message valueForKey:@"posted"]; 		
			NSDate *date = [self dateFromString:posted];
			[[ObjectivePlurk sharedInstance] retrieveMessagesWithDateOffset:date limit:30 user:nil isResponded:NO isPrivate:NO delegate:self userInfo:nil];
			loading = YES;
			loadingMore = YES;
			[self didStartLoad];
		}
	}
}

- (void)plurk:(ObjectivePlurk *)plurk didRetrieveMessages:(NSDictionary *)result
{
	if (!loadingMore) {
		[users removeAllObjects];
		[messages removeAllObjects];
	}
	[users addEntriesFromDictionary:[result valueForKey:@"plurk_users"]];
	[messages addObjectsFromArray:[result valueForKey:@"plurks"]];	
	loading = NO;
	loaded = YES;
	wasLoadingMore = loadingMore;
	loadingMore = NO;
	[self didFinishLoad];
}
- (void)plurk:(ObjectivePlurk *)plurk didFailRetrievingMessages:(NSError *)error
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
		NSString *ownerID = [message valueForKey:@"owner_id"];
		if ([ownerID isKindOfClass:[NSNumber class]]) {
			ownerID = [(NSNumber *)ownerID stringValue];
		}
		NSDictionary *userDictionary = [users valueForKey:ownerID];
		NSString *name = [userDictionary valueForKey:@"display_name"];
		BOOL hasProfileImage = [[userDictionary valueForKey:@"has_profile_image"] boolValue];
		NSString *avatar = [userDictionary valueForKey:@"avatar"];
		if ([avatar isKindOfClass:[NSNumber class]]) {
			avatar = [(NSNumber *)avatar stringValue];			
		}
		NSString *html = [message valueForKey:@"content"];
		
		NSString *imageURL = [[ObjectivePlurk sharedInstance] imageURLStringForUser:ownerID size:OPMediumUserProfileImageSize hasProfileImage:hasProfileImage avatar:avatar];
		NSString *posted = [message valueForKey:@"posted"]; 		
		NSDate *date = [self dateFromString:posted];
		NSString *dateString = [self stringFromDate:date];
		EBTimelineItem *item = [EBTimelineItem itemWithUsername:name avatarImageURL:imageURL date:dateString message:html URL:nil];
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
