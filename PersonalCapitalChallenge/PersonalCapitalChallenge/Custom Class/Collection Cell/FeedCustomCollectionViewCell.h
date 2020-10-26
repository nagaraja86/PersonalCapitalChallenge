//
//  FeedCustomCollectionViewCell.h
//  PersonalCapitalChallenge
//
//  Created by Velicharla, Nagaraja on 10/24/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedCustomCollectionViewCell : UICollectionViewCell

- (void)setCellWidth:(CGFloat) width;

@property (nonatomic, strong) UIImageView *feedImage;
@property (nonatomic, strong) UILabel *feedTitleLabel;
@property (nonatomic, strong) UILabel *feedDescriptionLabel;
@property (nonatomic, strong) NSLayoutConstraint *cellWidthConstraint;

@end

NS_ASSUME_NONNULL_END
