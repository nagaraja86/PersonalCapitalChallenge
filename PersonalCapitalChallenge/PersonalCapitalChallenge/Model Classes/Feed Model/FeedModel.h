//
//  FeedModel.h
//  PersonalCapitalChallenge
//
//  Created by Velicharla, Nagaraja on 10/24/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemModel.h"
#import "NSString+CheckNull.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedModel : NSObject

@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *home_page_url;
@property (nonatomic, strong) NSString *feedDescription;
@property (nonatomic, strong) NSString *feed_url;
@property (nonatomic, strong) NSString *user_comment;
@property (nonatomic, strong) NSMutableArray<ItemModel *> *items;

-(instancetype)FillModelWithJSONDictionary:(NSDictionary*)dictionary;
-(void)removeAll;
@end

NS_ASSUME_NONNULL_END
