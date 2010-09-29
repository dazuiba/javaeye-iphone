#import "BERespondedPlurksViewController.h"
#import "EBTimelineDataSource.h"
#import "EBRespondedPlurksModel.h"

@implementation BERespondedPlurksViewController

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query
{
	self = [super initWithStyle:UITableViewStylePlain];
	if (self != nil) {
		self.title = NSLocalizedString(@"Responded", @"");
	}
	return self;
}

- (void)createModel 
{
	self.dataSource = [[[EBTimelineDataSource alloc] initWithModelClass:[EBRespondedPlurksModel class]] autorelease];
}

@end
