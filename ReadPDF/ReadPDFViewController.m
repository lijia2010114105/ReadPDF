//
//  ReadPDFViewController.m
//  ReadPDF
//
//  Created by miniso_lj on 2019/6/3.
//  Copyright © 2019年 miniso_lj. All rights reserved.
//

#import "ReadPDFViewController.h"
#import "ReadPDFTool.h"
#import "AppDelegate.h"
#import <QuickLook/QuickLook.h>
#import "MBProgressHUD.h"
#import "Macro.h"

#define CurrentAppDelegate   ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface ReadPDFViewController ()<QLPreviewControllerDataSource,QLPreviewControllerDelegate>
{
    UIButton *rightBtn;
}
@property (strong, nonatomic)QLPreviewController *previewController;
@property (copy, nonatomic)NSURL *fileURL; //文件路径
@end

@implementation ReadPDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *url = @"https://www.tutorialspoint.com/ios/ios_tutorial.pdf";
    
    if (_type == 0) {
        [self initLocalPreviewController];
    } else {
        [self downUrl:url];
    }
    
    [self setRightBtn];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([rightBtn.titleLabel.text isEqualToString:@"竖屏"]) {
        CurrentAppDelegate.allowAcrolls = NO;
        [self orientationToPortrait:UIInterfaceOrientationPortrait];
    }
}

- (void)initPreviewController {
    self.previewController  =  [[QLPreviewController alloc]  init];
    self.previewController.dataSource  = self;
    self.previewController.delegate = self;
    [self addChildViewController:self.previewController];
    self.previewController.view.frame = CGRectMake(0, Height_NavBarAndStatusBar, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT - Height_NavBarAndStatusBar);
    [self.view addSubview:self.previewController.view];
}

- (void)initLocalPreviewController {
    self.previewController  =  [[QLPreviewController alloc]  init];
    self.previewController.dataSource  = self;
    self.fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"职场礼仪.pdf" ofType:nil]];
//    [self presentViewController:self.previewController animated:YES completion:nil];
    [self addChildViewController:self.previewController];
    self.previewController.view.frame = CGRectMake(0, Height_NavBarAndStatusBar, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT - Height_NavBarAndStatusBar);
    [self.view addSubview:self.previewController.view];
}

- (void)downUrl:(NSString *)downUrl {
    MINISOWeakSelf;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ReadPDFTool shareInstance] readPDFFromUrl:downUrl nativeUrlBlock:^(NSURL *nativeUrl, NSInteger successStatus) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (successStatus == 0) {
            weakSelf.fileURL = nativeUrl;
            [weakSelf initPreviewController];
        } else {
            NSLog(@"---下载失败");
        }
    }];
}

- (void)setRightBtn {
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"横屏" forState:UIControlStateNormal];
    rightBtn.backgroundColor = [UIColor blueColor];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(changeScreen:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)changeScreen:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"横屏"]) {
        [btn setTitle:@"竖屏" forState:UIControlStateNormal];
        
        self.previewController.view.frame = CGRectMake(0, Height_NavBar_Landscape, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH - Height_NavBar_Landscape);
        
        CurrentAppDelegate.allowAcrolls = YES;
        [self orientationToPortrait:UIInterfaceOrientationLandscapeRight];
    } else {
        [btn setTitle:@"横屏" forState:UIControlStateNormal];
        
        self.previewController.view.frame = CGRectMake(0, Height_NavBarAndStatusBar, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH - Height_NavBarAndStatusBar);
        
        CurrentAppDelegate.allowAcrolls = NO;
        [self orientationToPortrait:UIInterfaceOrientationPortrait];
    }
}

- (void)orientationToPortrait:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
}

#pragma mark - QLPreviewControllerDataSource
- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    return self.fileURL;
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController{
    return 1;
}

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item
{
    return YES;
}

@end
