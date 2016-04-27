//
//  TRSearchBar.m
//  新浪项目01
//
//  Created by mj on 16/4/6.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRSearchBar.h"

@implementation TRSearchBar

+(instancetype)SeacherBar{


    return [[self alloc]init];
    
}


-(instancetype)initWithFrame:(CGRect)frame{


    if (self=[super initWithFrame:frame]) {
        
       
        //设置背景 用九宫切图法
        self.background=[UIImage  resizedImage:@"searchbar_textfield_background"];
        
        
        //设置内容--垂直居中
        self.contentVerticalAlignment=UIControlContentHorizontalAlignmentCenter;
        //设置左边显示一个放大镜
        UIImageView *leftView=[UIImageView new];
        //设置放大镜图片
        leftView.image=[UIImage imageNamed:@"searchbar_textfield_search_icon"];
        //设置放大镜的宽 
       
        leftView.width=leftView.width+10;
        
        //设置放大镜的内容居中
        leftView.contentMode=UIViewContentModeCenter;
        //将放大镜添加到文本框
        self.leftView=leftView;
        //设置文本框左边的View 永久显示
        self.leftViewMode=UITextFieldViewModeAlways;
        //清除按钮永久显示
        self.clearButtonMode=UITextFieldViewModeAlways;
             

        
        
    }
    return self ;
    
}
@end
