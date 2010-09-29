@interface EBTimelineItem : TTTableItem 
{
	NSString *username;
	NSString *avatarImageURL;
	NSString *message;
	NSString *URL;
	NSString *dateString;
}

+ (id)itemWithUsername:(NSString *)inUsername avatarImageURL:(NSString *)inAvatarImageURL date:(NSString *)inDateString message:(NSString *)inMessage URL:(NSString *)inURL;

@property (retain, nonatomic) NSString *username;
@property (retain, nonatomic) NSString *avatarImageURL;
@property (retain, nonatomic) NSString *message;
@property (readonly, nonatomic) TTStyledText *styledMessage;
@property (retain, nonatomic) NSString *URL;
@property (retain, nonatomic) NSString *dateString;

@end
