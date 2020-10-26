//
//  FeedCustomCollectionViewCell.m
//  PersonalCapitalChallenge
//
//  Created by Velicharla, Nagaraja on 10/24/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//

#import "FeedCustomCollectionViewCell.h"

@implementation FeedCustomCollectionViewCell

@synthesize feedImage = _feedImage;
@synthesize feedTitleLabel = _feedTitleLabel;
@synthesize feedDescriptionLabel = _feedDescriptionLabel;

//Change width of the cell
- (void)setCellWidth:(CGFloat) width {
    self.cellWidthConstraint.constant = width;
    self.cellWidthConstraint.active = YES;
}
//Init with frame for setting views
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.cellWidthConstraint = [self.contentView.widthAnchor constraintEqualToConstant:0.f];
    
    if (self) {
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        self.clipsToBounds = true;
        self.autoresizesSubviews = true;
        // Image
        self.feedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
        self.feedImage.translatesAutoresizingMaskIntoConstraints = NO;
        self.feedImage.contentMode = UIViewContentModeScaleAspectFill;
        self.feedImage.clipsToBounds = true;
        [self.feedImage setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleWidth];
        
        [self.contentView addSubview:self.feedImage];
        // Title
        self.feedTitleLabel = [[UILabel alloc] init];
        self.feedTitleLabel.textColor = [UIColor blackColor];
        self.feedTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.feedTitleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
        self.feedTitleLabel.numberOfLines = 1;
        self.feedTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        // Description
        self.feedDescriptionLabel = [[UILabel alloc] init];
        self.feedDescriptionLabel.textColor = [UIColor blackColor];
        self.feedDescriptionLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        self.feedDescriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.feedDescriptionLabel.numberOfLines = 2;
        self.feedDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.feedTitleLabel];
        [self.contentView addSubview:self.feedDescriptionLabel];
        
        [self setUpConstraintesForView];
    }
    return self;
}

//Added constraints to the sub views
-(void)setUpConstraintesForView
{
    NSDictionary *views = NSDictionaryOfVariableBindings(_feedImage, _feedTitleLabel,_feedDescriptionLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_feedImage]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_feedTitleLabel]-8-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_feedDescriptionLabel]-8-|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_feedImage(<=1@100)]-2-[_feedTitleLabel(<=50@199)]-2-[_feedDescriptionLabel(<=30@100)]-|" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:nil views:@{ @"contentView": self.contentView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:0 metrics:nil views:@{ @"contentView": self.contentView}]];
}
@end
