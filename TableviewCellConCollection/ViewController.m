//
//  ViewController.m
//  TableviewCellConCollection
//
//  Created by Eric Parker on 12/10/14.
//  Copyright (c) 2014 testing. All rights reserved.
//

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
