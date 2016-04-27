//
//  TRNetManager.h
//  NovelApp
//
//  Created by mj on 16/4/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ImageListModel.h"
#import "ChapterListModel.h"
#import "BookModel.h"
#import "ImageListModel.h"
@interface TRNetManager : NSObject
/**漫画书列表*/
+(id)getBookModel:(NSString *)comicName :(NSString *)comicType completionHandler:(void (^)(BookModel *, NSError *))completionHandler;

/**章节列表*/
+(id)getChapterListModel:(NSString*)comicName completionHandler:(void(^)(ChapterListModel * model,NSError *error)) completionHandler;
/**漫画图片列表*/
+(id)getImageListModel:(NSString*)comicName chapterId:(NSInteger)chapterId    completionHandler:(void(^)(ImageListModel *modle,NSError *error))completionHandler;




@end
