//
//  RCTGetuiIdoModule3.m
//  RCTGetuiIdoModule3
//
//  Created by admin on 17/2/27.
//  Copyright © 2017年 getui. All rights reserved.
//

#import "RCTGetuiIdoModule.h"

#if __has_include(<React/RCTBridge.h>)
#import <React/RCTEventDispatcher.h>
#import <React/RCTRootView.h>
#import <React/RCTBridge.h>
#import <React/RCTLog.h>
#import <React/RCTEventEmitter.h>

#elif __has_include("RCTBridge.h")
#import "RCTEventDispatcher.h"
#import "RCTRootView.h"
#import "RCTBridge.h"
#import "RCTLog.h"
#import "RCTEventEmitter.h"
#elif __has_include("React/RCTBridge.h")
#import "React/RCTEventDispatcher.h"
#import "React/RCTRootView.h"
#import "React/RCTBridge.h"
#import "React/RCTLog.h"
#import "React/RCTEventEmitter.h"

#endif

#import <PushKit/PushKit.h>


@interface RCTGetuiIdoModuleEvent : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic) id body;
@end
@implementation RCTGetuiIdoModuleEvent
@end


@interface RCTGetuiIdoModule ()
@property (nonatomic, strong) NSMutableArray<RCTGetuiIdoModuleEvent *> *cachedEvents;
@end


@implementation RCTGetuiIdoModule

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();
+ (instancetype)sharedGetuiIdoModule {
    static RCTGetuiIdoModule *module;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        module = [[super allocWithZone:NULL] init];
        [module setup];
    });
    return module;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedGetuiIdoModule];
}

- (instancetype)init {
    if ((self = [super init])) {
        NSLog(@"IDOSDK>>>init self:%@",self);
    }
    return self;
}

- (void)setup {
    NSLog(@"IDOSDK>>>setup");
    self.cachedEvents = [NSMutableArray array];
}

//需要等待bridge被RN初始化后，才能回调JS
- (void)setBridge:(RCTBridge *)bridge {
    NSLog(@"IDOSDK>>>setBridge %@", bridge);
    _bridge = bridge;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performCachedEvents];
    });
    //     dont work
    //    dispatch_async(self.methodQueue, ^{
    //        [self performCachedEvents];
    //    });
}

- (RCTBridge *)bridge {
    return _bridge;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

//RCT_EXPORT_METHOD(createClient:(NSDictionary *) options
//                  resolver:(RCTPromiseResolveBlock)resolve
//                  rejecter:(RCTPromiseRejectBlock)reject) {
//
//
//    NSLog(@"IDOSDK>>>createClient bridge:%@ self:%@",[self bridge], self);
//    resolve([NSNumber numberWithInt:123]);
//}
//
//RCT_EXPORT_METHOD(resume)
//{
//   NSLog(@"IDOSDK>>>resume self:%@",self);
//    [self.bridge.eventDispatcher sendDeviceEventWithName:@"GeTuiSdkDidRegisterClient"
//                                                    body:@{@"event": @"closing"
//                                                           }];
//}

- (void)performCachedEvents {
    for (RCTGetuiIdoModuleEvent *event in self.cachedEvents) {
        [self getui_sendAppEventWithName:event.name body:event.body];
    }
    [self.cachedEvents removeAllObjects];
}

- (void)getui_sendAppEventWithName:(NSString *)name body:(id)body {
#if DEBUG
    NSLog(@"IDOSDK>>>sendEvent name:%@ body:%@", name, body);
#endif
    
    if(self.bridge) {
        [self.bridge.eventDispatcher sendDeviceEventWithName:name body:body];
    }else {
        RCTGetuiIdoModuleEvent *event = [[RCTGetuiIdoModuleEvent alloc] init];
        event.name = name;
        event.body = body;
        [self.cachedEvents addObject:event];
    }
}

//MARK: - GTCountSDKDelegate

- (void)GTCountSDKDidReceiveGtcid:(NSString *)gtcid error:(NSError *)error {
    NSLog(@"IDOSDK>>>GTCountSDKDidReceiveGtcid %@",gtcid);
    [self getui_sendAppEventWithName:@"GTCountSDKDidReceiveGtcid"
                                body:gtcid];
}

//MARK: -- SDK


//+ (void)startSDKWithAppId:(NSString *)appId withChannelId:(NSString *)channelId delegate:(id<GTCountSDKDelegate>)delegate;
/**
 *  销毁SDK，并且释放资源
 */
RCT_EXPORT_METHOD(startSdk:(NSString *)appId withChannelId:(NSString *)channelId)
{
    
    NSLog(@"IDOSDK>>>startSDKWithAppId %@ %@", appId, channelId);
    [GTCountSDK startSDKWithAppId:appId withChannelId:channelId delegate:self];
}

RCT_EXPORT_METHOD(version:(RCTResponseSenderBlock)callback)
{
    NSLog(@"IDOSDK>>>version");
    callback(@[[GTCountSDK sdkVersion]]);
}
 
RCT_EXPORT_METHOD(gtcid:(RCTResponseSenderBlock)callback)
{
    NSLog(@"IDOSDK>>>gtcid");
    NSString *gtcid = [GTCountSDK gtcid]?:@"";
    callback(@[gtcid]);
}

//MARK: - Properties

RCT_EXPORT_METHOD(setDebugEnable:(BOOL)isDebug)
{
   NSLog(@"IDOSDK>>>setDebugEnable %@", @(isDebug));
    [GTCountSDK setDebugEnable:isDebug];
}

RCT_EXPORT_METHOD(setApplicationGroupIdentifier:(NSString*)identifier)
{
    NSLog(@"IDOSDK>>>setApplicationGroupIdentifier %@", identifier);
    [GTCountSDK setApplicationGroupIdentifier:identifier];
}
 
RCT_EXPORT_METHOD(setSessionTime:(NSInteger)sessionTime)
{
   NSLog(@"IDOSDK>>>setSessionTime %@", @(sessionTime));
   [GTCountSDK sharedInstance].sessionTime = sessionTime;
}

RCT_EXPORT_METHOD(setMinAppActiveDuration:(NSInteger)minAppActiveDuration)
{
   NSLog(@"IDOSDK>>>setMinAppActiveDuration %@", @(minAppActiveDuration));
   [GTCountSDK sharedInstance].minAppActiveDuration = minAppActiveDuration;
}

RCT_EXPORT_METHOD(setMaxAppActiveDuration:(NSInteger)maxAppActiveDuration)
{
   NSLog(@"IDOSDK>>>setMaxAppActiveDuration %@", @(maxAppActiveDuration));
   [GTCountSDK sharedInstance].maxAppActiveDuration = maxAppActiveDuration;
}
 
RCT_EXPORT_METHOD(setEventUploadInterval:(NSInteger)eventUploadInterval)
{
   NSLog(@"IDOSDK>>>setEventUploadInterval %@", @(eventUploadInterval));
   [GTCountSDK sharedInstance].eventUploadInterval = eventUploadInterval;
}
 
RCT_EXPORT_METHOD(setEventForceUploadSize:(NSInteger)eventForceUploadSize)
{
   NSLog(@"IDOSDK>>>setEventForceUploadSize %@", @(eventForceUploadSize));
   [GTCountSDK sharedInstance].eventForceUploadSize = eventForceUploadSize;
}
 
RCT_EXPORT_METHOD(setProfileUploadInterval:(NSInteger)profileUploadInterval)
{
   NSLog(@"IDOSDK>>>setProfileUploadInterval %@", @(profileUploadInterval));
   [GTCountSDK sharedInstance].profileUploadInterval = profileUploadInterval;
}
 
RCT_EXPORT_METHOD(setProfileForceUploadSize:(NSInteger)profileForceUploadSize)
{
   NSLog(@"IDOSDK>>>setProfileForceUploadSize %@", @(profileForceUploadSize));
   [GTCountSDK sharedInstance].profileForceUploadSize = profileForceUploadSize;
}

RCT_EXPORT_METHOD(setUserId:(NSString*)userId)
{
   NSLog(@"IDOSDK>>>setUserId %@", userId);
   [GTCountSDK sharedInstance].userId = userId;
}

RCT_EXPORT_METHOD(setSyncGenerateGtcid:(BOOL)syncGenerateGtcid)
{
   NSLog(@"IDOSDK>>>setSyncGenerateGtcid %@", @(syncGenerateGtcid));
   [GTCountSDK sharedInstance].syncGenerateGtcid = syncGenerateGtcid;
}

RCT_EXPORT_METHOD(registerEventProperties:(NSDictionary*)properties)
{
   NSLog(@"IDOSDK>>>registerEventProperties %@", properties);
    [GTCountSDK registerEventProperties:properties];
}

//MARK: - Track

RCT_EXPORT_METHOD(trackCustomKeyValueEventBegin:(NSString *)eventId)
{
   NSLog(@"IDOSDK>>>trackCustomKeyValueEventBegin %@", eventId);
    [GTCountSDK trackCustomKeyValueEventBegin:eventId];
}


RCT_EXPORT_METHOD(trackCustomKeyValueEventEnd:(NSString *)eventId withArgs:(NSDictionary *)args withExt:(NSString *)ext)
{
   NSLog(@"IDOSDK>>>trackCustomKeyValueEventEnd %@", eventId);
    [GTCountSDK trackCustomKeyValueEventEnd:eventId withArgs:args withExt:ext];
}

RCT_EXPORT_METHOD(trackCountEvent:(NSString *)eventId withArgs:(NSDictionary *)args withExt:(NSString *)ext)
{
   NSLog(@"IDOSDK>>>trackCountEvent %@", eventId);
    [GTCountSDK trackCountEvent:eventId withArgs:args withExt:ext];
}
  
RCT_EXPORT_METHOD(setProfile:(NSDictionary *)profiles withExt:(NSString *)ext)
{
   NSLog(@"IDOSDK>>>setProfile %@", profiles);
    [GTCountSDK setProfile:profiles withExt:ext];
}
 

@end

