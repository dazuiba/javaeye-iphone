#import "EBAppDelegate.h"
#import "EBLoginViewController.h"
#import "EBTimelineViewController.h"
#import "EBMyPlurksViewController.h"
#import "EBPrivatePlurksViewController.h"
#import "BERespondedPlurksViewController.h"
#import "EBTabbarController.h"

@implementation EBAppDelegate

- (void)dealloc 
{
	[super dealloc];
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[ObjectivePlurk sharedInstance].APIKey = PLURK_API_KEY;

	TTNavigator *navigator = [TTNavigator navigator];
	navigator.supportsShakeToReload = YES;
	navigator.persistenceMode = TTNavigatorPersistenceModeAll;
	UIWindow *window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
	window.backgroundColor = [UIColor blackColor];
	navigator.window = window;

	TTURLMap* map = navigator.URLMap;
	[map from:@"*" toViewController:[TTWebController class]];
	[map from:@"banana://login" toModalViewController:[EBLoginViewController class]];
	[map from:@"banana://timeline" toViewController:[EBTimelineViewController class]];
	[map from:@"banana://my" toViewController:[EBMyPlurksViewController class]];
	[map from:@"banana://private" toViewController:[EBPrivatePlurksViewController class]];
	[map from:@"banana://plurk" toViewController:[EBTabbarController class]];
	[map from:@"banana://responded" toViewController:[BERespondedPlurksViewController class]];
	
	[navigator.window makeKeyAndVisible];
	[navigator openURLs:@"banana://plurk", nil];
	
	if (![[ObjectivePlurk sharedInstance] resume]) {	
		[navigator openURLs:@"banana://login", nil];
	}

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
}
- (void)applicationDidEnterBackground:(UIApplication *)application 
{
}
- (void)applicationWillEnterForeground:(UIApplication *)application 
{
}
- (void)applicationDidBecomeActive:(UIApplication *)application 
{
}
- (void)applicationWillTerminate:(UIApplication *)application
{
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application 
{
}


//@synthesize window;
//@synthesize navigationController;


@end

