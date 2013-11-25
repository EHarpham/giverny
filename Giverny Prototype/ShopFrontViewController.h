//
//  ShopFrontViewController.h
//  Giverny Prototype
//
//  Created by Edward Harpham on 24/11/2013.
//  Copyright (c) 2013 Giverny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductPopViewController.h"
#import "ProductCell.h"


@interface ShopFrontViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,ProductPopViewControllerDelegate, UIPopoverControllerDelegate>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITextField *tfUserText;
@property (weak, nonatomic) IBOutlet UICollectionView *productsCollectionView;

//BANNER STUFF
@property (nonatomic, retain) NSArray *bannerImages;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;



//POPOVER STUFF
@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;
@property (strong, nonatomic) ProductPopViewController *pvc;


@end
