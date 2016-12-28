# CFSearchViewController
一个搜索  带有历史搜索记录
####Bug

|问题        |    方法       |
|----------- |   :------------- |
|~~导航栏黑色问题~~|                                         `       -(void)viewWillAppear:(BOOL)animated    {    [superviewWillAppear:animated]; self.navigationController.navigationBarHidden=YES;//这样写存在bug       [self.navigationController setNavigationBarHidden:YES animated:animated];   }` |

      
               
