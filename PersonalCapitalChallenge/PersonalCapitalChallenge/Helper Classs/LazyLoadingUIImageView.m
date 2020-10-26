//
//  LazyLoadingUIImageView.m
//  PersonalCapitalChallenge
//
//  Created by Velicharla, Nagaraja on 10/24/20.
//  Copyright © 2020 Velicharla, Nagaraja. All rights reserved.
//

#import "LazyLoadingUIImageView.h"

@implementation UIImageView (LazyLoadingUIImageView)

-(void)setImageFromUrl:(NSString *)urlString atViewIndex:(NSIndexPath *)indexPath
{
    if (urlString.length > 0)
    {
        BOOL doesImageExist = [self lookForLocalImage:urlString atViewIndex:(NSIndexPath *)indexPath];
        if (doesImageExist)
        {
            return;
        }
        else
        {
            [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (error != nil)
                {
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        self.image = [UIImage imageNamed:@"placeholder.png"];
                        NSLog(@"description %@",[error description]);
                        return;
                    });
                    return;
                }
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    //save image locally and show it
                    [self saveImageWithName:urlString atViewIndex:indexPath imageInData:data];
                    self.image = [[UIImage alloc] initWithData:data];
                    return;
                });
                }] resume];
        }
    }
    else
    {
        self.image = [UIImage imageNamed:@"placeholder.png"];
    }
}
// save image locally after downloading it first time
-(void)saveImageWithName:(NSString*)imageName atViewIndex:(NSIndexPath *)indexPath imageInData:(NSData*)data
{
    NSString *fileName = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%ld%ld",imageName.lastPathComponent,(long)indexPath.section,(long)indexPath.row]];
    NSString *fullPath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] createFileAtPath:fullPath contents:data attributes:nil];
}

// look for loacl immage before downloading image
-(BOOL)lookForLocalImage:(NSString *)urlString atViewIndex:(NSIndexPath *)indexPath
{
    NSString *fileName = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%ld%ld",urlString.lastPathComponent,(long)indexPath.section,(long)indexPath.row]];
    NSString *fullPath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath])
    {
        UIImage *localImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
        if (localImage != nil)
        {
            self.image = localImage;
            return true;
        }
        else
        {
            return false;
        }
    }
    else
    {
        return false;
    }
}

@end
