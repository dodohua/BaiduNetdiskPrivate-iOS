//
//  NSObject+SwizzleBlock.h
//  playnow
//
//  Created by allen du on 17/1/18.
//  Copyright © 2017年 dodohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#if !(TARGET_IPHONE_SIMULATOR)
#define performSelector(slf,selector,returnType,...)({\
Class slfCls = [slf class];\
Method slfForwardMethod = class_getInstanceMethod(slfCls, selector);\
returnType (*slfForwardIMP)(id,...);\
slfForwardIMP = (returnType (*)(id,...))method_getImplementation(slfForwardMethod);\
id paramStart = [[NSObject alloc]init];\
slfForwardIMP(slf, selector,paramStart,__VA_ARGS__);})
#else
// 在模拟器情况下
#define performSelector(slf,selector,returnType,...)({\
Class slfCls = [slf class];\
Method slfForwardMethod = class_getInstanceMethod(slfCls, selector);\
returnType (*slfForwardIMP)(id,...);\
slfForwardIMP = (returnType (*)(id,...))method_getImplementation(slfForwardMethod);\
slfForwardIMP(slf, selector,__VA_ARGS__);})
#endif

#define performSuperSelector(slf,selector,returnType,...)({\
NSString *selectorName = NSStringFromSelector(selector);\
selectorName = [NSString stringWithFormat:@"%@%@",@"kmhook_",selectorName];\
SEL KMselector = NSSelectorFromString(selectorName);\
performSelector(slf, KMselector, returnType, __VA_ARGS__);\
})
//block隐藏参数只有一个就是当前的self
typedef struct selBlockPair { SEL aSEL; id (^__unsafe_unretained aBlock)(id, ...); } selBlockPair;
#define NIL_PAIR ((struct selBlockPair) { 0, 0 })
#define PAIR_LIST (struct selBlockPair [])
#define BLOCK_CAST (id (^)(id, ...))
@interface NSObject (kmHookBlock)
+(void)hookSelectorWithBlock:(selBlockPair *)impls;
- (id)performSuperSelector:(SEL)aSelector withArguments:(NSArray *)arguments;

-(void)printAllSelector;
@end
