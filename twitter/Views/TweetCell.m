//
//  TweetCell.m
//  twitter
//
//  Created by Sarah Wen Gu on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell
- (IBAction)didTapFavorite:(id)sender {
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1; 
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
