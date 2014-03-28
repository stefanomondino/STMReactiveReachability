# STMReactiveReachability

[![Version](http://cocoapod-badges.herokuapp.com/v/STMReactiveReachability/badge.png)](http://cocoadocs.org/docsets/STMReactiveReachability)
[![Platform](http://cocoapod-badges.herokuapp.com/p/STMReactiveReachability/badge.png)](http://cocoadocs.org/docsets/STMReactiveReachability)

A simple drop-in category for Reachability to enable ReactiveCocoa functionalities.

## Usage

To run the example project; clone the repo, and run `pod install` from the STMReactiveReachabilityExample directory first.

Basic usage :

```  objective-c
	[[[Reachability reachabilityForInternetConnection] rac_notifyAllNetworkChanges] subscribeNext:^(Reachability* reachability) {
        //Do what you need with reachability
    }];
```
## Installation

STMReactiveReachability is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "STMReactiveReachability"

## Author

Stefano Mondino, stefano.mondino.dev@gmail.com

Contributions are really welcome!

## License

STMReactiveReachability is available under the MIT license. See the LICENSE file for more info.

