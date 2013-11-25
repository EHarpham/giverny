//
//  PaymentViewController.m
//  Giverny Prototype
//
//  Created by Edward Harpham on 25/11/2013.
//  Copyright (c) 2013 Giverny. All rights reserved.
//

#import "PaymentViewController.h"
#import "Stripe.h"
#import "AFNetworking.h"
#import <AFNetworking/AFNetworking.h>



@interface PaymentViewController ()

#define STRIPE_TEST_PUBLIC_KEY @"pk_test_FXi2EietjcWUr8DQO9TlSsUh"
#define STRIPE_TEST_POST_URL @"http://50.17.254.139/cgi-bin/paymenttest.cgi"

@end

@implementation PaymentViewController

@synthesize stripeCard;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)completeButton:(id)sender {
    
    //1
    self.stripeCard = [[STPCard alloc] init];
    self.stripeCard.name = self.firstNameTextField.text;
    self.stripeCard.number = self.cardNumberTextField.text;
    self.stripeCard.cvc = self.cvcTextField.text;
    self.stripeCard.expMonth = [self.expDateMonthTextField integerValue];
    self.stripeCard.expYear = [self.expDateYearTextField integerValue];
    
    //2
    if ([self validateCustomerInfo]) {
        [self performStripeOperation];
    }
}

- (BOOL)validateCustomerInfo {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Please try again"
                                                     message:@"Please enter all required information"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    
    //1. Validate name & email
    if (self.firstNameTextField.text.length == 0 ||
        self.emailTextField.text.length == 0) {
        
        [alert show];
        return NO;
    }
    
    //2. Validate card number, CVC, expMonth, expYear
    NSError* error = nil;
    [self.stripeCard validateCardReturningError:&error];
    
    //3
    if (error) {
        alert.message = [error localizedDescription];
        [alert show];
        return NO;
    }
    
    return YES;
}

- (void)performStripeOperation {
    
    //1
    self.completeButton.enabled = NO;
    
    //2
    /*
     [Stripe createTokenWithCard:self.stripeCard
     publishableKey:STRIPE_TEST_PUBLIC_KEY
     success:^(STPToken* token) {
     [self postStripeToken:token.tokenId];
     } error:^(NSError* error) {
     [self handleStripeError:error];
     }];
     */
    [Stripe createTokenWithCard:self.stripeCard
                 publishableKey:STRIPE_TEST_PUBLIC_KEY
                     completion:^(STPToken* token, NSError* error) {
                         if(error)
                             [self handleStripeError:error];
                         else
                             [self postStripeToken:token.tokenId];
                     }];
}

- (void)postStripeToken:(NSString* )token {
    
    //1
    NSURL *postURL = [NSURL URLWithString:STRIPE_TEST_POST_URL];
    AFHTTPClient* httpClient = [AFHTTPClient clientWithBaseURL:postURL];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    //2
    RWCheckoutCart* checkoutCart = [RWCheckoutCart sharedInstance];
    //NSInteger totalCents = [[checkoutCart total] doubleValue] * 100;
    NSInteger totalCents = 999;

    
    //3
    NSMutableDictionary* postRequestDictionary = [[NSMutableDictionary alloc] init];
    postRequestDictionary[@"stripeAmount"] = [NSString stringWithFormat:@"%d", totalCents];
    postRequestDictionary[@"stripeCurrency"] = @"gbp";
    postRequestDictionary[@"stripeToken"] = token;
    postRequestDictionary[@"stripeDescription"] = @"Test purchase for Giverny";
    
    //4
    NSMutableURLRequest* request = [httpClient requestWithMethod:@"POST" path:nil parameters:postRequestDictionary];
    
    self.httpOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [self chargeDidSucceed];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [self chargeDidNotSuceed];
    }];
    
    [self.httpOperation start];
    
    self.completeButton.enabled = YES;
}

- (void)handleStripeError:(NSError *) error {
    
    //1
    if ([error.domain isEqualToString:@"StripeDomain"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    //2
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please try again"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    self.completeButton.enabled = YES;
}
@end
