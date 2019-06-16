//
//  Macro.h
//  ReadPDF
//
//  Created by miniso_lj on 2019/6/3.
//  Copyright © 2019年 miniso_lj. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define MAINSCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
///获取设备屏幕宽度
#define MAINSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width

#define Height_NavBar_Landscape 32  //横屏状态下，导航栏高度为32

// 适配iPhone x
#define IS_IPHONE_X                     ((MAINSCREEN_HEIGHT >= 812.0f) ? YES : NO)
#define Height_StatusBar                ((IS_IPHONE_X == YES) ? 44.0f : 20.0f)
#define Height_NavBarAndStatusBar       ((IS_IPHONE_X == YES) ? 88.0f : 64.0f)
#define Height_TabBar                   ((IS_IPHONE_X == YES) ? 83.0f : 49.0f)

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define MINISOWeakSelf __weak typeof(self) weakSelf = self;


#endif /* Macro_h */
