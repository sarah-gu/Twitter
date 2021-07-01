//
//  DetailsViewController.m
//  twitter
//
//  Created by Sarah Wen Gu on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITextView *tweetMessage;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString * URLString = self.tweet.user.profilePicture;
    URLString = [URLString
               stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *url = [NSURL URLWithString:URLString];
    [self.profilePicture setImageWithURL:url placeholderImage:nil];
    
    self.likeCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.retweetCount.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    if(self.tweet.favorited == YES) {
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState: UIControlStateNormal];
    }
    else {
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState: UIControlStateNormal];
    }
    
    if(self.tweet.retweeted == YES) {
        
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState: UIControlStateNormal];
    }
    else {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState: UIControlStateNormal];
    }
    
    self.tweetMessage.text = self.tweet.text;
    self.screenName.text = self.tweet.user.name;
    self.userName.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
}
- (IBAction)didTapFavorite:(id)sender {
    
    
    if(self.tweet.favorited == YES) {
        
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -=1;
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState: UIControlStateNormal];
        
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
        
    }
    else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState: UIControlStateNormal];
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];

    }
    
    self.likeCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
}
- (IBAction)didTapRetweet:(id)sender {
    
    if(self.tweet.retweeted == YES) {
        
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -=1;
        
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState: UIControlStateNormal];
    
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    else{
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState: UIControlStateNormal];
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
            //    [self.delegate didTweet:tweet];
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];

    }

    self.retweetCount.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
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
