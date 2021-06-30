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

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate>

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
    
    NSString * URLString = mytweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [cell.profilePicture setImageWithURL:url placeholderImage:nil];
    cell.likeCount.text = [NSString stringWithFormat:@"%i", mytweet.favoriteCount];

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
    
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}


- (void)didTweet:(Tweet *)tweet{
    
    if (!self.arrayOfTweets) self.arrayOfTweets = [[NSMutableArray alloc] init];
    [self.arrayOfTweets addObject:tweet];
    [self.tableView reloadData];
}

@end
