//
//  DetailsViewController.m
//  PersonalCapitalChallenge
//
//  Created by Velicharla, Nagaraja on 10/25/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//

#import "DetailsViewController.h"


@interface DetailsViewController ()
@end

@implementation DetailsViewController

#pragma mark - Lifecycle Method
- (void)loadView
{
    [super loadView];
    //Set up Wk Webview and add to view
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    _wkWebView.UIDelegate = self;
    _wkWebView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_wkWebView];
    
    //Set the constraints of the view
    NSDictionary *views = NSDictionaryOfVariableBindings(_wkWebView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_wkWebView]-8-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_wkWebView]-8-|" options:0 metrics:nil views:views]];
    [self.view bringSubviewToFront:_wkWebView];
    [self showActivityIndicator];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Set the title of the screen
    self.navigationItem.title = [[NSString alloc] initWithString:self.itemDetails.title];
    //Start Activity indicator
    [_spinner startAnimating];
    //Load webview with content
    NSURL *url=[NSURL URLWithString:self.itemDetails.url];
    [_wkWebView loadHTMLString:self.itemDetails.content_html baseURL:url];
    _wkWebView.allowsBackForwardNavigationGestures = true;
    //Stop Activity indicator
    [_spinner stopAnimating];
}


#pragma mark - Private/Public Methods
-(void)showActivityIndicator
{
    //Create activity indicator view and add as subview to the view
     _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    _spinner.backgroundColor = [UIColor lightGrayColor];
    _spinner.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    _spinner.hidesWhenStopped = true;
    [self.view addSubview:_spinner];
}
#pragma mark - DataSource Methods
#pragma mark - Delegate Methods

@end
