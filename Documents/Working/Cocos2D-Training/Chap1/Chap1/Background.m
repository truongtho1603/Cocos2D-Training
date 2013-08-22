//
//  Background.m
//  Chap1
//
//  Created by Tho Do on 8/14/13.
//
//

#import "Background.h"

@implementation Background

- (id)init {
    self = [super init];
    if (self != nil) {
        CCSprite *backgroundImage;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            backgroundImage = [CCSprite spriteWithFile:@"SpaceCargoShip.png"];
        }
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            backgroundImage = [CCSprite spriteWithFile:@"SpaceCargoShip.png"];
        }
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
        [self addChild:backgroundImage z:0 tag:0];
    }
    return self;
}

@end
