//
//  shopTableViewController.m
//  PixelWorld
//
//  Created by Yifang Zhang on 12/25/15.
//  Copyright © 2015 Yifang. All rights reserved.
//

#import "shopTableViewController.h"
#import "AFNetworking.h"

@interface shopTableViewController ()

@end

@implementation shopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    //self.recipeArray = [[NSMutableArray alloc] init];
    
    //[self getRecipeData:@"xiaofang"];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    NSLog(@"shop table view appeared");
    
    self.recipeArray = [[NSMutableArray alloc] init];
    
    [self getRecipeData:@"xiaofang"];

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

    return self.recipeArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"生成单元格(组：%ld,行%ld)", (long)indexPath.section, (long)indexPath.row);
    
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey2";
    //首先根据标识去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有到则重新创建并放到缓存池中
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    // Configure the cell...
    NSUInteger row = [indexPath row];
    NSDictionary * item = [self.recipeArray objectAtIndex:row];
    
    cell.textLabel.text = [item objectForKey:@"name"];
    
    // add "make" button
    UIButton *buttonOther = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonOther addTarget:self
                    action:@selector(crafting:)
          forControlEvents:UIControlEventTouchUpInside];
    [buttonOther setTitle:@"forge" forState:UIControlStateNormal];
    buttonOther.frame = CGRectMake(225.0, 10.0, 60.0, 30.0);
    buttonOther.tag = row;
    if ([[item objectForKey:@"avaliable"] isEqualToString:@"f"]) {
        buttonOther.enabled = NO;
    }
    [cell addSubview:buttonOther];
    
    return cell;
}

- (void) crafting: (UIButton *)sender{

    NSDictionary * currentItem = [self.recipeArray objectAtIndex:sender.tag];
    NSString * currentRecipeName = [currentItem objectForKey:@"name"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"crafting the current recipe %@", currentRecipeName);
    
    //NSMutableDictionary *dictionary;
    
    NSDictionary *parameters = @{@"username": @"xiaofang", @"name": currentRecipeName};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"http://pixelworld.herokuapp.com/recipe/forge" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON: %@", string);
        
        /*NSError * error;
        NSDictionary * inventory = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"dic count :%lu", (unsigned long)inventory.count);*/
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void) getRecipeData: (NSString *) username{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"loading the recipe data");
    
    //NSMutableDictionary *dictionary;
    
    NSDictionary *parameters = @{@"username": username};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:@"http://pixelworld.herokuapp.com/recipe/getforge" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON: %@", string);
        
        NSError * error;
        NSArray * inventory = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"dic count :%lu", (unsigned long)inventory.count);
        
        self.recipeArray = [NSMutableArray arrayWithArray:inventory];
        
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];


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
