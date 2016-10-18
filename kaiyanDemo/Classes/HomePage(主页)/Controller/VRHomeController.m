//
//  VRHomeController.m
//  kaiyanDemo
//
//  Created by pbyi on 16/10/10.
//  Copyright © 2016年 wethinkvr. All rights reserved.
//
//控制器
#import "VRHomeController.h"
//网络
#import "LORequestManger.h"
//Model
#import "EveryDayModel.h"
//view
#import "VRHomeCell.h"
#import "VRPrePlayView.h"
#import "VRContentView.h"

@interface VRHomeController ()
@property (nonatomic, strong) NSMutableDictionary *selectDic;
@property (nonatomic, strong) NSMutableArray *dateArray;

@property (weak, nonatomic) VRPrePlayView *prePlayView;

@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@end

@implementation VRHomeController
//懒加载
- (NSMutableDictionary *)selectDic{
    if (!_selectDic) {
        
        _selectDic = [[NSMutableDictionary alloc]init];
        
    }
    return _selectDic;
}
- (NSMutableArray *)dateArray{
    if (!_dateArray) {
        _dateArray = [[NSMutableArray alloc]init];
    }
    return _dateArray;
}

#pragma mark - 解析数据
- (void)jsonSelection{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    
    NSDate *date = [NSDate date];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    NSString *url = [NSString stringWithFormat:kEveryDay,dateString];
    
    [LORequestManger GET:url success:^(id response) {
        
        NSDictionary *Dic = (NSDictionary *)response;
        
        NSArray *array = Dic[@"dailyList"];
        
        for (NSDictionary *dic in array) {
            
            NSMutableArray *selectArray = [NSMutableArray array];
            
            NSArray *arr = dic[@"videoList"];
            
            for (NSDictionary *dic1 in arr) {
                
                EveryDayModel *model = [[EveryDayModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dic1];
                
                model.collectionCount = dic1[@"consumption"][@"collectionCount"];
                model.replyCount = dic1[@"consumption"][@"replyCount"];
                model.shareCount = dic1[@"consumption"][@"shareCount"];
                
                [selectArray addObject:model];
            }
            NSString *date = [[dic[@"date"] stringValue] substringToIndex:10];
            
            [self.selectDic setValue:selectArray forKey:date];
        }
        
        NSComparisonResult (^priceBlock)(NSString *, NSString *) = ^(NSString *string1, NSString *string2){
            
            NSInteger number1 = [string1 integerValue];
            NSInteger number2 = [string2 integerValue];
            
            if (number1 > number2) {
                return NSOrderedAscending;
            }else if(number1 < number2){
                return NSOrderedDescending;
            }else{
                return NSOrderedSame;
            }
            
        };
        
        self.dateArray = [[[self.selectDic allKeys] sortedArrayUsingComparator:priceBlock]mutableCopy];
        
        NSLog(@"%ld",[self.dateArray count]);
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

#pragma mark - 系统回调
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[VRHomeCell class] forCellReuseIdentifier:@"VRHomeCell"];
    [self jsonSelection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.selectDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.selectDic[self.dateArray[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VRHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VRHomeCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(VRHomeCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.model = self.selectDic[self.dateArray[indexPath.section]][indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *string = self.dateArray[section];
    long long int date1 = (long long int)[string intValue];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMdd"];
    NSString *dateString = [dateFormatter stringFromDate:date2];
    return dateString;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _currentIndexPath = indexPath;
    
    VRPrePlayView *prePlayView = [[VRPrePlayView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) modelArray:self.selectDic[self.dateArray[indexPath.section]] index:indexPath.row majorScrollDelegate:self];
    [self.tableView.superview addSubview:prePlayView];
    _prePlayView = prePlayView;
    
    VRHomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = [cell convertRect:cell.bounds toView:nil];
    
    _prePlayView.offsetY = rect.origin.y;
    _prePlayView.animateCell.picture.image = cell.picture.image;
    _prePlayView.animationTrans = cell.picture.transform;
    [_prePlayView show];
    
    UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe)];
    swipeGes.direction = UISwipeGestureRecognizerDirectionUp;
    [prePlayView addGestureRecognizer:swipeGes];
}

- (void)swipe {
    [_prePlayView dismissPrePlayView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_prePlayView.majorScrollView]) {
        
    } else {
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_prePlayView.majorScrollView]) {
        NSInteger index = scrollView.contentOffset.x / kWidth;
        
        [_prePlayView.contentView setModel:self.selectDic[self.dateArray[_currentIndexPath.section]][index]];
        _currentIndexPath = [NSIndexPath indexPathForRow:index inSection:_currentIndexPath.section];
        [self.tableView scrollToRowAtIndexPath:_currentIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
        VRHomeCell *cell = [self.tableView cellForRowAtIndexPath:_currentIndexPath];
        _prePlayView.animateCell.picture.image = cell.picture.image;
        _prePlayView.animationTrans = cell.picture.transform;
        CGRect rect = [cell convertRect:cell.bounds toView:nil];
        _prePlayView.offsetY = rect.origin.y;
    }
}

@end
