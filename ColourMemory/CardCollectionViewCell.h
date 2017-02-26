//
//  CardCVCellCollectionViewCell.h
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 23/11/16.
//  Copyright © 2016 Sahnawaj Biswas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) IBOutlet UIImageView *cardBackImage;
@property(nonatomic,strong) IBOutlet UIImageView *cardImage;

@property (nonatomic) int cardNumber;
@property (nonatomic) BOOL isCardFaceUp;
@end
