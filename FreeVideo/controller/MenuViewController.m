//
//  MenuViewController.m
//  FreeVideo
//
//  Created by wang on 14-3-30.
//  Copyright (c) 2014年 wang. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "TWTSideMenuViewController.h"

@interface MenuViewController ()

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.categories = [NSArray arrayWithObjects:@"Home", @"Movie", @"TV", @"Variety", @"Cartoon", @"Sport", nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 105, 250, 270) style:UITableViewStylePlain];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
//    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    CGRect imageViewRect = [[UIScreen mainScreen] bounds];
//    imageViewRect.size.width += 589;
//    self.backgroundImageView.frame = imageViewRect;
//    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:self.backgroundImageView];

}

- (void)changeButtonPressed
{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabBarCtrl = delegate.tabBarCtrl;
    tabBarCtrl.selectedIndex = (tabBarCtrl.selectedIndex == 1) ?0 :1;
    [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
}

- (void)closeButtonPressed
{
    [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview datasource

- (int)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categories.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellId = @"DefaultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    
    NSString *category = [self.categories objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[category lowercaseString]];
    cell.imageView.opaque = 0;
    cell.textLabel.text = category;
    cell.backgroundColor = [UIColor brownColor];
    return cell;
}

#pragma tableview delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabBarCtrl = delegate.tabBarCtrl;
    tabBarCtrl.selectedIndex = indexPath.row;
    [self.sideMenuViewController closeMenuAnimated:YES completion:nil];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

@end
