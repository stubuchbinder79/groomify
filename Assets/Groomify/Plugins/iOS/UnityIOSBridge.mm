//
//  UnityIOSBridge.m
//  iosUnityPlugin
//
//  Created by Stu Buchbinder on 5/24/20.
//  Copyright © 2020 Stu Buchbinder. All rights reserved.
//

#import "UnityIOSBridge.h"
#import "Unity/UnityInterface.h"


extern "C" void unityLoadProgress(const char *progress) {
    NSString *progressStr = [NSString stringWithUTF8String:progress];
    NSLog(@"onUnityLoadProgress: %@", progressStr);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UNITY_LOAD_PROGRESS_NOTIFICATION" object:progressStr];
}

extern "C" void unityLoadComplete() {
        NSLog(@"onUnityLoadComplete");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UNITY_LOAD_COMPLETE_NOTIFICATION" object:nil];
}

@implementation UnityIOSBridge


@end
