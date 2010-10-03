#import "EBTimelineModel.h"
#import "ObjectiveJEye.h"

@interface EBTimelineDataSource : TTListDataSource 
{
	id timelineModel;
}

- (id)initWithModelClass:(Class)inClass;

@end
