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
#define ArrayLazyLoad(x) if (!x) { x = [NSMutableArray new];}return x

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;      //组头背景
@property (nonatomic, strong) UIImageView *headimage;      //头像
@property (nonatomic, strong) UILabel *nameLabel;          //名字
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *nameArr;
@property (nonatomic, strong) UIView *footerView;          //表尾
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithWhite:0.97 alpha:1];
    [self initdata];
    [self createTitleView];
    [self.view addSubview:self.tableView];
    
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

#pragma mark -- 组头
- (void)createTitleView{
    //背景图
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 225)];
    self.imageView.image=[UIImage imageNamed:@"uc_img_bg"];
    [self.view addSubview:self.imageView];
    
    //头像
    self.headimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.headimage.image=[UIImage imageNamed:@"uc_img_icon"];
    self.headimage.center=CGPointMake(self.imageView.center.x, self.imageView.center.y-10);
    [self.view addSubview:self.headimage];
    
    //名字
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    self.nameLabel.text=@"王战胜";
    self.nameLabel.center=CGPointMake(self.imageView.center.x, CGRectGetMaxY(self.headimage.frame)+20);
    self.nameLabel.font=[UIFont systemFontOfSize:20];
    self.nameLabel.textColor=[UIColor whiteColor];
    self.nameLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.nameLabel];
}

- (UIView *)footerView{
    if (!_footerView) {
        _footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
        //版本号
        UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20.0)];
        versionLabel.font = [UIFont systemFontOfSize:13.0];
        versionLabel.text = [NSString stringWithFormat:@"版本:%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        versionLabel.textColor = [UIColor grayColor];
        versionLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:versionLabel];
        [_footerView addSubview:versionLabel];
        
        //版权
        UILabel *copyRightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25,SCREEN_WIDTH, 20.0)];
        copyRightLabel.font = [UIFont systemFontOfSize:13.0];
        copyRightLabel.text = @"Beijing Smartdot Technology Co., Ltd Copyright";
        copyRightLabel.textColor = [UIColor grayColor];
        copyRightLabel.textAlignment = NSTextAlignmentCenter;
        copyRightLabel.backgroundColor = [UIColor clearColor];
        [_footerView addSubview:copyRightLabel];
        
        //退出登录
        UIButton *quitButton=[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(copyRightLabel.frame)+15, SCREEN_WIDTH-100, 40)];
        [quitButton setTitleColor:[UIColor colorWithRed:226/255.0 green:10/255.0 blue:32/255.0 alpha:1] forState:UIControlStateNormal];
        [quitButton setTitle:@"退出登录" forState:UIControlStateNormal];
        quitButton.center=CGPointMake(SCREEN_WIDTH/2, quitButton.center.y);
        quitButton.titleLabel.font=[UIFont systemFontOfSize:17];
        quitButton.layer.borderColor=[UIColor colorWithRed:226/255.0 green:10/255.0 blue:32/255.0 alpha:1].CGColor;
        quitButton.layer.borderWidth=1;
        quitButton.layer.cornerRadius=5;
        quitButton.layer.masksToBounds=YES;
        [_footerView addSubview:quitButton];
        
    }
    return _footerView;
}
#pragma mark -- 创建tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView=self.footerView;
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
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 225)];
        view.backgroundColor=[UIColor clearColor];
        return view;
    }else{
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0.5, SCREEN_WIDTH, 0.5)];
        view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 225;
    }
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor=[UIColor clearColor];
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [view addSubview:line];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

#pragma mark -- 核心
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<=0) {

        CGRect frame=self.imageView.frame;
        frame.size.width=(1-scrollView.contentOffset.y/225)*SCREEN_WIDTH;
        frame.size.height=(1-scrollView.contentOffset.y/225)*225;
        frame.origin.x=-(frame.size.width-SCREEN_WIDTH)/2;
        frame.origin.y=0;
        self.imageView.frame=frame;
        self.headimage.center=CGPointMake(self.imageView.center.x, self.imageView.center.y-10);
        self.nameLabel.center=CGPointMake(self.imageView.center.x, CGRectGetMaxY(self.headimage.frame)+20);
        
        
    }else{
        
        CGRect frame=self.imageView.frame;
        frame.size.width=SCREEN_WIDTH;
        frame.size.height=225;
        frame.origin.x=0;
        frame.origin.y=-scrollView.contentOffset.y/2.5;
        self.imageView.frame=frame;
        self.headimage.center=CGPointMake(self.imageView.center.x, self.imageView.center.y-10);
        self.nameLabel.center=CGPointMake(self.imageView.center.x, CGRectGetMaxY(self.headimage.frame)+20);
    }
}

- (void)dealloc{
    self.tableView=nil;
    self.nameLabel=nil;
    self.headimage=nil;
    self.imageView=nil;
    self.nameLabel=nil;
    self.footerView=nil;
    self.imageArr=nil;
    self.nameArr=nil;
}

//状态栏白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(NSMutableArray *)imageArr{
    ArrayLazyLoad(_imageArr);
}

- (NSMutableArray *)nameArr{
    ArrayLazyLoad(_nameArr);
}
@end
