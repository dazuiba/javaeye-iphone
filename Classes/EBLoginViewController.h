@interface EBLoginViewController : UITableViewController <UITextFieldDelegate>
{
	UITextField *accountTextField;
	UITextField *passwordTextField;
	UIView *footerView;
	TTButton *loginButton;
}

- (IBAction)cancelAction:(id)sender;
- (IBAction)loginAction:(id)sender;

@end
