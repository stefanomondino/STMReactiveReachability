//
//  Reachability+RACExtensions.h
//  Pods
//
//  Created by Stefano Mondino on 28/03/14.
//
//

#import "Reachability.h"
#import <ReactiveCocoa.h>

@interface Reachability (RACExtensions)

//- (RACSignal*) rac_notifyAllNetworkChanges;

+ (RACSignal*) rac_notifyAllNetworkChanges ;
+ (RACSignal*) rac_notifyWifiReachable ;
+ (RACSignal*) rac_notifyWANReachable ;
+ (RACSignal*) rac_notifyReachable ;
@end
