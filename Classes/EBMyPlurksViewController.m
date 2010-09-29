#import "EBMyPlurksViewController.h"
#import "EBTimelineDataSource.h"
#import "EBMyPlurksModel.h"

@implementation EBMyPlurksViewController

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query
{
	self = [super initWithStyle:UITableViewStylePlain];
	if (self != nil) {
		self.title = NSLocalizedString(@"My Pluks", @"");
	}
	return self;
}

- (void)createModel 
{
	self.dataSource = [[[EBTimelineDataSource alloc] initWithModelClass:[EBMyPlurksModel class]] autorelease];
}

@end
