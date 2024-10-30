#import <React/RCTBridgeModule.h>
#import <TrainerVideoSDK/TrainerVideoSDK.h>

@interface RCT_EXTERN_MODULE(BridgeRn, NSObject)

RCT_EXTERN_METHOD(launchVideoEditor:(NSString *)urlString
                  secondURL:(nullable NSString *)secondURL
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
