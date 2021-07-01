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
#import <UIKit/UIKit.h>

@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *toTweet;
@property (weak, nonatomic) IBOutlet UILabel *characterCount;

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
    
    
    self.toTweet.text = @"Write your tweet here";
    self.toTweet.textColor = UIColor.lightGrayColor;

   // self.toTweet.becomeFirstResponder();

//    textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//    self.toTweet = RSKPlaceholderTextView(frame:CGRect(x:0, y:20, width:self.view.frame.width, height:100));
//    self.toTweet.placeholder = "Write your tweet here: "
    
    
    self.toTweet.delegate = self;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.toTweet.textColor == UIColor.lightGrayColor) {
        self.toTweet.text = @"";
        self.toTweet.textColor = UIColor.blackColor;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.toTweet.text  isEqual: @""]) {

        self.toTweet.text = @"Write your tweet here";
        self.toTweet.textColor = UIColor.lightGrayColor;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    int characterLimit = 140;
    
    NSString *newText = [self.toTweet.text stringByReplacingCharactersInRange:range withString:text];
    
    long mynewLength = [newText length];
    
    self.characterCount.text = [NSString stringWithFormat:@"%ld Characters Left", characterLimit - mynewLength];
    
    
    return newText.length < characterLimit;
    
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
