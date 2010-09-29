#import "EBTimelineItem.h"

@interface EBTimelineCell : TTTableViewCell 
{
	id object;
	
	TTImageView *imageView;
	TTStyledTextLabel *userNameLabel;
	TTStyledTextLabel *messageLabel;
	TTStyledTextLabel *dateLabel;
}

@end
