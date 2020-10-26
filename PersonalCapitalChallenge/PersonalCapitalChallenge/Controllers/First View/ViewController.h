//
//  ViewController.h
//  PersonalCapitalChallenge
//
//  Created by Velicharla, Nagaraja on 10/24/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedModel.h"
#import "ItemModel.h"
#import "LazyLoadingUIImageView.h"
#import "FeedCustomCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "DetailsViewController.h"

@interface ViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) FeedModel *feedObj;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@end

