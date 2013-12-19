//
//  PaymentViewController.h
//  Giverny Prototype
//
//  Created by Edward Harpham on 25/11/2013.
//  Copyright (c) 2013 Giverny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stripe.h"
#import <AFNetworking/AFNetworking.h>


@interface PaymentViewController : UIViewController

@property (strong, nonatomic) STPCard* stripeCard;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *address1TextField;
@property (weak, nonatomic) IBOutlet UITextField *address2TextField;
@property (weak, nonatomic) IBOutlet UITextField *address3TextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *postCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *cvcTextField;
@property (weak, nonatomic) IBOutlet UITextField *expDateYearTextField;
@property (weak, nonatomic) IBOutlet UITextField *expDateMonthTextField;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;


@property (strong, nonatomic) AFJSONRequestOperation* httpOperation;


- (IBAction)completeButton:(id)sender;

@end
