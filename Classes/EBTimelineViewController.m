#import "EBTimelineViewController.h"
#import "EBTimelineDataSource.h"
#import "EBTimelineModel.h"

@implementation EBTimelineViewController

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query
{
	self = [super initWithStyle:UITableViewStylePlain];
	if (self != nil) {
		self.title = NSLocalizedString(@"All Plurks", @"");
	}
	return self;
}

- (void)loadView
{
    [super loadView];    	
    self.variableHeightRows = YES;
}  

- (void)viewDidLoad
{
	[super viewDidLoad];
}

- (void)createModel 
{
	self.dataSource = [[[EBTimelineDataSource alloc] initWithModelClass:[EBTimelineModel class]] autorelease];
}

- (id<UITableViewDelegate>)createDelegate 
{
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end
