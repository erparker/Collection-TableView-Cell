//
//  CollectionTableViewCell.h
//  TableviewCellConCollection
//
//  Created by Eric Parker on 12/10/14.
//  Copyright (c) 2014 testing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionTableViewCell : UITableViewCell 

@property (nonatomic, strong) NSArray *collectionData;

@property (strong, nonatomic) UICollectionView *collectionView;

@end
