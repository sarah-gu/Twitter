//
//  ProfileViewController.m
//  twitter
//
//  Created by Sarah Wen Gu on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myPFP;
@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString * URLString = self.user.profilePicture;
    
    URLString = [URLString
               stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    
    NSURL *url = [NSURL URLWithString:URLString];
    

    [self.myPFP setImageWithURL:url placeholderImage:nil];
    
    self.followerCount.text = [NSString stringWithFormat:@"%i",self.user.followers];
    self.followingCount.text = [NSString stringWithFormat:@"%i",self.user.following];
    self.screenName.text = [NSString stringWithFormat:@"@%@",self.user.screenName];
    self.tweetCount.text = [NSString stringWithFormat:@"%i",self.user.numTweets];
    self.nameField.text = self.user.name;
    
}
//- (IBAction)closeBtn:(id)sender {
//
//    NSLog(@"This works");
//    [self dismissViewControllerAnimated:true completion:nil];
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
