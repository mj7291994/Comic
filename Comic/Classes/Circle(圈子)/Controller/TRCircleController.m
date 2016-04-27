//
//  TRCircleController.m
//  NovelApp
//
//  Created by mj on 16/4/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRCircleController.h"

@interface TRCircleController ()<UIWebViewDelegate>
@property(nonatomic) UIWebView *webView;

@end

@implementation TRCircleController



-(UIWebView *)webView{



    if (!_webView) {
        _webView=[UIWebView new];
        
    }
    
    return _webView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /**去掉分割线*/
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    
    self.webView.frame=self.view.frame;
    [self loadRemoteHTML];
    [self.view addSubview:self.webView];
    
    
}

#pragma mark 加载远程的HTML页面
- (void)loadRemoteHTML {
    
    NSURL *url = [NSURL URLWithString:@"http://www.zeze.com/forum-821-1.html"];

        self.webView.delegate = self;
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
   

   }

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.view showBusyHUD];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.view hideBusyHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view showWarning:@"╭(╯3╰)╮网络不通,请连接网络⊙﹏⊙"];
}


@end
