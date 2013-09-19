//
//  TableViewController.h
//  AssetsAccessorDemo
//
//  Created by 森川慎太郎 on 2013/09/19.
//
//

#import <UIKit/UIKit.h>
#import "AssetsAccessor.h"
#import "CollectionViewController.h"

@interface TableViewController : UITableViewController <AssetsAccessorDelegate, UIAlertViewDelegate> {
    AssetsAccessor *assetsAccessor;
}

@property (nonatomic, retain) id parent;
@property (nonatomic, retain) NSArray *groups;

@end
