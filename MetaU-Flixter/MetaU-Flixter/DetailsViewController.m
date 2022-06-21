//
//  DetailsViewController.m
//  MetaU-Flixter
//
//  Created by m on 6/21/22.
//

#import "DetailsViewController.h"
#import <UIImageView+AFNetworking.h>

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropImageView;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];

    NSString *baseURLString = @"https://image.tmdb.org/t/p/";
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:@"w500"];
    fullBackdropURLString = [fullBackdropURLString stringByAppendingString:self.movie[@"backdrop_path"]];
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];

    [self.backdropImageView setImageWithURL:backdropURL];

    NSString *fullPosterURLString = [baseURLString stringByAppendingString:@"w500"];
    fullPosterURLString = [fullPosterURLString stringByAppendingString:self.movie[@"poster_path"]];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];

    [self.posterImageView setImageWithURL:posterURL];
}

@end
