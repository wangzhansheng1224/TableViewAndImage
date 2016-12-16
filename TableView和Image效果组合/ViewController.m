//
//  ViewController.m
//  TableView和Image效果组合
//
//  Created by 王战胜 on 2016/12/15.
//  Copyright © 2016年 gocomtech. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *headimage;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *nameArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithWhite:0.98 alpha:1];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.automaticallyAdjustsScrollViewInsets=YES;
    [self initdata];
    [self.view addSubview:self.tableView];
    [self createTitleView];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initdata{
    NSArray *imageArr1=@[@"uc_img_person",@"uc_img_favorite",@"uc_img_clear"];
    NSArray *imageArr2=@[@"uc_img_about",@"uc_img_review",@"uc_img_order"];
    NSArray *imageArr3=@[@"uc_img_share"];
    [self.imageArr addObject:imageArr1];
    [self.imageArr addObject:imageArr2];
    [self.imageArr addObject:imageArr3];
    NSArray *nameArr1=@[@"个人中心",@"我的收藏",@"清理缓存"];
    NSArray *nameArr2=@[@"关于我们",@"评价我们",@"意见反馈"];
    NSArray *nameArr3=@[@"分享应用"];
    [self.nameArr addObject:nameArr1];
    [self.nameArr addObject:nameArr2];
    [self.nameArr addObject:nameArr3];
}

- (void)createTitleView{
    //背景图
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 225)];
    self.imageView.image=[UIImage imageNamed:@"uc_img_bg"];
    [self.view addSubview:self.imageView];
    
    //头像
    self.headimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.headimage.image=[UIImage imageNamed:@"uc_img_icon"];
    [self.view addSubview:self.headimage];
    self.headimage.center=self.imageView.center;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView=[[UIView alloc]init];
        _tableView.rowHeight=50;
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.nameArr[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.nameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.imageView.image=[UIImage imageNamed:self.imageArr[indexPath.section][indexPath.row]];
    cell.textLabel.text=self.nameArr[indexPath.section][indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 225)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 225;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}



#pragma mark -- 核心
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<=0) {
        [self.view bringSubviewToFront:self.imageView];
        [self.view bringSubviewToFront:self.headimage];
        CGRect frame=self.imageView.frame;
        frame.size.width=(1-scrollView.contentOffset.y/225)*SCREEN_WIDTH;
        frame.size.height=(1-scrollView.contentOffset.y/225)*225;
        frame.origin.x=-(frame.size.width-SCREEN_WIDTH)/2;
        self.imageView.frame=frame;
        self.headimage.center=self.imageView.center;
        
    }else{
        [self.view bringSubviewToFront:scrollView];
        CGRect frame=self.imageView.frame;
        frame.origin.y=-scrollView.contentOffset.y/2.5;
        self.imageView.frame=frame;
        self.headimage.center=self.imageView.center;

    }
    
}

//状态栏白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr=[[NSMutableArray alloc]init];
    }
    return _imageArr;
}

- (NSMutableArray *)nameArr{
    if (!_nameArr) {
        _nameArr=[[NSMutableArray alloc]init];
    }
    return _nameArr;
}
@end
