//
//  TweetCell.h
//  twitter
//
//  Created by Sarah Wen Gu on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (nonatomic, strong) Tweet *tweet; //added property tweet
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *tweetMessage;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;

@end

NS_ASSUME_NONNULL_END
