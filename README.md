# CFSearchViewController
一个搜索  带有历史搜索记录
####Bug

<table>
    <tr>
        <th>问题</th>
        <th>解决方法</th>
    </tr>
    <tr>
        <td>导航栏黑色问题</td>
        <td>-(void)viewWillAppear:(BOOL)animated {<br>
            [superviewWillAppear:animated];<br>
            //self.navigationController.navigationBarHidden=YES;//这样写存在bug<br>
            [self.navigationController setNavigationBarHidden:YES                animated:animated];<br>  
}</td>
    </tr>
</table>

      
               
