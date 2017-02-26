//
//  ViewController.m
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 22/11/16.
//  Copyright © 2016 Sahnawaj Biswas. All rights reserved.
//

#import "GameViewController.h"
#import "CardCollectionViewCell.h"
#import "GameViewControllerModel.h"

@interface GameViewController (){
    int tapCount;
    int lastObjIndex;
    int gmscore;
    float wdth,height;
}
@property (weak, nonatomic) IBOutlet UICollectionView *gameContainerView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLbl;

@property (nonatomic) GameViewControllerModel *controller;
@end

@implementation GameViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self == nil) return nil;
    
    self.controller = [[GameViewControllerModel alloc] init];
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = true;
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:true];
    [self setGameBoard];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.controller.unqArray)
        return [self.controller numberOfSections];
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CardCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cardCell" forIndexPath:indexPath];
    
    cell.cardBackImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,wdth,height)];
    cell.cardBackImage.image = [UIImage imageNamed:@"card_bg"];
    [cell addSubview:cell.cardBackImage];
    
    int cardNumber = [[self.controller.unqArray objectAtIndex:indexPath.row] intValue];
    cell.cardImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,wdth,height)];
    cell.cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"colour%d.png",cardNumber]];
    
    cell.cardNumber = cardNumber;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(wdth, height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CardCollectionViewCell *cell = (CardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    // Flip animation on select Card Item
    if(!cell.isCardFaceUp && tapCount < 2){
        [UIView animateWithDuration:0.5
                              delay:0
                            options:(UIViewAnimationOptionAllowUserInteraction)
                         animations:^
         {
             [UIView transitionFromView:cell.cardBackImage
                                 toView:cell.cardImage
                               duration:.2
                                options:UIViewAnimationOptionTransitionFlipFromLeft
                             completion:nil];
         }
                         completion:^(BOOL finished)
         {
             cell.isCardFaceUp = YES;
             if(tapCount == 1){
                 [self performSelector:@selector(rotateView:) withObject:indexPath afterDelay:1.0f];
             }else{
                 lastObjIndex = indexPath.row;
             }
             tapCount++;
         }
         ];
    }
    
    
}

//Card Matched or Set card to original state(with flip animation)
-(void) rotateView:(NSIndexPath *)indexPath{
    CardCollectionViewCell *cell = (CardCollectionViewCell *)[_gameContainerView cellForItemAtIndexPath:indexPath];
    CardCollectionViewCell *lastcell = (CardCollectionViewCell *)[_gameContainerView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:lastObjIndex inSection:0]];
    
    if(cell.cardNumber == lastcell.cardNumber){//Matched Card
        tapCount=0;
        gmscore = gmscore + 2;
        self.scoreLbl.text = [NSString stringWithFormat:@"%d",gmscore];
        [self.controller.unqArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:0]];
        [self.controller.unqArray replaceObjectAtIndex:lastObjIndex withObject:[NSNumber numberWithInt:0]];
        if([self.controller isGameOver]){
            [self alertView];
        }
    }else{ //Rotate Card to original state
        [UIView animateWithDuration:0.5
                              delay:0
                            options:(UIViewAnimationOptionAllowUserInteraction)
                         animations:^
         {
             
             [UIView transitionFromView:cell.cardImage
                                 toView:cell.cardBackImage duration:.2
                                options:UIViewAnimationOptionTransitionFlipFromRight
                             completion:nil];
             [UIView transitionFromView:lastcell.cardImage
                                 toView:lastcell.cardBackImage duration:.2
                                options:UIViewAnimationOptionTransitionFlipFromRight
                             completion:nil];
         }
                         completion:^(BOOL finished){
                             
                             if(finished){
                                 tapCount=0;
                                 cell.isCardFaceUp = NO;
                                 lastcell.isCardFaceUp = NO;
                                 gmscore = gmscore - 1;
                                 self.scoreLbl.text = [NSString stringWithFormat:@"%d",gmscore];
                             }
                         }
         ];
    }
}

// Set-Reset Game
-(void) setGameBoard{
    tapCount = 0;
    lastObjIndex = 0;
    gmscore = 0;
    self.scoreLbl.text = @"0";
    wdth = [self.controller cellWidth:self.gameContainerView.frame.size.width];
    height = [self.controller cellWidth:self.gameContainerView.frame.size.height];
    [self.controller genarateRandomUniqueNum];
    
    if([self.gameContainerView numberOfItemsInSection:0]> 10){
        for(int i = 0 ; i < [self.controller numberOfSections] ; i++){
            CardCollectionViewCell *cell = (CardCollectionViewCell *)[self.gameContainerView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.isCardFaceUp = FALSE;
            [UIView transitionFromView:cell.cardImage
                                toView:cell.cardBackImage duration:0
                               options:UIViewAnimationOptionTransitionNone
                            completion:nil];
            
        }
    }
    [self.gameContainerView reloadData];
    
}

// Alert view with textfield for player name input
-(void) alertView{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Game Over"
                                                                              message: @"Please enter your name"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Please enter your name";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleNone;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        if([namefield.text length] == 0){
            namefield.text = @"BOT";
        }
        [self.controller addScoreToPersistentStore:namefield.text :gmscore];
        [self setGameBoard];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


@end
