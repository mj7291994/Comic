//
//  TRSearchController.m
//  NovelApp
//
//  Created by mj on 16/4/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRSearchController.h"
#import "TRSearchBar.h"
#import "TRChapterListController.h"
#import "TRComicImageCell.h"

@interface TRSearchController ()<UITextFieldDelegate>
@property(nonatomic)NSString *comicName;
@property(nonatomic) TRSearchBar *searchBar;
@property(nonatomic)BookViewModel * bookVM;


@end

@implementation TRSearchController
#pragma mark 懒加载
-(BookViewModel *)bookVM{
    if (!_bookVM) {
        _bookVM=[BookViewModel new];
    }
    return _bookVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib
    nibWithNibName:@"TRComicImageCell" bundle:nil]
         forCellReuseIdentifier:@"ComicCell"];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(Search)] ;
     self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)] ;
//    设置导航栏的标题视图
    
    TRSearchBar *searchBar=  [TRSearchBar SeacherBar];
    searchBar.width=300 ;
    searchBar.height=30;
    searchBar.delegate=self;
    searchBar.keyboardType=UIKeyboardAppearanceDefault;
    searchBar.returnKeyType=UIReturnKeyGoogle;
    
    
    self.searchBar=searchBar;
    self.navigationItem.titleView=searchBar;
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{


[self.searchBar resignFirstResponder];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{


    [self Search];
    [self.searchBar resignFirstResponder];

    return YES;
    
}

-(void)back{
//返回
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)Search{
    self.bookVM.bookList=nil;
    self.comicName=self.searchBar.text;

        [self.bookVM getBookModel:self.comicName comicType:@"" completionHandler:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                error? [self.view showWarning:@"找不到漫画╮(╯▽╰)╭,打开方式不对！"]:[self.tableView reloadData];
                [self.tableView endFooterRefresh];
            });
        }];
    
    [self.tableView reloadData];
    
//    if (self.bookVM.bookList.count<=0) {
//        
//        [self.view showWarning:@"找不到漫画╮(╯▽╰)╭,打开方式不对！"];
//        
//    }

    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.bookVM.bookList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TRComicImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ComicCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    /**封面图片*/
    NSString *imagePath=[self.bookVM iconNameForIndex:row];
    
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:imagePath]
                          placeholderImage:[UIImage imageNamed:@"mine_icon_big_nor"]];
    cell.iconImageView.contentMode=UIViewContentModeScaleAspectFit;
    /**漫画名字*/
    cell.nameLabel.text=[self.bookVM nameForIndex:row];
    
    NSString *str=@([self.bookVM lastUpdateForIndex:row]).stringValue;
    
    
    NSDateFormatter *fmt=[NSDateFormatter new];
    fmt.dateFormat=@"yyyyMMdd";
    NSDate *date=[fmt dateFromString:str];
    fmt.dateFormat=@"yyyy-MM-dd";
    NSString *strs= [fmt stringFromDate:date];
    
    cell.lastUpdateLable.text=strs;

    
    /**漫画是否完结*/
    cell.isFinishLabel.text=[self.bookVM finishForIndex:row]?@"已完结":@"连载中";
    cell.layer.cornerRadius=4.0;
    cell.layer.borderWidth=0.3;
    cell.layer.borderColor=[UIColor grayColor].CGColor;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TRChapterListController*chapterListVC = [[TRChapterListController alloc] init];
    chapterListVC.comictitle=[self.bookVM nameForIndex:indexPath.row];
    chapterListVC.iconName=[self.bookVM iconNameForIndex:indexPath.row ];
    chapterListVC.comicDesc=[self.bookVM descForIndex:indexPath.row];
    chapterListVC.updaTime=[self.bookVM lastUpdateForIndex:indexPath.row];
    chapterListVC.comicType=[self.bookVM typeForIndex:indexPath.row];
    chapterListVC.comicArea=[self.bookVM areaForIndex:indexPath.row];
    chapterListVC.isFinish=[self.bookVM finishForIndex:indexPath.row];
    [self.navigationController pushViewController:chapterListVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 100;
    
}

@end
