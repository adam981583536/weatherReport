//
//  ViewController.m
//  天气预报
//
//  Created by 汇文教育 on 16/1/1.
//  Copyright © 2016年 李小红和绿小明. All rights reserved.
//

#import "ViewController.h"
#import "Weather.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@interface ViewController ()

@end

@implementation ViewController{
    NSDictionary *_dataArray;
    NSArray *Myarr;
    NSArray *myValue;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityCode" ofType:@"plist"];
    _dataArray = [[NSDictionary alloc] initWithContentsOfFile:path];
  //  NSLog(@"%@",_dataArray);
    Myarr = [[NSArray alloc] init];
    Myarr = [_dataArray allKeys];
    myValue = [[NSArray alloc] init];
    myValue = [_dataArray allValues];
    
    
    
 //   [self downloadData];
    [self creatPickView];
    [self creatLabel];


}
- (void)creatLabel{
    
    for (int i = 0; i < 6; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i*(50+5), kScreenWidth, 50)];
        label.backgroundColor = [UIColor lightGrayColor];
        label.tag = 100 + i;
        [self.view addSubview:label];
        NSString *str = @"http://www.weather.com.cn/data/sk/101011600.html" ;
        //  NSLog(@"%@",str);
        NSURL *url = [NSURL URLWithString:str];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *jsonError = nil;
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                NSDictionary *dic = [result objectForKey:@"weatherinfo"];
             //   NSLog(@"%@", result);
                
                UILabel *label = (UILabel*) [self.view viewWithTag:100];
                
                UILabel *label1 = (UILabel*) [self.view viewWithTag:101];
                UILabel *label2 = (UILabel*) [self.view viewWithTag:102];
                UILabel *label3 = (UILabel*) [self.view viewWithTag:103];
                UILabel *label4 = (UILabel*) [self.view viewWithTag:104];
                UILabel *label5 = (UILabel*) [self.view viewWithTag:105];
                
                
                
                label.text = [@"城市:   " stringByAppendingString:[dic objectForKey:@"city"]];
                
                label1.text = [@"温度:  " stringByAppendingString:[dic objectForKey:@"temp"] ];
                
                label2.text = [@"风向:  " stringByAppendingString:[dic objectForKey:@"WD"] ];
                
                label3.text = [@"风级:  " stringByAppendingString:[dic objectForKey:@"WS"] ];
                
                label4.text = [@"湿度:  " stringByAppendingString:[dic objectForKey:@"SD"] ];
                
                label5.text = [@"时间:  " stringByAppendingString:[dic objectForKey:@"time"] ];
                

            });
            
            
        }];
        [task resume];
    }

    
}
- (void)downloadData{
        //_arr = [[NSMutableArray alloc] init];
    
    
//    for (int i = 3; i < 17; i++) {
//        
//        NSString *s = [NSString stringWithFormat:@"http://www.weather.com.cn/data/sk/10101%02i00.html",i];
//        NSURL *url = [NSURL URLWithString:s];
//        
//        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        
//        config.timeoutIntervalForRequest = 15;
//
//        config.allowsCellularAccess = YES;
//        
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//        
//        NSURLSessionDataTask *task = [session dataTaskWithURL:url];
//        
//        
//        [task resume];
//
//    }
    
    

}

- (void)creatPickView{

    _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 500, kScreenWidth, kScreenHeight-500)];
    _pickView.delegate = self;
    
    _pickView.dataSource = self;
    _pickView.showsSelectionIndicator = YES;
    
    _pickView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_pickView];

}
#pragma mark - NSURLSessionDelegate


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return _dataArray.count;

}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    
    NSString *str = [NSString stringWithFormat:@"http://www.weather.com.cn/data/sk/%@.html",myValue[row]];
  //  NSLog(@"%@",str);
    NSURL *url = [NSURL URLWithString:str];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod =@"GET";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@",response);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *jsonError = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            NSDictionary *dic = [result objectForKey:@"weatherinfo"];
         //   NSLog(@"%@", result);
            
            UILabel *label = (UILabel*) [self.view viewWithTag:100];
            
            UILabel *label1 = (UILabel*) [self.view viewWithTag:101];
            UILabel *label2 = (UILabel*) [self.view viewWithTag:102];
            UILabel *label3 = (UILabel*) [self.view viewWithTag:103];
            UILabel *label4 = (UILabel*) [self.view viewWithTag:104];
            UILabel *label5 = (UILabel*) [self.view viewWithTag:105];
            
            
            
            label.text = [@"城市:   " stringByAppendingString:[dic objectForKey:@"city"]];
            
            label1.text = [@"温度:  " stringByAppendingString:[dic objectForKey:@"temp"] ];
            
            label2.text = [@"风向:  " stringByAppendingString:[dic objectForKey:@"WD"] ];
            
            label3.text = [@"风级:  " stringByAppendingString:[dic objectForKey:@"WS"] ];
            
            label4.text = [@"湿度:  " stringByAppendingString:[dic objectForKey:@"SD"] ];
            
            label5.text = [@"时间:  " stringByAppendingString:[dic objectForKey:@"time"] ];

        });
        
        
        
    }];
    [task resume];
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{
    
    return [Myarr objectAtIndex:row];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
