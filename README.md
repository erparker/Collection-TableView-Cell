Collection-TableView-Cell
=========================

This is a simple example of how to implement a UITableViewCell that has a UICollectionView inside of it.

This example does not include code that will be specific to your app, like data for the collection view, or some view setup code.

When placing a collection view inside a UITableViewCell, one problem that needs solving is connecting the 
UICollecitonView datasource and delegate. The UITableViewCell is in the view controller, but the collection view 
is in the TableViewCell. What to do?

There are bascially two ways to go: place the collection view data source and delegate
 methods in your view controller, or in each cell. (I suppose a third option is to use a view model for your 
 datasource/delegate stuff, but I didn't go that route this time.) If you place your delegate methods in the view 
 controller,at some point you will need to assign the delegate and data source for each collection view. This will 
 likely happen during your UITableview delegate/datasource cycle (cellForRowAtIndexPath:, or maybe willDisplayCell). 
 If you place your collection view delegate/datasource in each UITableViewCell, each cell will manage its 
 collection view completely. The second method, placing collection view delegate in each cell, is nice because 
 you're not splitting the collection view code into different classes. Going this route means you need a way to pass the 
 relevant data to each collection view from wherever it lives, be that the view controller, view model, etc.
 
 This solution employs the second solution, which is placing all the code for each collection view 
 datasource/delegate in each UITableViewCell. This isn't meant to be an exhaustive example, but rather a good starting
 point for placing a collection view inside a table view cell. 
 
 
ViewController.h
-------------------------
 ```objective-c
#import "ViewController.h"
#import "CollectionTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrayOfCollectionData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *cellID = @"CollectionCellID";
    
    CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.collectionData = self.arrayOfCollectionData[indexPath.row];
    [cell.collectionView reloadData];
    
    
    return cell;
}


@end
```

CollectionTableViewCell.h
-------------------------
```objective-c
@interface CollectionTableViewCell : UITableViewCell 

@property (nonatomic, strong) NSArray *collectionData;

@property (strong, nonatomic) UICollectionView *collectionView;

@end
```

CollectionTableView.m
----------------------
```objective-c
@interface CollectionTableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation CollectionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.contentView addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"some_identifier"];
    
    return self;
}

#pragma mark - UICollectionView delegate, datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
    
    //do something with self.collectionViewData, or whatever is relevant for each cell
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //I sent an NSNotification for this event since it needed to be handled elsewhere
}

@end

```
