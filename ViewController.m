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

@property (nonatomic, strong) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
//    [self.tableView setTableHeaderView:self.searchController.searchBar];
    [self setupSearchBar];
    [self.tableView setTableHeaderView:self.searchBar];

}

- (void)setupSearchBar{
    
    self.searchBar = [[UISearchBar alloc]init];
    
    self.searchBar.frame = CGRectMake(0, viewOffset, SCREEN_WIDTH, 44);
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"搜索";
    self.searchBar.barTintColor=[UIColor groupTableViewBackgroundColor];
    [self.searchBar.layer setBorderWidth:0.5f];
    [self.searchBar.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    
}

#pragma mark -UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
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
    
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
//    nav.navigationBar.hidden=YES;
    [self presentViewController:nav  animated:NO completion:nil];
    
    
    
    
    
    
    
    
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

- (void)cancelButtonClickEvent{
    
    [UIView animateWithDuration:0.3 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        //1.
        self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        self.searchBar.transform = CGAffineTransformIdentity;
        //2.
        self.searchBar.showsCancelButton = NO;
        [self.searchBar endEditing:YES];
        //3.
//        [self.popView dismissThePopView];
    }];
    
    self.searchBar.placeholder = @"搜索";
    [self.searchBar setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
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


- (UISearchController *)searchController {
    if (!_searchController) {
        // 1.创建热门搜索
        NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
        
        // 2. 创建控制器
        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
            // 开始搜索执行以下代码
            // 如：跳转到指定控制器
            [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
        }];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nav];
        //        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.placeholder = @"搜索";
        
        _searchController.searchBar.barTintColor=[UIColor groupTableViewBackgroundColor];
        [_searchController.searchBar.layer setBorderWidth:0.5f];
        [_searchController.searchBar.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
        //        [_searchController.searchBar.layer setBorderColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0].CGColor];
        _searchController.view.backgroundColor=[[UIColor grayColor]colorWithAlphaComponent:0.5];
        
        
        [_searchController.searchBar sizeToFit];
        
    }
    return _searchController;
}



@end
