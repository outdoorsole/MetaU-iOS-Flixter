//
//  MoviesViewController.m
//  MetaU-Flixter
//
//  Created by m on 6/21/22.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "DetailsViewController.h"
#import <UIImageView+AFNetworking.h>

@interface MoviesViewController () <UITableViewDataSource>

@property (strong, nonatomic) NSArray *movies;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.dataSource = self;

    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSLog(@"%@", dataDictionary);// log an object with the %@ formatter.

               // TODO: Get the array of movies
               NSArray *myArray = dataDictionary[@"results"];

               // TODO: Store the movies in a property to use elsewhere
               self.movies = myArray;

               // TODO: Reload your table view data
               [self.tableView reloadData];
           }
       }];
    [task resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.row];

    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];

    NSString *baseURLString = @"https://image.tmdb.org/t/p/";
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:@"w500"];
    fullPosterURLString = [fullPosterURLString stringByAppendingString:movie[@"poster_path"]];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];

    [cell.posterImageView setImageWithURL:posterURL];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movies count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSDictionary *movie = self.movies[indexPath.row];
    DetailsViewController *detailsVC = [segue destinationViewController];
    detailsVC.movie = movie;
}

@end
