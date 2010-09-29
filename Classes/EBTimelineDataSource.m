#import "EBTimelineDataSource.h"
#import "EBTimelineCell.h"

@implementation EBTimelineDataSource

- (void)dealloc 
{
	TT_RELEASE_SAFELY(timelineModel);	
	[super dealloc];
}

- (id)initWithModelClass:(Class)inClass
{
	self = [super init];
	if (self != nil) {
		timelineModel = [[inClass alloc] init];
	}
	return self;
}

- (id<TTModel>)model 
{
	return timelineModel;
}

- (void)tableViewDidLoadModel:(UITableView *)tableView 
{
	EBTimelineModel *currentModel = (EBTimelineModel *)timelineModel;
	self.items = [NSMutableArray arrayWithArray:currentModel.messageItems];
	if ([self.items count] && !currentModel.wasLoadingMore) {
		[tableView scrollRectToVisible:CGRectMake(0, 0, tableView.frame.size.width, 100) animated:YES];
	}
}

- (NSString *)titleForLoading:(BOOL)reloading 
{
	if (reloading) {
		return NSLocalizedString(@"Updating...", @"");
	}
	else {
		return NSLocalizedString(@"Loading ...", @"");
	}
}
- (NSString *)titleForEmpty 
{
	return NSLocalizedString(@"No posts found.", @"");
}
- (NSString *)subtitleForError:(NSError *)error
{
	return NSLocalizedString(@"Sorry, there was an error loading the Plurk stream.", @"");
}

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object
{	
    if ([object isKindOfClass:[EBTimelineItem class]]) {  
        return [EBTimelineCell class];  
    }
	return [super tableView:tableView cellClassForObject:object];
}  

- (void)tableView:(UITableView*)tableView prepareCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath 
{
    cell.accessoryType = UITableViewCellAccessoryNone;  
}  


@end
