#import "ObjectivePlurk.h"
#import "EBTimelineItem.h"

@interface EBTimelineModel : TTModel 
{
	NSMutableDictionary *users;
	NSMutableArray *messages;
	NSDateFormatter *dateFormatter;
	BOOL loading;
	BOOL loaded;
	BOOL loadingMore;
	BOOL wasLoadingMore;
}

- (NSDate *)dateFromString:(NSString *)string;
- (NSString *)stringFromDate:(NSDate *)date;

@property (readonly) NSArray *messageItems;
@property (readonly) BOOL wasLoadingMore;

@end
