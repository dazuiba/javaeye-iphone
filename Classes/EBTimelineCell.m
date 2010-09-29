#import "EBTimelineCell.h"

static CGFloat kHPadding = 10;  
static CGFloat kVPadding = 10;  
static CGFloat kImageWidth = 40;  
static CGFloat kImageHeight = 40; 

@implementation EBTimelineCell

- (void)dealloc 
{
	TT_RELEASE_SAFELY(object);
	TT_RELEASE_SAFELY(imageView);
	TT_RELEASE_SAFELY(userNameLabel);
	TT_RELEASE_SAFELY(messageLabel);
	TT_RELEASE_SAFELY(dateLabel);
	[super dealloc];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier 
{
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		imageView = [[TTImageView alloc] initWithFrame:CGRectZero]; 
		imageView.style = [TTSolidBorderStyle styleWithColor:[UIColor blackColor] width:1.0 next:[TTSolidFillStyle styleWithColor:[UIColor grayColor] next:nil]];
		[self.contentView addSubview:imageView];  
		userNameLabel = [[TTStyledTextLabel alloc] initWithFrame:CGRectZero];
		userNameLabel.font = [UIFont boldSystemFontOfSize:14.0];
		[self.contentView addSubview:userNameLabel];
		messageLabel = [[TTStyledTextLabel alloc] initWithFrame:CGRectZero];
		messageLabel.contentMode = UIViewContentModeLeft;
		[self.contentView addSubview:messageLabel];
		dateLabel = [[TTStyledTextLabel alloc] initWithFrame:CGRectZero];
		dateLabel.font = [UIFont systemFontOfSize:12.0];
		dateLabel.textColor = [UIColor grayColor];
		[self.contentView addSubview:dateLabel];
		self.accessoryType = UITableViewCellAccessoryNone;
	}  
	return self;  
}  

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)inObject 
{
	EBTimelineItem *timelineItem = (EBTimelineItem *)inObject;
	TTStyledText* text = [timelineItem styledMessage];
	if (!text.font) {
		text.font = TTSTYLEVAR(font);
	}
	text.width = tableView.bounds.size.width - kHPadding * 2 - kImageWidth - 10.0;
	CGFloat h = text.height + 50.0;
	if (h < kImageHeight) {
		h = kImageHeight;
	}	
	return h + kVPadding * 2;
}

- (void)layoutSubviews 
{
	[super layoutSubviews];
	imageView.frame = CGRectMake(kHPadding, kVPadding, kImageWidth, kImageHeight);
	userNameLabel.frame = CGRectMake(kHPadding + kImageWidth + 10.0 , kVPadding, self.bounds.size.width - kHPadding * 2 - kImageWidth - 10.0, 20.0);
	messageLabel.frame = CGRectMake(kHPadding + kImageWidth + 10.0 , kVPadding + 30.0, self.bounds.size.width - kHPadding * 2 - kImageWidth - 10.0, self.bounds.size.height - 40.0 - kVPadding * 2);
	dateLabel.frame = CGRectMake(kHPadding + kImageWidth + 10.0 , self.bounds.size.height - 13.0 - kVPadding, self.bounds.size.width - kHPadding * 2 - kImageWidth - 10.0, 15);
}

- (void)didMoveToSuperview 
{
	[super didMoveToSuperview];
	if (self.superview) {
		imageView.backgroundColor = self.backgroundColor;
		userNameLabel.backgroundColor = self.backgroundColor;
		messageLabel.backgroundColor = self.backgroundColor;
		dateLabel.backgroundColor = self.backgroundColor;
	}
}

- (id)object 
{
	return object;
}

- (void)setObject:(id)inObject 
{
	id tmp = object;
	object = [inObject retain];
	[tmp release];

	EBTimelineItem *timelineItem = (EBTimelineItem *)inObject;
    imageView.urlPath = timelineItem.avatarImageURL;
	userNameLabel.text = [TTStyledText textFromXHTML:timelineItem.username];
	messageLabel.text = [timelineItem styledMessage];
	dateLabel.text = [TTStyledText textFromXHTML:timelineItem.dateString];
}


@end
