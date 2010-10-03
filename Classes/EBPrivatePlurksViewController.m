#import "EBPrivatePlurksViewController.h"
#import "EBTimelineDataSource.h"
#import "EBPrivatePlurksModel.h"

@implementation EBPrivatePlurksViewController

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query
{
	self = [super initWithStyle:UITableViewStylePlain];
	if (self != nil) {
		self.title = NSLocalizedString(@"messages", @"");
		UIImage* image = [UIImage imageNamed:@"messages.png"];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:3] autorelease];	}
		return self;
}

- (void)createModel 
{
	self.dataSource = [[[EBTimelineDataSource alloc] initWithModelClass:[EBPrivatePlurksModel class]] autorelease];
}

@end
