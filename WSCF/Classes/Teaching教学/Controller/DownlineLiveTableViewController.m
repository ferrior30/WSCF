//
//  DownlineLiveTableViewController.m
//  WSCF
//
//  Created by ChenWei on 16/10/22.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "DownlineLiveTableViewController.h"

static NSString *DownlineLivCellId = @"DownlineLivCellId";

@interface DownlineLiveTableViewController ()

@end

@implementation DownlineLiveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DownlineLivCellId];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DownlineLivCellId forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
