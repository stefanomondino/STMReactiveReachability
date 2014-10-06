//
//  Reachability+RACExtensions.m
//  Pods
//
//  Created by Stefano Mondino on 28/03/14.
//
//

#import "Reachability+RACExtensions.h"
#import <objc/runtime.h>
@interface Reachability (RACExtensions)
@property (nonatomic, readonly) RACSignal* rac_reachSignal;
@end

@implementation Reachability (RACExtensions)

+ (Reachability*) shared {
    static Reachability* _reach;
    ;
    if (!_reach) {
        _reach = [Reachability reachabilityForInternetConnection];
        
    }
    return _reach;
}
- (RACSignal *)rac_reachSignal {
    
    typeof(self) wself = self;
    RACSignal* r = objc_getAssociatedObject(self, @"kReachabilitySignal");
    if (!r){
        
        r = [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            wself.reachableBlock = ^(Reachability* r){
                [subscriber sendNext:r];
            };
            wself.unreachableBlock = ^(Reachability* r){
                [subscriber sendNext:r];
            };
            [wself startNotifier];
            [subscriber sendNext:wself];
            return [RACDisposable disposableWithBlock:^{
                [self stopNotifier];
            }];
        }]
              publish]
             autoconnect];
        
        objc_setAssociatedObject(self, @"kReachabilitySignal", r, OBJC_ASSOCIATION_RETAIN);
    }
    return r;
}
/*
- (RACSignal*) rac_notifyAllNetworkChanges {
    __weak Reachability* reach = self;
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        reach.reachableBlock = ^(Reachability* r){
            [subscriber sendNext:r];
        };
        reach.unreachableBlock = ^(Reachability* r){
            [subscriber sendNext:r];
        };
        [reach startNotifier];
        [subscriber sendNext:reach];
        return [RACDisposable disposableWithBlock:^{
            [reach stopNotifier];
        }];
    }]
             publish]
            autoconnect];
}
*/


+ (RACSignal*) rac_notifyAllNetworkChanges {
    return [[Reachability shared].rac_reachSignal startWith:[Reachability shared]];
}
+ (RACSignal*) rac_notifyWifiReachable {
    return [[Reachability shared].rac_reachSignal map:^id(Reachability* value) {
        return @(value.isReachableViaWiFi);
    }];
}
+ (RACSignal*) rac_notifyWANReachable {
    return [[Reachability shared].rac_reachSignal map:^id(Reachability* value) {
        return @(value.isReachableViaWWAN);
    }];
}
+ (RACSignal*) rac_notifyReachable {
    return [[[Reachability shared].rac_reachSignal map:^id(Reachability* value) {
        return @(value.isReachable);
    }]
            distinctUntilChanged];
}
@end
