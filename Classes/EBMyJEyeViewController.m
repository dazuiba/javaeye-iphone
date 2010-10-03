#import "EBMyJEyeViewController.h"
#import "EBTimelineDataSource.h"
#import "EBMyJEyeModel.h"

@implementation EBMyJEyeViewController

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query
{
	self = [super initWithStyle:UITableViewStylePlain];
	if (self != nil) {
		self.title = NSLocalizedString(@"news", @"");
		UIImage* image = [UIImage imageNamed:@"news.png"];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:3] autorelease];

	}
	return self;
}

- (void)createModel 
{
	self.dataSource = [[[EBTimelineDataSource alloc] initWithModelClass:[EBMyJEyeModel class]] autorelease];
}

@end
