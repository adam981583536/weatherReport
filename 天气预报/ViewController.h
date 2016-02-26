//
//  ViewController.h
//  天气预报
//
//  Created by 汇文教育 on 16/1/1.
//  Copyright © 2016年 李小红和绿小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,NSURLSessionDataDelegate>
{
    
    NSMutableArray *_arr;
    UIPickerView *_pickView;
    
    
    
}
@end

