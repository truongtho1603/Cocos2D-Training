//
//  GameScene.m
//  Chap2
//
//  Created by Tho Do on 8/14/13.
//
//

#import "GameScene.h"

@implementation GameScene

- (id)init {
    self = [super init];
    if (self != nil) {
        BackgroundLayer *backgroundLayer = [BackgroundLayer node];
        [self addChild:backgroundLayer z:0];
        GameplayLayer *gameplayLayer = [GameplayLayer node];
        [self addChild:gameplayLayer z:5];
    }
    return self;
}

@end
