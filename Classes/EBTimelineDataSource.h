#import "EBTimelineModel.h"
#import "ObjectivePlurk.h"

@interface EBTimelineDataSource : TTListDataSource 
{
	id timelineModel;
}

- (id)initWithModelClass:(Class)inClass;

@end
