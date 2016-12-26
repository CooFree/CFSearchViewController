//
//  CFSearchView.m
//  CFSearchViewController
//
//  Created by yssj on 2016/12/24.
//  Copyright © 2016年 CooFree. All rights reserved.
//

#import "CFSearchView.h"

@interface CFSearchView()<UISearchBarDelegate>

@end

@implementation CFSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.9];
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    [self addSubview:[self headView]];
}
- (UIView *)headView {
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
    view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [view addSubview:self.cancelBtn];
    [view addSubview:self.searchBar];
    return view;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame=CGRectMake(self.frame.size.width-44, 20, 40, 44);
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return  _cancelBtn;
}

- (void)cancelBtnClick {
    if ([self.delegate respondsToSelector:@selector(CFSearchViewCancleDidClick)]) {
        [self.searchBar endEditing:YES];
        [self.delegate CFSearchViewCancleDidClick];
    }
}


- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.frame = CGRectMake(0, 20, self.frame.size.width-40, 44);
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.barTintColor=[UIColor groupTableViewBackgroundColor];
        [_searchBar.layer setBorderWidth:0.5f];
        [_searchBar.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
    }
    return _searchBar;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
