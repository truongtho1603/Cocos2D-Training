//
//  GameObject.m
//  Chap2
//
//  Created by Tho Do on 8/16/13.
//
//

#import "GameObject.h"

@implementation GameObject

@synthesize isActive;
@synthesize reactsToScreenBoundaries;
@synthesize screenSize;
@synthesize gameObjectType;

- (id)init {
    self = [super init];
    if (self != nil) {
        CCLOG(@"Gameobject init");
        screenSize = [[CCDirector sharedDirector] winSize];
        isActive = TRUE;
        gameObjectType = kObjectTypeNone;
    }
    return self;
}

- (void)changeState:(CharacterStates)newState {
    CCLOG(@"GameObject -> changeState method should be overridden");
}

- (void)updateStateWithDeltaTime:(ccTime)deltaTime
            andListOfGameObjects:(CCArray *)listOfGameObjects {
    CCLOG(@"GameObject -> updateStateWithDeltaTime method should be overridden");
}

- (CGRect)adjustedBoundingBox {
    CCLOG(@"GameObject -> adjustBoundingBox should be overridden");
    return [self boundingBox];
}

- (CCAnimation *)loadPlistForAnimationWithName:(NSString *)animationName
                                  andClassName:(NSString *)className {
    CCAnimation *animationToReturn = nil;
    NSString *fullFileName;
    [NSString stringWithFormat:@"%@.plist", className];
    NSString *plistPath;
    
    // 1: Get the path to the plist file
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDemoApplicationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    if ( ![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:className ofType:@"plist"];
    }
    // 2: Read in the plist file
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    // 3: If the pListDictionary was null, the file was not found
    if (plistDictionary == nil) {
        CCLOG(@"Error reading plist: %@.plist", className);
        return nil;
    }
    // 4: Get just the mini-dictionary for this animation
    NSDictionary *animationSettings = [plistDictionary objectForKey:animationName];
    if (animationSettings == nil) {
        CCLOG(@"Could not locate AnimationWithName: %@", animationName);
    }
    // 5: Get the delay value for the animation
    float animationDelay = [[animationSettings objectForKey:@"delay"] floatValue];
    animationToReturn = [CCAnimation animation];
    [animationToReturn setDelayPerUnit:animationDelay];
    // 6: Add the frames to the animation
    NSString *animationFramePrefix = [animationSettings objectForKey:@"filenamePrefix"];
    NSString *animationFrames = [animationSettings objectForKey:@"animationFrames"];
    NSArray *animationFrameNumbers = [animationFrames componentsSeparatedByString:@","];
    
    for (NSString *frameNumber in animationFrameNumbers) {
        NSString *frameName = [NSString stringWithFormat:@"%@%@.png", animationFramePrefix,  frameNumber];
        [animationToReturn addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];
    }
    return animationToReturn;
}

@end
