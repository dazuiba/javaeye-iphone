#import "EBLoginViewController.h"

@implementation EBLoginViewController

- (void)removeOutletsAndControls_EBLoginViewController
{
	TT_RELEASE_SAFELY(accountTextField);
	TT_RELEASE_SAFELY(passwordTextField);
	TT_RELEASE_SAFELY(footerView);
	TT_RELEASE_SAFELY(loginButton);
}

- (void)dealloc 
{
	[self removeOutletsAndControls_EBLoginViewController];
    [super dealloc];
}
- (void)viewDidUnload
{
	[super viewDidUnload];
	[self removeOutletsAndControls_EBLoginViewController];
}

#pragma mark -
#pragma mark UIViewContoller Methods

- (void)loadView 
{
    UITableView *aTableView = [[[UITableView alloc] initWithFrame:TTScreenBounds() style:UITableViewStyleGrouped] autorelease];
	aTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	aTableView.delegate = self;
	aTableView.dataSource = self;
	
	self.view = aTableView;
}  

- (void)viewDidLoad 
{
    [super viewDidLoad];
	if (!accountTextField) {
		accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 170, 30)];
	}
	accountTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	accountTextField.keyboardType = UIKeyboardTypeEmailAddress;
	accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	accountTextField.font = [UIFont systemFontOfSize:15.0];
	accountTextField.delegate = self;
	accountTextField.placeholder = NSLocalizedString(@"Your Plurk Account", @"");
	accountTextField.textColor = [UIColor blueColor];
	accountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
	accountTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	accountTextField.returnKeyType = UIReturnKeyNext;
	
	if (!passwordTextField) {
		passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 170, 30)];
	}
	passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	passwordTextField.secureTextEntry = YES;
	passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	passwordTextField.font = [UIFont systemFontOfSize:15.0];
	passwordTextField.delegate = self;
	passwordTextField.placeholder = NSLocalizedString(@"Your Password", @"");
	passwordTextField.textColor = [UIColor blueColor];
	passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
	passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	passwordTextField.returnKeyType = UIReturnKeyGo;
	
	UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)];
	self.navigationItem.leftBarButtonItem = cancelItem;
	[cancelItem release];
	
	if (!footerView) {
		footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 50.0)];
	}
	footerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	footerView.backgroundColor = self.view.backgroundColor;
	
	if (!loginButton) {
		loginButton = [[TTButton buttonWithStyle:@"toolbarButton:" title:NSLocalizedString(@"Login", @"")] retain];
		[loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
	}
	loginButton.frame = CGRectMake(10.0, 5.0, 300.0, 40.0);
	loginButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	loginButton.font = [UIFont boldSystemFontOfSize:16.0];

	[footerView addSubview:loginButton];
	self.tableView.tableFooterView = footerView;
	self.tableView.scrollEnabled = NO;
	
	self.title = NSLocalizedString(@"Login", @"");
}
- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
	[accountTextField becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated 
{
	[super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated 
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -

- (IBAction)cancelAction:(id)sender
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}
- (IBAction)loginAction:(id)sender
{
	NSString *account = [accountTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	if (![account length]) {
		ZBAlert(NSLocalizedString(@"Please input your login name.", @""));
		[accountTextField becomeFirstResponder];
		return;
	}
	
	NSString *password = passwordTextField.text;
	if (![password length]) {
		ZBAlert(NSLocalizedString(@"Please input your password.", @""));
		[passwordTextField becomeFirstResponder];
		return;
	}	
	[[ObjectivePlurk sharedInstance] loginWithUsername:account password:password delegate:self userInfo:nil];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	switch (indexPath.row) {
		case 0:
			cell.textLabel.text = NSLocalizedString(@"Account:", @"");
			cell.accessoryView = accountTextField;
			break;
		case 1:
			cell.textLabel.text = NSLocalizedString(@"Password:", @"");
			cell.accessoryView = passwordTextField;
			break;
			
		default:
			break;
	}
    return cell;
}

#pragma mark -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if ([textField isEqual:accountTextField]) {
		[passwordTextField becomeFirstResponder];
	}
	else if ([textField isEqual:passwordTextField]) {
		[self loginAction:self];
	}	
	return YES;
}

#pragma mark -

- (void)plurk:(ObjectivePlurk *)plurk didLoggedIn:(NSDictionary *)result
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}
- (void)plurk:(ObjectivePlurk *)plurk didFailLoggingIn:(NSError *)error
{
	ZBAlertWithMesage(NSLocalizedString(@"Failed to login!", @""), [error localizedDescription]);
}

@end

