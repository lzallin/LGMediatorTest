//
//  LGMediator.m
//  组件化Demo
//
//  Created by allin on 2019/12/10.
//  Copyright © 2019 LG. All rights reserved.
//

#import "LGMediator.h"

@implementation LGMediator

+(__kindof UIViewController *)detailViewWithUrl:(NSString *)url{
    Class detailView = NSClassFromString(@"DetailViewController");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    UIViewController *viewC = [[detailView alloc] init];
    [viewC performSelector:NSSelectorFromString(@"initWithUrl:") withObject:url];
#pragma clang diagnostic pop
    return viewC;
}

+(NSMutableDictionary *)mediatorCache {
    static NSMutableDictionary *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [NSMutableDictionary new];
    });
    return cache;
}
+(void)registerScheme:(NSString *)scheme processBlcok:(LGMediatorProcessBlcok)processBlock {
    if (scheme && processBlock) {
        [[self mediatorCache] setObject:processBlock forKey:scheme];
    }
}
+(void)openUrl:(NSString *)url params:(NSDictionary *)params{
    LGMediatorProcessBlcok block = [[self mediatorCache] objectForKey:url];
    if (block) {
        block(params);
    }
}

+(void)registerProtocol:(Protocol *)proto cls:(Class)cls {
    if (proto && cls) {
        [[self mediatorCache] setObject:cls forKey:NSStringFromProtocol(proto)];
    }
}
+(Class)classForProtocol:(Protocol *)proto{
    return [[self mediatorCache] objectForKey:NSStringFromProtocol(proto)];
}

@end
