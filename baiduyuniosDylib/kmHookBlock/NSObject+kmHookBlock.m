//
//  NSObject+SwizzleBlock.m
//  playnow
//
//  Created by allen du on 17/1/18.
//  Copyright © 2017年 dodohua. All rights reserved.
//

#import "NSObject+kmHookBlock.h"

@implementation NSObject (kmHookBlock)
+(void)hookSelectorWithBlock:(selBlockPair *)impls
{
    while (impls && impls->aSEL)
    {
        
        NSString *selectorHookName = NSStringFromSelector(impls->aSEL);
        if (!selectorHookName) {
            break;
        }
        selectorHookName = [NSString stringWithFormat:@"%@%@",@"kmhook_",selectorHookName];
        SEL selectorHook = NSSelectorFromString(selectorHookName);
        
        NSMethodSignature *methodSignature = [self methodSignatureForSelector:selectorHook];
        //if hook selecter has add continue next
        if (methodSignature) {
            impls++;
            continue;
        }
        
        Method origMethod = class_getInstanceMethod([self class], impls->aSEL);
        if (origMethod == nil) {
            origMethod = class_getClassMethod([self class], impls->aSEL);
        }
        //this class dont have this method，so continue next
        if (origMethod == nil) {
            continue;
        }
        const char * typeDescription = (char *)method_getTypeEncoding(origMethod);
        
        
        
        //必须要把原方法加进来 must add org selector
        
        //NSLog(@"typeDescription%s",typeDescription);
        IMP orgIMP = class_getMethodImplementation([self class], impls->aSEL);
        class_addMethod([self class],
                        impls->aSEL,
                        orgIMP,
                        method_getTypeEncoding(origMethod));
        
        class_addMethod([self class], selectorHook, imp_implementationWithBlock(impls->aBlock), typeDescription);
        Method hookMethod = class_getInstanceMethod([self class], selectorHook);
        method_exchangeImplementations(origMethod, hookMethod);
        
        impls++;
    }
}
- (id)performSuperSelector:(SEL)aSelector withArguments:(NSArray *)arguments {
    NSString *selectorName = NSStringFromSelector(aSelector);
    selectorName = [NSString stringWithFormat:@"%@%@",@"kmhook_",selectorName];
    SEL selectorHook = NSSelectorFromString(selectorName);
    return [self performSelector:selectorHook withArguments:arguments];
}


-(id)performSelector:(SEL)aSelector withArguments:(NSArray *)arguments
{
    if (aSelector == nil) return nil;
    
    if (arguments==nil||arguments.count<=0) {
        Class slfCls = [self class];
        Method slfForwardMethod = class_getInstanceMethod(slfCls, aSelector);
        id (*slfForwardIMP)(id, SEL);
        slfForwardIMP = (id (*)(id, SEL))method_getImplementation(slfForwardMethod);
        id returnVal;
        returnVal = slfForwardIMP(self, aSelector);
        return returnVal;
    }
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    if (!signature) {
        return nil;
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    //[invocation retainArguments];
    // invocation 有2个隐藏参数，所以 argument 从2开始  两个隐藏参数为self 和sel
    if ([arguments isKindOfClass:[NSArray class]]&&arguments.count>0) {
        NSLog(@"参数个数%ld",signature.numberOfArguments);
        NSInteger count = signature.numberOfArguments;//MIN(arguments.count, signature.numberOfArguments - 2);
        for (int i = 2; i < count; i++) {
            //const char *type = [signature getArgumentTypeAtIndex: i];
            
            // 需要做参数类型判断然后解析成对应类型，这里默认所有参数均为OC对象
            //if (strcmp(type, "@") == 0) {
                id argument = arguments[i-2];
                [invocation setArgument:&argument atIndex:i];
            //}
        }
    }
    
    [invocation invoke];
    
    id returnVal;
    if (strcmp(signature.methodReturnType, "@") == 0) {
        [invocation getReturnValue:&returnVal];
    }
    // 需要做返回类型判断。比如返回值为常量需要包装成对象，这里仅以最简单的`@`为例
    return returnVal;
    
}

-(void)printAllSelector
{
    int i = 0;
    unsigned int mc = 0;
    
    const char* className = class_getName([self class]);
    
    Method* mlist = class_copyMethodList([self class], &mc);
    for (i = 0; i < mc; i++)
    {
        Method method = mlist[i];
        SEL methodSelector = method_getName(method);
        const char* methodName = sel_getName(methodSelector);
        
        const char *typeEncodings = method_getTypeEncoding(method);
        
        char returnType[80];
        method_getReturnType(method, returnType, 80);
        
        NSLog(@"%s ==> %s (%s)", className, methodName, (typeEncodings == Nil) ? "" : typeEncodings);
        
        int ac = method_getNumberOfArguments(method);
        int a = 0;
        for (a = 0; a < ac; a++) {
            char argumentType[80];
            method_getArgumentType(method, a, argumentType, 80);
            NSLog(@"   Argument no #%d: %s", a, argumentType);
        }
    }
}
@end
