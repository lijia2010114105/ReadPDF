//
//  ReadPDFTool.h
//  ReadPDF
//
//  Created by miniso_lj on 2019/6/3.
//  Copyright © 2019年 miniso_lj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLSessionManager.h"

typedef void(^pdfDownLoadUrlBlock)(NSURL *nativeUrl, NSInteger successStatus);

NS_ASSUME_NONNULL_BEGIN

@interface ReadPDFTool : NSObject

+ (ReadPDFTool *)shareInstance;

- (void)readPDFFromUrl:(NSString*)downUrl nativeUrlBlock:(pdfDownLoadUrlBlock)naviteUrl;

@end

NS_ASSUME_NONNULL_END
