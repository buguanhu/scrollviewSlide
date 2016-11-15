//
//  ViewController.m
//  头部视图随tableView滚动
//
//  Created by TH on 2016/11/14.
//  Copyright © 2016年 TH. All rights reserved.
//

#define scrW  [UIScreen mainScreen].bounds.size.width
#define scrH  [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,assign) CGFloat yOffset;
@property (nonatomic,strong) UITableView *tableView1;
@property (nonatomic,strong) UITableView *tableView2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrW, scrH)];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(scrW * 2, scrH);
    scrollView.alwaysBounceVertical = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UITableView *tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, scrW, scrH)];
    tableView1.delegate = self;
    tableView1.dataSource = self;
    [scrollView addSubview:tableView1];
    tableView1.showsVerticalScrollIndicator = NO;
    self.tableView1 = tableView1;
    
    UIView *tableHeaderView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrW, 200)];
    tableHeaderView1.backgroundColor = [UIColor clearColor];
    tableView1.showsVerticalScrollIndicator = NO;
    tableView1.tableHeaderView = tableHeaderView1;
   // tableView1.backgroundColor = MCColor(252, 252, 252, 1);
    
    UITableView *tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(scrW, 0, scrW, scrH)];
    tableView2.delegate = self;
    tableView2.dataSource = self;
    [scrollView addSubview:tableView2];
    tableView2.tableHeaderView = self.headView;
    tableView2.showsVerticalScrollIndicator = NO;
    self.tableView2 = tableView2;
    
    UIView *tableHeaderView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrW, 200)];
    tableHeaderView2.backgroundColor = [UIColor clearColor];
    tableView2.showsVerticalScrollIndicator = NO;
    tableView2.tableHeaderView = tableHeaderView2;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrW, 200)];
    headView.backgroundColor = [UIColor redColor];
    [self.view addSubview:headView];
    self.headView = headView;
    _yOffset = self.headView.center.y;
    // Do any additional setup after loading theview, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 40;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld个数据",(long)indexPath.row];
    
    return cell;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if ([scrollView isEqual:self.scrollView]) {
        
        return;
        
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    NSLog(@"---%f",offsetY);
    
    if (scrollView.contentOffset.y > 200) {
        self.headView.frame = CGRectMake(0, -200, scrW, 200);
    //    self.headView.center = CGPointMake(self.headView.center.x, 0 - 200);
        return;
    }
   // CGFloat h = 0 - offsetY;
    
     self.headView.frame = CGRectMake(0, -offsetY, scrW, 200);
 //   self.headView.center = CGPointMake(self.headView.center.x, h);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y > 200) {
        
     //   [self.tableView1 setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];
    //    [self.tableView2 setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];

        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if([scrollView isEqual:self.scrollView]){
    
        return ;
        
    }
    
     CGFloat tableViewOffset = scrollView.contentOffset.y;
    
    if (scrollView.contentOffset.y > 200) {
        
         tableViewOffset = 200;
        
    }
    
  //  [self.tableView1 setContentOffset:CGPointMake(0, tableViewOffset)];
    [self.tableView2 setContentOffset:CGPointMake(0, tableViewOffset)];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
