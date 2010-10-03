#import "BERespondedPlurksViewController.h"
#import "EBTimelineDataSource.h"
#import "EBRespondedPlurksModel.h"

@implementation BERespondedPlurksViewController

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query
{
	self = [super initWithStyle:UITableViewStylePlain];
	if (self != nil) {
		self.title = NSLocalizedString(@"favorite", @"");
		UIImage* image = [UIImage imageNamed:@"favorite.png"];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:3] autorelease];
	}
	return self;
}

- (void)createModel 
{
	self.dataSource = [[[EBTimelineDataSource alloc] initWithModelClass:[EBRespondedPlurksModel class]] autorelease];
}

@end
