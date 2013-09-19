//
//  ViewController.h
//  AssetsAccessorDemo
//
//  Created by Shintaro Morikawa on 2013/09/14.
//
//

#import <UIKit/UIKit.h>
#import "AssetsAccessor.h"
#import "TableViewController.h"
#import "CollectionViewController.h"

@interface ViewController : UIViewController <AssetsAccessorDelegate, MyImagePickerControllerDelegate> {
    AssetsAccessor *assetsAccessor;
    NSURL *imageURL;
}

@property (strong, nonatomic) IBOutlet UIButton *selectButton;
@property (strong, nonatomic) IBOutlet UIButton *getButton;
@property (strong, nonatomic) IBOutlet UILabel *urlLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
