//
//  ItemModel.m
//  PersonalCapitalChallenge
//
//  Created by Velicharla, Nagaraja on 10/24/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel
//
@synthesize itemID;
@synthesize title;
@synthesize url;
@synthesize category;
@synthesize encoded_title;
@synthesize featured_image;
@synthesize summary;
@synthesize insight_summary;
@synthesize content;
@synthesize summary_html;
@synthesize content_html;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    if ((self = [super init]))
    {
        self.itemID = [dictionary[@"id"] returnEmptyStringForNull];
        self.title = [dictionary[@"title"]returnEmptyStringForNull];
        self.url = [dictionary[@"url"]returnEmptyStringForNull];
        self.category = [dictionary[@"category"]returnEmptyStringForNull];
        self.encoded_title = [dictionary[@"encoded_title"]returnEmptyStringForNull];
        self.featured_image = [dictionary[@"featured_image"]returnEmptyStringForNull];
        self.summary = [dictionary[@"summary"]returnEmptyStringForNull];
        self.insight_summary = [dictionary[@"insight_summary"]returnEmptyStringForNull];
        self.content = [dictionary[@"content"]returnEmptyStringForNull];
        self.summary_html = [dictionary[@"summary_html"]returnEmptyStringForNull];
        self.content_html = [dictionary[@"content_html"]returnEmptyStringForNull];
    }
    return self;
}
@end
