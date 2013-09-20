//
//  AssetsAccessor.m
//
//  Created by Shintaro Morikawa on 2013/09/14.
//
//

#import "AssetsAccessor.h"

@implementation AssetsAccessor

// This static variable is shared among some AssetsAccessor instances.
static ALAssetsLibrary *assetsLibrary;

- (id)init {
    if (self = [super init]) {
        if(assetsLibrary==nil) {
            assetsLibrary = [[ALAssetsLibrary alloc] init];
        }
        _assetsLibrary = assetsLibrary;
                
        isGettingMultipleAssets = NO;
    }
    return self;
}

- (id)initWithDelegate:(id<AssetsAccessorDelegate>)delegate {
    self = [self init];
    self.delegate = delegate;
    return self;
}

#pragma mark - Methods for getting assets by URL asynchronously

- (void)getAssetByURL:(NSURL *)assetURL{
    if (!isGettingMultipleAssets) {
        [assetsLibrary assetForURL:assetURL
                       resultBlock:^(ALAsset *asset) {
                           if (asset) {
                               if([self.delegate respondsToSelector:@selector(assetDidLoadByURL:)]){
                                   [self.delegate assetDidLoadByURL:asset];
                               }
                           } else {
                               NSLog(@"AssetsAccessor: asset not found by url.");
                           }
                       }
                      failureBlock:^(NSError *error) {
                          if([self.delegate respondsToSelector:@selector(assetDidFailLoadWithError:)]){
                              [self.delegate assetDidFailLoadWithError:error];
                          }
                          NSLog(@"AssetsAccessor: exception in accessing assets by url. %@", error);
                      }];
    } else {
        [assetsLibrary assetForURL:assetURL
                       resultBlock:^(ALAsset *asset) {
                           if (asset) {
                               [assetsArray addObject:asset];
                           } else {
                               numURLs--;
                               NSLog(@"AssetsAccessor: asset not found by url.");
                           }
                           
                           if (assetsArray.count == numURLs) {
                               isGettingMultipleAssets = NO;
                               if([self.delegate respondsToSelector:@selector(assetsDidLoadByURLs:)]){
                                   [self.delegate assetsDidLoadByURLs:assetsArray];
                               }
                           }
                       }
                      failureBlock:^(NSError *error) {
                          numURLs--;
                          if (assetsArray.count == numURLs) {
                              isGettingMultipleAssets = NO;
                          }
                          
                          if([self.delegate respondsToSelector:@selector(assetDidFailLoadWithError:)]){
                              [self.delegate assetDidFailLoadWithError:error];
                          }
                          NSLog(@"AssetsAccessor: exception in accessing assets by url. %@", error);
                      }];
    }
}

- (void)getAssetsByURLs:(NSArray *)assetURLs{
    if (isGettingMultipleAssets) {
        NSLog(@"cannot perform 'getAssetsByURLs:' until the privious process is complete.");
        return;
    }
    
    if (assetsArray == nil) {
        assetsArray = [[NSMutableArray alloc] init];
    } else {
        [assetsArray removeAllObjects];
    }
    
    isGettingMultipleAssets = YES;
    numURLs = assetURLs.count;
    
    for (NSURL *url in assetURLs) {
        [self getAssetByURL:url];
    }
}

#pragma mark - Method for getting AssetsGroups asynchronously

- (void)getAssetsGroupsWithTypes:(ALAssetsGroupType)groupTypes{
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:groupTypes
                                 usingBlock:^(ALAssetsGroup *group, BOOL *stop){
                                     if (group) {
                                         [groups addObject:group];
                                     } else {
                                         if([self.delegate respondsToSelector:@selector(assetsGroupsDidLoad:)]){
                                             [self.delegate assetsGroupsDidLoad:groups];
                                         }
                                     }
                                 }
                               failureBlock:^(NSError *error){
                                   NSLog(@"AssetsAccessor: exception in accessing assets group. %@", error);
                               }];
}

#pragma mark - Method for getting Assets from a specific AssetsGroup asynchronously

- (void)getAssetsFromGroup:(ALAssetsGroup *)group withFilter:(ALAssetsFilter *)filter{
    NSMutableArray *assets = [[NSMutableArray alloc] init];
    [group setAssetsFilter:filter];
    [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset) {
            [assets addObject:asset];
        } else {
            if([self.delegate respondsToSelector:@selector(assetsDidLoadByGroup:)]){
                [self.delegate assetsDidLoadByGroup:assets];
            }
        }
    }];
}

@end
