//
//  ComposeViewController.m
//  twitter
//
//  Created by Sarah Wen Gu on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"
@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *toTweet;

@end

@implementation ComposeViewController
- (IBAction)closeTweet:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
    
}
- (IBAction)writeTweet:(id)sender {
    
    [[APIManager shared]postStatusWithText:self.toTweet.text completion:^(Tweet *tweets, NSError *error) {
        if (self) {
            NSLog(@"yoooo it worked");
            [self.delegate didTweet:tweets]; 
            
        } else {
            NSLog(@"yoooo it didn't worked");
        }
    }];
    [self dismissViewControllerAnimated:true completion:nil];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.toTweet.delegate = self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
