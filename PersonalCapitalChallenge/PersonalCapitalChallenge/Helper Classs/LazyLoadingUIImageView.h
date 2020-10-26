//
//  LazyLoadingUIImageView.h
//  PersonalCapitalChallenge
//
//  Created by Velicharla, Nagaraja on 10/24/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (LazyLoadingUIImageView)

-(void)setImageFromUrl:(NSString *)urlString atViewIndex:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
