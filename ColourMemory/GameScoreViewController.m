//
//  GameScoreViewController.m
//  ColourMemory
//
//  Created by Sahnawaj Biswas on 24/11/16.
//  Copyright © 2016 Sahnawaj Biswas. All rights reserved.
//

#import "GameScoreViewController.h"
#import "GameScoreTableViewCell.h"
#import "GameScoreVCModel.h"
#import "GameScore.h"
@interface GameScoreViewController ()
@property (weak, nonatomic) IBOutlet UITableView *scoreTblView;
- (IBAction)backAction:(id)sender;


@property (nonatomic) GameScoreVCModel *controller;
@end

@implementation GameScoreViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self == nil) return nil;
    
    self.controller = [[GameScoreVCModel alloc] init];
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.controller numberOfRowsInSection];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    static NSString *CellIdentifier = @"gamecell";
    
    GameScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Get the specific score for this row.
    GameScore *score = [self.controller.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.rankLbl.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.nameLbl.text = score.name;
    cell.scoreLbl.text = [NSString stringWithFormat:@"%d",score.score];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    /* Create custom view to display section header... */
    NSArray *elementNm = @[@"Rank",@"Name",@"Score"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    for(int i = 0 ; i < 3 ; i++){
        UILabel *headLbl = [[UILabel alloc] initWithFrame:CGRectMake((tableView.frame.size.width/3)*i, 0, tableView.frame.size.width/3, 40)];
        [headLbl setFont:[UIFont boldSystemFontOfSize:15]];
        headLbl.textColor = [UIColor whiteColor];
        headLbl.textAlignment = NSTextAlignmentCenter;
        [headLbl setText:[elementNm objectAtIndex:i]];
        [view addSubview:headLbl];
    }

    [view setBackgroundColor:[UIColor blackColor]]; //your background color...
    return view;
}



- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}
@end
