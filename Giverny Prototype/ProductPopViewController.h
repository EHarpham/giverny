//
//  ProductPopViewController.h
//  Giverny
//
//  Created by Edward Harpham on 23/11/2013.
//  Copyright (c) 2013 Giverny. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProductPopViewControllerDelegate;

@interface ProductPopViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *tfNewData;
@property (weak) id <ProductPopViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *strPassedValue;



- (IBAction)goBack: (id)sender;


@end

@protocol ProductPopViewControllerDelegate <NSObject>

@required

- (void)dismissPop: (NSString *)value;

@end