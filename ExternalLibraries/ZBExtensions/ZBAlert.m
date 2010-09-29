void ZBAlert(NSString *title)
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismisss", @"") otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

void ZBAlertWithMesage(NSString *title, NSString *message)
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismisss", @"") otherButtonTitles:nil];
	[alertView show];
	[alertView release];	
}