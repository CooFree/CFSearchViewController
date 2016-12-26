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

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
static CGFloat viewOffset = 64;

@interface ViewController ()<UISearchBarDelegate,PYSearchViewControllerDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (strong, nonatomic) PYSearchViewController *searchController;
@property (strong,nonatomic)UIButton *cancelBtn;
@end

@implementation ViewController

- (UITableView *)tableView {
    if (!_tableView) {
          _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        
    }
    return _tableView;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
//   [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    
    //    [self.tableView setTableHeaderView:self.searchController.searchBar];
    [self setupSearchBar];
  
    [self.view addSubview:self.tableView];
    
    [self.tableView setTableHeaderView:[self headView]];

    
    
}
- (UIView *)headView {
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    [view addSubview:self.cancelBtn];
    [view addSubview:self.searchBar];
    return view;
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
    [UIView animateWithDuration:0.35 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        self.tableView.transform = CGAffineTransformIdentity;
        self.searchBar.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
        [self.searchBar endEditing:YES];
        self.searchBar.text=nil;
        
        self.navigationController.navigationBarHidden=NO;
        
        [self.searchController.view removeFromSuperview];
        [self.searchController removeFromParentViewController];
        self.searchController=nil;
    }completion:^(BOOL finished) {
    }];
}
- (void)setupSearchBar{
    
    self.searchBar = [[UISearchBar alloc]init];
    
    self.searchBar.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"搜索";
    self.searchBar.barTintColor=[UIColor groupTableViewBackgroundColor];
    [self.searchBar.layer setBorderWidth:0.5f];
    [self.searchBar.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    
//    [self.view addSubview:self.searchBar];
}

#pragma mark -UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    
    
    [UIView animateWithDuration:0.35 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -viewOffset);
        self.tableView.transform = CGAffineTransformMakeTranslation(0, -44);
        self.searchBar.frame = CGRectMake(0, 20, SCREEN_WIDTH-40, 44);

    }completion:^(BOOL finished) {
        
        // 5. 跳转到搜索控制器
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
        //    nav.navigationBar.hidden=YES;
//        [self presentViewController:nav  animated:NO completion:nil];
        
//        self.navigationController.navigationBarHidden=YES;
//        self.searchController.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.searchController.view.backgroundColor=[UIColor brownColor];
        [self addChildViewController:self.searchController];
        [self.view addSubview:self.searchController.view];
        
    }];


    
    
    
    
    
    
    
    
//    [UIView animateWithDuration:0.3 animations:^{
//        //1.
//        self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -viewOffset);
//        self.searchBar.transform = CGAffineTransformMakeTranslation(0, -44);
//
//        //2.
//        self.searchBar.showsCancelButton = YES;
//        [self setupCancelButton];
//        
////        [self.popView showThePopViewWithArray:self.titleArray];
//    }];
}

- (void)setupCancelButton{
    
    UIButton *cancelButton = [self.searchBar valueForKey:@"_cancelButton"];
    [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClickEvent) forControlEvents:UIControlEventTouchUpInside];
    
}
/*
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

- (PYSearchViewController *)searchController {
    if (!_searchController) {
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
        searchViewController.searchHistoryStyle = PYSearchHistoryStyleBorderTag; // 搜索历史风格为default
        // 4. 设置代理
        searchViewController.delegate = self;
        
//        searchViewController.searchBar=self.searchBar;
        _searchController=searchViewController;
        
    }
    return _searchController;
}



@end
