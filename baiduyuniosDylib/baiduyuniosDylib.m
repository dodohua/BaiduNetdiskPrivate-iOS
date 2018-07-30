//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  baiduyuniosDylib.m
//  baiduyuniosDylib
//
//  Created by allen du on 2018/7/18.
//  Copyright (c) 2018年 allen. All rights reserved.
//

#import "baiduyuniosDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <MDCycriptManager.h>

#import "BDUser.h"
#import "TransLogRecorder.h"
#import "VIPExpirationManage.h"

#import "SettingManage.h"
#import "DownOperation.h"

#import "NSObject+kmHookBlock.h"

CHConstructor{
    NSLog(INSERT_SUCCESS_WELCOME);
    
    
    Class tarClass = NSClassFromString(@"DownOperation");
    [tarClass hookSelectorWithBlock:PAIR_LIST {
        @selector(downLoadSpeedLimit),
        BLOCK_CAST ^NSNumber *(id slf) {
            NSLog(@"hook befor downLoadSpeedLimit");
            NSNumber* Speed = performSuperSelector(slf, @selector(downLoadSpeedLimit), NSNumber *,nil);
            NSLog(@"origin name is:%@",Speed);
            return [NSNumber numberWithLong:10*1024*1024];//上限10M每秒
        },
        NIL_PAIR}];
    tarClass = NSClassFromString(@"BDUser");
    [tarClass hookSelectorWithBlock:PAIR_LIST {
        @selector(isSVIP),
        BLOCK_CAST ^BOOL (id slf) {
            NSLog(@"hook isSVIP");
            
            return YES;
        },
        @selector(isVIP),
        BLOCK_CAST ^BOOL (id slf) {
            NSLog(@"hook isVIP");
            
            return YES;
        },
        @selector(isExSVIP),
        BLOCK_CAST ^BOOL (id slf) {
            NSLog(@"hook isExSVIP");
            
            return NO;
        },@selector(isExVIP),
        BLOCK_CAST ^BOOL (id slf) {
            NSLog(@"hook isExVIP");
            
            return NO;
        },
        @selector(isExperienceVIP),
        BLOCK_CAST ^BOOL (id slf) {
            NSLog(@"hook isSVIP");
            
            return NO;
        },
        NIL_PAIR}];
    tarClass = NSClassFromString(@"SettingManage");
    [tarClass hookSelectorWithBlock:PAIR_LIST {
        @selector(downloadFileSpeedLimit),
        BLOCK_CAST ^NSNumber *(id slf) {
            NSLog(@"hook befor downLoadSpeedLimit");
            NSNumber* Speed = performSuperSelector(slf, @selector(downloadFileSpeedLimit), NSNumber *,nil);
            NSLog(@"origin name is:%@",Speed);
            return [NSNumber numberWithLong:10*1024*1024];//上限10M每秒
        },
        
        NIL_PAIR}];
    tarClass = NSClassFromString(@"NSOperationQueue");
    [tarClass hookSelectorWithBlock:PAIR_LIST {
        @selector(setMaxConcurrentOperationCount:),
        BLOCK_CAST ^void (id slf,NSInteger count) {
            if(count==1)
            {
                count += 1;//下载列表并发+1,同时下载两个任务
            }
            
            NSLog(@"hook befor setMaxConcurrentOperationCount:%ld",count);
            performSuperSelector(slf, @selector(setMaxConcurrentOperationCount:), void,count);
            
            
        },
        NIL_PAIR}];
    
    tarClass = NSClassFromString(@"ASIHTTPRequest");
    [tarClass hookSelectorWithBlock:PAIR_LIST {
        @selector(url),
        BLOCK_CAST ^id (id slf) {
            NSURL * url = performSuperSelector(slf, @selector(url), id,nil);
//            NSString *orgUrlStr = url.absoluteString;
            NSString *strURL = [url.absoluteString stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"];
            NSURL *newUrl = [NSURL URLWithString:strURL];
//            NSLog(@"org:%@ url_hook %@",orgUrlStr,newUrl);
            return newUrl;
        },
        NIL_PAIR}];
    
}

CHDeclareClass(CustomViewController)



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"

//add new method
CHDeclareMethod1(void, CustomViewController, newMethod, NSString*, output){
    NSLog(@"This is a new method : %@", output);
}

#pragma clang diagnostic pop


CHOptimizedMethod0(self, NSString*, CustomViewController, getMyName){
    //get origin value
    NSString* originName = CHSuper(0, CustomViewController, getMyName);
    
    NSLog(@"origin name is:%@",originName);
    
    //get property
    NSString* password = CHIvar(self,_password,__strong NSString*);
    
    NSLog(@"password is %@",password);
    
    [self newMethod:@"output"];
    
    //set new property
    self.newProperty = @"newProperty";
    
    NSLog(@"newProperty : %@", self.newProperty);
    
    //change the value
    return @"allen du";
    
}

//add new property
CHPropertyRetainNonatomic(CustomViewController, NSString*, newProperty, setNewProperty);

CHConstructor{
    CHLoadLateClass(CustomViewController);
    CHClassHook0(CustomViewController, getMyName);
    
    
    CHHook0(CustomViewController, newProperty);
    CHHook1(CustomViewController, setNewProperty);
    
    
}

