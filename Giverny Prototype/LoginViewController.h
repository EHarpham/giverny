//
//  LoginViewController.h
//  Giverny Prototype
//
//  Created by Edward Harpham on 24/11/2013.
//  Copyright (c) 2013 Giverny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
- (IBAction)searchButton:(id)sender;
- (IBAction)addButton:(id)sender;
- (IBAction)deleteButton:(id)sender;


@end
