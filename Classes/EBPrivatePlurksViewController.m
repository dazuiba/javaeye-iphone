#import "EBPrivatePlurksViewController.h"
#import "EBTimelineDataSource.h"
#import "EBPrivatePlurksModel.h"

@implementation EBPrivatePlurksViewController

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query
{
	self = [super initWithStyle:UITableViewStylePlain];
	if (self != nil) {
		self.title = NSLocalizedString(@"Private", @"");
	}
	return self;
}

- (void)createModel 
{
	self.dataSource = [[[EBTimelineDataSource alloc] initWithModelClass:[EBPrivatePlurksModel class]] autorelease];
}

@end
