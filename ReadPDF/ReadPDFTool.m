//
//  ReadPDFTool.m
//  ReadPDF
//
//  Created by miniso_lj on 2019/6/3.
//  Copyright © 2019年 miniso_lj. All rights reserved.
//

#import "ReadPDFTool.h"

static ReadPDFTool *pdfReadToolInstance = nil;

@implementation ReadPDFTool

+ (ReadPDFTool *)shareInstance {
    if (pdfReadToolInstance == nil) {
        @synchronized(self){
            pdfReadToolInstance = [[ReadPDFTool alloc] init];
        }
    }
    return pdfReadToolInstance;
}

- (void)readPDFFromUrl:(NSString*)downUrl nativeUrlBlock:(pdfDownLoadUrlBlock)naviteUrl {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *urlStr = downUrl;
    NSString *fileName = [urlStr lastPathComponent]; //获取文件名称
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //判断是否存在
    if([self isFileExist:fileName]) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
        if (naviteUrl) {
            naviteUrl(url,0);
        }
        
    } else {
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress){
            
        } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
            return url;
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            if (error) {
                if (naviteUrl) {
                    naviteUrl(filePath,-1);
                }
            } else {
                if (naviteUrl) {
                    naviteUrl(filePath,0);
                }
            }
        }];
        [downloadTask resume];
    }
}


//判断文件是否已经在沙盒中存在
-(BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}


@end
