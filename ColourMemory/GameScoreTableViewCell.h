//
//  GameScoreTableViewCell.h
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 24/11/16.
//  Copyright © 2016 Sahnawaj Biswas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameScoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rankLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *scoreLbl;

@end
