//
//  SMLagMonitor.m
//
//  Created by DaiMing on 16/3/28.
//

#import "SMLagMonitor.h"
#import "SMCallStack.h"
#import "SlowRecordManager.h"

@interface SMLagMonitor() {
    int timeoutCount;
    CFRunLoopObserverRef runLoopObserver;
    @public
    dispatch_semaphore_t dispatchSemaphore;
    CFRunLoopActivity runLoopActivity;
    int shortTimeoutCount;
    CFAbsoluteTime lastShortTimeoutTime;
}

@end

@implementation SMLagMonitor

#pragma mark - Interface
+ (instancetype)shareInstance {
    static id instance = nil;
    static dispatch_once_t dispatchOnce;
    dispatch_once(&dispatchOnce, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)beginMonitor {
    timeoutCount = 0;
    shortTimeoutCount = 0;
    lastShortTimeoutTime = 0;
    //监测卡顿
    if (runLoopObserver) {
        return;
    }
    dispatchSemaphore = dispatch_semaphore_create(0); //Dispatch Semaphore保证同步
    //创建一个观察者
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                              kCFRunLoopAllActivities,
                                              YES,
                                              0,
                                              &runLoopObserverCallBack,
                                              &context);
    //将观察者添加到主线程runloop的common模式下的观察中
    CFRunLoopAddObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
    
    //创建子线程监控
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //子线程开启一个持续的loop用来进行监控
        while (YES) {
            long semaphoreWait = dispatch_semaphore_wait(dispatchSemaphore, dispatch_time(DISPATCH_TIME_NOW, 100*NSEC_PER_MSEC));
            if (semaphoreWait != 0) {
                if (!runLoopObserver) {
                    timeoutCount = 0;
                    dispatchSemaphore = 0;
                    runLoopActivity = 0;
                    return;
                }
                //两个runloop的状态，BeforeSources和AfterWaiting这两个状态区间时间能够检测到是否卡顿
                if (runLoopActivity == kCFRunLoopBeforeSources || runLoopActivity == kCFRunLoopAfterWaiting) {
                    // 连续出现5次，表示有长时间的卡顿
                    if (++timeoutCount < 5) {
                        if (timeoutCount == 1) {
                            CFAbsoluteTime nowTime = CFAbsoluteTimeGetCurrent();
                            NSLog(@"短卡顿 %d", shortTimeoutCount);
                            if (lastShortTimeoutTime > 0 && nowTime-lastShortTimeoutTime > 0.5) {
                                // 超出一定时间重新计算次数
                                shortTimeoutCount = 0;
                            }
                            lastShortTimeoutTime = nowTime;
                            // 连续短卡顿
                            if (++shortTimeoutCount >= 5) {
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                                    NSString *stackLog = [SMCallStack callStackWithType:SMCallStackTypeMain];
                                    NSLog(@"%@", stackLog);
                                    [[SlowRecordManager shareInstance] addShortSlowRecord:stackLog];
                                });
                                shortTimeoutCount = 0;
                                lastShortTimeoutTime = 0;
                            }
                        }
                        continue;
                    }
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                        NSString *stackLog = [SMCallStack callStackWithType:SMCallStackTypeMain];
                        NSLog(@"%@", stackLog);
                        [[SlowRecordManager shareInstance] addLongSlowRecord:stackLog];
                    });
                } //end activity
            }// end semaphore wait
            timeoutCount = 0;
        }// end while
    });
    
}

- (void)endMonitor {
    if (!runLoopObserver) {
        return;
    }
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
    CFRelease(runLoopObserver);
    runLoopObserver = NULL;
}

#pragma mark - Private

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    SMLagMonitor *lagMonitor = (__bridge SMLagMonitor*)info;
    lagMonitor->runLoopActivity = activity;
    
    dispatch_semaphore_t semaphore = lagMonitor->dispatchSemaphore;
    dispatch_semaphore_signal(semaphore);
}

@end
