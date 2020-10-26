//
//  FeedModel.m
//  PersonalCapitalChallenge
//
//  Created by Velicharla, Nagaraja on 10/24/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//

#import "FeedModel.h"

@implementation FeedModel

@synthesize version;
@synthesize title;
@synthesize home_page_url;
@synthesize feedDescription;
@synthesize feed_url;
@synthesize user_comment;
@synthesize items;

- (instancetype)initWithJSONDictionary:(NSDictionary*)dictionary
{
    if ((self = [super init]))
    {
        
    }
    return self;
}
-(instancetype)FillModelWithJSONDictionary:(NSDictionary*)dictionary
{
    self.version = [dictionary[@"title"] returnEmptyStringForNull];
    self.title = [dictionary[@"title"] returnEmptyStringForNull];
    self.home_page_url = [dictionary[@"home_page_url"] returnEmptyStringForNull];
    self.feedDescription = [dictionary[@"description"] returnEmptyStringForNull];
    self.feed_url = [dictionary[@"feed_url"] returnEmptyStringForNull];
    self.user_comment = [dictionary[@"user_comment"] returnEmptyStringForNull];
    
    NSMutableArray *itemsArrayObj = [[NSMutableArray alloc] initWithCapacity:4];
    for (NSDictionary* itemObject in dictionary[@"items"])
    {
        ItemModel *innerObject = [[ItemModel alloc] initWithDictionary:itemObject];
        [itemsArrayObj addObject:innerObject];
    }
    self.items = [[NSMutableArray alloc] initWithArray:itemsArrayObj];
    return self;
}

-(void)removeAll
{
    [self.items removeAllObjects];
}
@end

