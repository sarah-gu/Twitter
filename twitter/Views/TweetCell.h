//
//  TweetCell.h
//  twitter
//
//  Created by Sarah Wen Gu on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
//#import "TimelineViewController.h"
NS_ASSUME_NONNULL_BEGIN

@protocol TweetCellDelegate;

@interface TweetCell : UITableViewCell

@property (nonatomic, strong) Tweet *tweet; //added property tweet
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *tweetMessage;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *timePosted;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;

@property (nonatomic, weak) id<TweetCellDelegate> delegate; 
//@property (weak, nonatomic) Tweet *delegate;

@end

@protocol TweetCellDelegate

-(void)didTweet:(Tweet *)tweet;
-(void)tweetCell:(TweetCell *) tweetCell didTap:(User *)user;

@end

NS_ASSUME_NONNULL_END
