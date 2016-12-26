# CFSearchViewController
一个搜索  带有历史搜索记录
####Bug
* 1.~~导航栏黑色问题~~<br>
 * 解决方法
    
    |   问题   | 方法  |
| ------------- | ------------- |
| ~~导航栏黑色问题~~   | -(void)viewWillAppear:(BOOL)animated{[super viewWillAppear:animated];//self.navigationController.navigationBarHidden=YES; //这样写存在bug[self.navigationController setNavigationBarHidden:YES animated:animated];}  |

      
               
