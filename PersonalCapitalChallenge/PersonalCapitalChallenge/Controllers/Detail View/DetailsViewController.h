//
//  DetailsViewController.h
//  PersonalCapitalChallenge
//
//  Created by Velicharla, Nagaraja on 10/25/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKUIDelegate.h>
#import <WebKit/WKNavigationDelegate.h>
#import <WebKit/WKWebViewConfiguration.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController <WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate>
@property (strong, nonatomic) ItemModel *itemDetails;
@property (strong, nonatomic)WKWebView *wkWebView;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;

@end

NS_ASSUME_NONNULL_END
