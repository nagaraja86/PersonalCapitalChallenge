//
//  ItemModel.h
//  PersonalCapitalChallenge
//
//  Created by Velicharla, Nagaraja on 10/24/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "NSString+CheckNull.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemModel : NSObject

@property (nonatomic, strong) NSString *itemID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *encoded_title;
@property (nonatomic, strong) NSString *featured_image;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *insight_summary;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *summary_html;
@property (nonatomic, strong) NSString *content_html;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
@end

NS_ASSUME_NONNULL_END
