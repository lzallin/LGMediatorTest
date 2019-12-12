//
//  LGMediator.h
//  组件化Demo
//
//  Created by allin on 2019/12/10.
//  Copyright © 2019 LG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DetailViewControllerProtocol <NSObject>
-(__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)url;
@end

@interface LGMediator : NSObject

+(__kindof UIViewController *)detailViewWithUrl:(NSString *)url;

typedef void(^LGMediatorProcessBlcok)(NSDictionary *);
+(void)registerScheme:(NSString *)scheme processBlcok:(LGMediatorProcessBlcok)processBlock;
+(void)openUrl:(NSString *)url params:(NSDictionary *)params;

+(void)registerProtocol:(Protocol *)proto cls:(Class)cls;
+(Class)classForProtocol:(Protocol *)proto;

@end

NS_ASSUME_NONNULL_END
