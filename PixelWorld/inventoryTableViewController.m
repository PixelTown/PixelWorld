//
//  inventoryTableViewController.m
//  PixelWorld
//
//  Created by Yifang Zhang on 12/22/15.
//  Copyright © 2015 Yifang. All rights reserved.
//

#import "inventoryTableViewController.h"
#import "AFNetworking.h"

@interface inventoryTableViewController ()

@end

@implementation inventoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.inventoryData = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [self loadInventory:@"xiaofang"];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.inventoryData.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"生成单元格(组：%ld,行%ld)", (long)indexPath.section, (long)indexPath.row);
    
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    //首先根据标识去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有到则重新创建并放到缓存池中
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    // Configure the cell...
    NSUInteger row = [indexPath row];
    
    NSDictionary * item = [self.inventoryData objectAtIndex:row];
    
    if (item.count == 3 ) { // this is an normal item
        cell.textLabel.text = [item objectForKey:@"name"];
        cell.detailTextLabel.text = @"This is an item";
    }
    else if(item.count > 3){ //TODO: this is a equip for now, need modify
        cell.textLabel.text = [item objectForKey:@"name"];
        cell.detailTextLabel.text = @"this is an equip";
    }
    
    return cell;
}

- (void) loadInventory: (NSString *) username{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"loading the user inventory");
    
    //NSMutableDictionary *dictionary;
    
    NSDictionary *parameters = @{@"username": username};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"http://pixelworld.herokuapp.com/inventory/get" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON: %@", string);
        
        NSError * error;
        NSDictionary * inventory = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"dic count :%lu", (unsigned long)inventory.count);
        
        /*for(id key in self.userStatusDictionary) {
         NSLog(@"key :%@  value :%@", key, [self.userStatusDictionary objectForKey:key]);
         }*/
        
        //NSLog(@"yooo####################################yooo");
        
        [self setTableData: inventory];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

-(void) setTableData: (NSDictionary *) inv{
    
    //[self.inventoryData addObject:<#(nonnull id)#>]
    NSArray * items = [inv objectForKey:@"items"];
    NSArray * equip = [inv objectForKey:@"equipments"];
    
    for (NSDictionary * oneItem in items) {
        [self.inventoryData addObject: oneItem];
    }
    
    for (NSDictionary * oneEquip in equip) {
        [self.inventoryData addObject: oneEquip];
    }
    
    NSLog(@"data parsed into inventoryData");
    NSLog(@"something %@", [self.inventoryData objectAtIndex:0]);
    [self.tableView reloadData];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
