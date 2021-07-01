//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import "LoginViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "DateTools.h"
#import "DetailsViewController.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate, TweetCellDelegate>

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (nonatomic, strong) NSMutableArray *arrayOfTweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self getTweets];
    self.refreshControl = [[UIRefreshControl alloc] init]; //instantiate the refreshControl
    [self.refreshControl addTarget:self action:@selector(getTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    // Get timeline

}
- (void)getTweets {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.arrayOfTweets = (NSMutableArray *)tweets; //save the tweets
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            NSLog(@"%@", self.arrayOfTweets);
            Tweet *mytweet = [tweets objectAtIndex:0];
            
            [self.tableView reloadData];
            
            NSLog(@"%@", mytweet.text);
//            for (NSDictionary *dictionary in self.arrayOfTweets) {
//                NSString *text = dictionary[@"text"];
//                NSLog(@"%@", text);
//            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    [self.refreshControl endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutMethod:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController" ];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" ];
    
    
    
    Tweet *mytweet = [self.arrayOfTweets objectAtIndex:indexPath.row];
    
    //Tweet * mytweet = self.arrayOfTweets[indexPath.row]; //gets next tweet to load
    NSLog(@"%@", mytweet.text);
    cell.tweetMessage.text = mytweet.text;
    cell.userName.text = mytweet.user.name;
    
    cell.screenName.text = [NSString stringWithFormat:@"@%@", mytweet.user.screenName];
    
    if(mytweet.favorited == YES) {
        [cell.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState: UIControlStateNormal];
    }
    else {
        [cell.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState: UIControlStateNormal];
    }
    
    if(mytweet.retweeted == YES) {
        
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState: UIControlStateNormal];
    }
    else {
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState: UIControlStateNormal];
    }
    
    
    cell.retweetCount.text = [NSString stringWithFormat:@"%i", mytweet.retweetCount];
    cell.timePosted.text = mytweet.createdAtString;
    
    NSString * URLString = mytweet.user.profilePicture;
    
    URLString = [URLString
               stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    
    NSURL *url = [NSURL URLWithString:URLString];
    

    [cell.profilePicture setImageWithURL:url placeholderImage:nil];
    
    
    cell.likeCount.text = [NSString stringWithFormat:@"%i", mytweet.favoriteCount];
    
    
   // NSInteger minutesSinceTweet = []
    
    cell.delegate = self; //delegate property assignment
    cell.tweet = mytweet; 

    return cell;
//
//    NSString * URLString = mytweet.profilePicture;
//    NSURL *url = [NSURL URLWithString:URLString];
//    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([sender isKindOfClass:[UIBarButtonItem class]]) {
        NSLog(@"%@", sender);
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    
    }
    else if ([@"profileSegue"  isEqual: segue.identifier]){
        User * myUser = sender;
        ProfileViewController *profileViewController = [segue destinationViewController];
        
        profileViewController.user = myUser;
    }
    else {
        
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet *tweet = self.arrayOfTweets[indexPath.row];
        DetailsViewController *detailViewController = [segue destinationViewController];
        
        detailViewController.tweet = tweet; 
    }

}


- (void)didTweet:(Tweet *)tweet{
    
    if (!self.arrayOfTweets) self.arrayOfTweets = [[NSMutableArray alloc] init];
    [self.arrayOfTweets addObject:tweet];
    [self.tableView reloadData];
}

-(void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user {
    
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
    
}
@end
