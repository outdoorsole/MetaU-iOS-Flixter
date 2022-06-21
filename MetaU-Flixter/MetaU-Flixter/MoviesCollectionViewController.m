//
//  MoviesCollectionViewController.m
//  MetaU-Flixter
//
//  Created by m on 6/21/22.
//

#import "MoviesCollectionViewController.h"
#import "MovieCollectionViewCell.h"
#import <UIImageView+AFNetworking.h>

@interface MoviesCollectionViewController () <UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *movies;

@end

@implementation MoviesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.dataSource = self;

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
               [self.collectionView reloadData];
           }
       }];
    [task resume];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.row];

    NSString *baseURLString = @"https://image.tmdb.org/t/p/";
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:@"w500"];
    fullPosterURLString = [fullPosterURLString stringByAppendingString:movie[@"poster_path"]];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];

    [cell.posterImageView setImageWithURL:posterURL];

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.movies count];
}

@end
