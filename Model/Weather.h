//
//  Weather.h
//  天气预报
//
//  Created by 汇文教育 on 16/1/1.
//  Copyright © 2016年 李小红和绿小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, strong) NSNumber *temp;
@property (nonatomic, copy) NSString *WD;
@property (nonatomic, strong) NSNumber *WS;
@property (nonatomic, copy) NSString *SD;
@property (nonatomic, copy) NSString *time;
@end
