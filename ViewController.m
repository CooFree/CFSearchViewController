//
//  ViewController.m
//  CFSearchViewController
//
//  Created by yssj on 2016/12/21.
//  Copyright © 2016年 CooFree. All rights reserved.
//

#import "ViewController.h"
#import "PYSearchViewController.h"
#import "PYTempViewController.h"
#import "CFSearchView.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
static CGFloat viewOffset = 64;

@interface ViewController ()<UISearchBarDelegate,PYSearchViewControllerDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (strong, nonatomic) PYSearchViewController *searchController;
@property (strong,nonatomic)UIButton *cancelBtn;
@property (nonatomic,strong)CFSearchView *searchView;

@end

@implementation ViewController

- (UITableView *)tableView {
    if (!_tableView) {
          _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height+20) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor whiteColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self.view addSubview:self.tableView];
    [self.tableView setTableHeaderView:[self headView]];

    
}

#pragma mark -UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [self addChildViewController:self.searchController];
    [self.searchController didMoveToParentViewController:self];
//    [self.view addSubview:self.searchView];
//    self.searchView.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);

    
    [UIView animateWithDuration:0.35 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -viewOffset);
        self.tableView.transform = CGAffineTransformMakeTranslation(0, -44);
        self.searchBar.frame = CGRectMake(0, 20, SCREEN_WIDTH-40, 44);
        
        /* 如果加在此处会出现bug （searchBar无法endEditing）*/
//        [self.view addSubview:self.searchController.view];
    }completion:^(BOOL finished) {

        [self.view addSubview:self.searchController.view];
      
    }];


}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // 如果有搜索文本且显示搜索建议，则隐藏
    self.searchController.baseSearchTableView.hidden = searchText.length && !self.searchController.searchSuggestionHidden;
    // 根据输入文本显示建议搜索条件
    self.searchController.searchSuggestionVC.view.hidden = self.searchController.searchSuggestionHidden || !searchText.length;
    if (self.searchController.searchSuggestionVC.view.hidden) { // 搜索建议隐藏
        // 清空搜索建议
        self.searchController.searchSuggestions = nil;
    }
    // 放在最上层
    [self.view bringSubviewToFront:self.searchController.searchSuggestionVC.view];
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜索完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            self.searchController.searchSuggestions = searchSuggestionsM;
        });
    }
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜索完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}
- (void)didClickCancel:(PYSearchViewController *)searchViewController {
//    [self cancelButtonClickEvent];
    [self cancelBtnClick];
}



#pragma mark - 懒加载

- (UIView *)headView {
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    //    [view addSubview:self.cancelBtn];
    [view addSubview:self.searchBar];
    return view;
}
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        
        _searchBar.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.barTintColor=[UIColor groupTableViewBackgroundColor];
        [_searchBar.layer setBorderWidth:0.5f];
        [_searchBar.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    }
    return _searchBar;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame=CGRectMake(SCREEN_WIDTH-44, 20, 40, 44);
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return  _cancelBtn;
}
- (void)cancelBtnClick {
    [self.searchController removeFromParentViewController];
    
    [UIView animateWithDuration:0.35 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        self.tableView.transform = CGAffineTransformIdentity;
        self.searchBar.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
        [self.searchBar endEditing:YES];
        self.searchBar.text=nil;
        
        self.navigationController.navigationBarHidden=NO;
        
        [self.searchController.view removeFromSuperview];
        self.searchController=nil;
    }completion:^(BOOL finished) {
    }];
}

- (PYSearchViewController *)searchController {
    if (!_searchController) {
        
        // 1.创建热门搜索
        NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
        // 2. 创建控制器
        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
            // 开始搜索执行以下代码
            // 如：跳转到指定控制器
            [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
        }];
        // 3. 设置风格
        
        searchViewController.hotSearchStyle = 0; // 热门搜索风格根据选择
        searchViewController.searchHistoryStyle = PYSearchHistoryStyleNormalTag; // 搜索历史风格为default
        searchViewController.searchResultShowMode=PYSearchResultShowModePush;
        // 4. 设置代理
        searchViewController.delegate = self;
        
        _searchController=searchViewController;
        
    }
    return _searchController;
}
- (CFSearchView *)searchView {
    if (!_searchView) {
        _searchView=[[CFSearchView alloc]init];
        _searchView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.9];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [_searchView addGestureRecognizer:tap];
    }
    return _searchView;
}
- (void)tapClick {
    [_searchView removeFromSuperview];
    [self cancelBtnClick];
}
/*
//        // 1.创建热门搜索
//        NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
//
//        // 2. 创建控制器
//        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
//            // 开始搜索执行以下代码
//            // 如：跳转到指定控制器
//            [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
//        }];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
//        _searchController = [[UISearchController alloc]initWithSearchResultsController:nav];
//        //        _searchController.searchResultsUpdater = self;
//        _searchController.dimsBackgroundDuringPresentation = NO;
//        _searchController.hidesNavigationBarDuringPresentation = YES;
//        _searchController.searchBar.placeholder = @"搜索";
//
//        _searchController.searchBar.barTintColor=[UIColor groupTableViewBackgroundColor];
//        [_searchController.searchBar.layer setBorderWidth:0.5f];
//        [_searchController.searchBar.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
//        //        [_searchController.searchBar.layer setBorderColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0].CGColor];
//        _searchController.view.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.5];
//
//
//        [_searchController.searchBar sizeToFit];



 - (void)setupCancelButton{
 
 UIButton *cancelButton = [self.searchBar valueForKey:@"_cancelButton"];
 [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
 [cancelButton addTarget:self action:@selector(cancelButtonClickEvent) forControlEvents:UIControlEventTouchUpInside];
 
 }
 - (void)cancelButtonClickEvent{
 
 [UIView animateWithDuration:0.3 animations:^{
 [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
 //1.
 self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
 self.searchBar.transform = CGAffineTransformIdentity;
 self.tableView.transform = CGAffineTransformIdentity;
 
 //2.
 self.searchBar.showsCancelButton = NO;
 [self.searchBar endEditing:YES];
 //3.
 //        [self.popView dismissThePopView];
 }];
 
 self.searchBar.placeholder = @"搜索";
 [self.searchBar setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
 }
 */
@end
