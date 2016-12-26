//
//  CFSearchView.h
//  CFSearchViewController
//
//  Created by yssj on 2016/12/24.
//  Copyright © 2016年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CFSearchViewDelegate <NSObject>

- (void)CFSearchViewCancleDidClick;

@end

@interface CFSearchView : UIView

@property (nonatomic, strong) UISearchBar *searchBar;
@property (strong,nonatomic)UIButton *cancelBtn;

@property (nonatomic,weak)id <CFSearchViewDelegate>delegate;

@end
