// ViewController.h
#import <UIKit/UIKit.h>
#import "NetworkManager.h"

@interface ViewController : UIViewController <NetworkManagerDelegate>
@property (nonatomic, strong) NetworkManager *networkManager;
@end

// ViewController.m
#import "ViewController.h"

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkManager = [[NetworkManager alloc] init];
    self.networkManager.delegate = self; // Use weak reference in NetworkManager
    [self.networkManager makeNetworkRequest];
}

- (void)networkRequestDidComplete:(NetworkManager *)manager withData:(NSData *)data {
    // Handle the network response
}

- (void)dealloc {
    NSLog(@"ViewController deallocated");
}
@end

// NetworkManager.h
#import <Foundation/Foundation.h>

@protocol NetworkManagerDelegate <NSObject>
- (void)networkRequestDidComplete:(NetworkManager *)manager withData:(NSData *)data;
@end

@interface NetworkManager : NSObject
@property (nonatomic, weak) id<NetworkManagerDelegate> delegate; // Use weak reference
- (void)makeNetworkRequest;
@end

// NetworkManager.m
#import "NetworkManager.h"

@implementation NetworkManager
- (void)makeNetworkRequest {
    // Simulate a network request
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ 
        if (self.delegate) {
            [self.delegate networkRequestDidComplete:self withData:[NSData data]];
        }
    });
}
@end