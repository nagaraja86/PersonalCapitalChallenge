//
//  NSString+CheckNull.m
//  PersonalCapitalChallenge
//
//  Created by Velicharla, Nagaraja on 10/25/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//

#import "NSString+CheckNull.h"

#import <UIKit/UIKit.h>


@implementation NSString (CheckNull)

-(NSString *)returnEmptyStringForNull
{
    if (self == NULL || [self length] == 0)
    {
        return @"";
    }
    else
    {
        return self;
    }
}

@end
