//
//  ViewController.m
//  KWAddressBook
//
//  Created by KW on 18/6/9.
//  Copyright © 2018年 KW. All rights reserved.
//

#import "ViewController.h"
#import "ChineseString.h"
#import "StudenModel.h"

@interface ViewController ()
<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *sortedDataArray;

@property (nonatomic,strong) NSMutableArray *nameSortedArray;
@property (nonatomic,strong) NSMutableArray *indexArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    NSMutableArray *nameArr = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i ++) {
        StudenModel *sModel = self.dataArray[i];
        [nameArr addObject:sModel.name];
    }
    self.nameSortedArray = [ChineseString LetterSortArray:nameArr];
    
    self.indexArray = [ChineseString IndexArray:nameArr];
    
    [self sortData];
    
    [self addTableView];
}

#pragma mark - UITableViewDataSource
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sortedDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.sortedDataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StudenModel *sModel = self.sortedDataArray[indexPath.section][indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = sModel.name;
    cell.detailTextLabel.text =sModel.job;
    return cell;
}

- (void)sortData {
    //获取排序后的用户职位
    for (int i = 0; i < self.nameSortedArray.count; i ++) {
        NSArray *nameArray = self.nameSortedArray[i];
        NSMutableArray *jArr = [[NSMutableArray alloc]init];
        
        for (int j = 0; j < nameArray.count; j++) {
            NSString *name = nameArray[j];
            
            for (int m = 0; m < self.dataArray.count; m++) {
                StudenModel *sModel = self.dataArray[m];
                
                if ([sModel.name isEqualToString:name]) {
                    [jArr addObject:sModel];
                    [self.dataArray removeObject:sModel];
                }
            }
        }
        [self.sortedDataArray addObject:jArr];
    }
}

- (void)initData
{
    self.dataArray = [[NSMutableArray alloc]init];
    
    StudenModel *sModel0 = [[StudenModel alloc]init];
    sModel0.name = @"张三";
    sModel0.job = @"iOS33";
    sModel0.phone = @"13682549233";
    
    StudenModel *sModel1 = [[StudenModel alloc]init];
    sModel1.name = @"林";
    sModel1.job = @"iOS44";
    sModel1.phone = @"13682549244";
    
    StudenModel *sModel2 = [[StudenModel alloc]init];
    sModel2.name = @"蔡";
    sModel2.job = @"iOS22";
    sModel2.phone = @"13682549222";
    
    StudenModel *sModel3 = [[StudenModel alloc]init];
    sModel3.name = @"吴";
    sModel3.job = @"iOS66";
    sModel3.phone = @"13682549266";
    
    StudenModel *sModel4 = [[StudenModel alloc]init];
    sModel4.name = @"李";
    sModel4.job = @"iOS77";
    sModel4.phone = @"13682549277";
    
    StudenModel *sModel5 = [[StudenModel alloc]init];
    sModel5.name = @"王";
    sModel5.job = @"iOS88";
    sModel5.phone = @"13682549288";
    
    [self.dataArray addObject:sModel0];
    [self.dataArray addObject:sModel1];
    [self.dataArray addObject:sModel2];
    [self.dataArray addObject:sModel3];
    [self.dataArray addObject:sModel4];
    [self.dataArray addObject:sModel5];
    
}

- (void)addTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.frame = [UIScreen mainScreen].bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.sectionIndexColor = [UIColor purpleColor];  //修改索引文字颜色
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];  //修改索引背景颜色
    
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    
}

-(NSMutableArray *)nameSortedArray {
    if (!_nameSortedArray) {
        _nameSortedArray = [[NSMutableArray alloc]init];
    }
    return _nameSortedArray;
}

-(NSMutableArray *)indexArray {
    if (!_indexArray) {
        _indexArray = [[NSMutableArray alloc]init];
    }
    return _indexArray;
}

-(NSMutableArray *)sortedDataArray {
    if (!_sortedDataArray) {
        _sortedDataArray = [[NSMutableArray alloc]init];
    }
    return _sortedDataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
