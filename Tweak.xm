#import <libactivator/libactivator.h>
#import <AudioToolbox/AudioToolbox.h>

extern "C" void AudioServicesPlaySystemSoundWithVibration(SystemSoundID inSystemSoundID, id unknown, NSDictionary *options);

static void hapticFeedbackSoft(){
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    NSMutableArray* arr = [NSMutableArray array];
    [arr addObject:[NSNumber numberWithBool:YES]];
    [arr addObject:[NSNumber numberWithInt:30]];
    [dict setObject:arr forKey:@"VibePattern"];
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"Intensity"];
    AudioServicesPlaySystemSoundWithVibration(4095,nil,dict);
}

static void hapticFeedbackHard(){
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    NSMutableArray* arr = [NSMutableArray array];
    [arr addObject:[NSNumber numberWithBool:YES]];
    [arr addObject:[NSNumber numberWithInt:30]];
    [dict setObject:arr forKey:@"VibePattern"];
    [dict setObject:[NSNumber numberWithInt:2] forKey:@"Intensity"];
    AudioServicesPlaySystemSoundWithVibration(4095,nil,dict);
}



@interface FHActivatorListener : NSObject <LAListener>
@end

@implementation FHActivatorListener

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event forListenerName:(NSString *)listenerName
{
    if ([listenerName isEqualToString:@"com.squ1dd13.fakehaptivator.soft"]) {
        event.handled = YES;
        [self giveHapticFeedbackSoft];
    }
    else if ([listenerName isEqualToString:@"com.squ1dd13.fakehaptivator.hard"]) {
        [self giveHapticFeedbackHard];
    } else {
        event.handled = NO;
    }
}

- (void)giveHapticFeedbackSoft
{
    hapticFeedbackSoft();
}

-(void)giveHapticFeedbackHard
{
    hapticFeedbackHard();
}

- (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName
{
    return [NSArray arrayWithObjects:@"springboard", @"lockscreen", @"application",  nil];
}

+ (void)load
{
    @autoreleasepool
    {
        FHActivatorListener *listener = [[FHActivatorListener alloc] init];
        [[LAActivator sharedInstance] registerListener:listener forName:@"com.squ1dd13.fakehaptivator.soft"];
        [[LAActivator sharedInstance] registerListener:listener forName:@"com.squ1dd13.fakehaptivator.hard"];
    }
}

@end
