//
//  Background.m
//  Chap2
//
//  Created by Tho Do on 8/14/13.
//
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer
- (id)init{
    self = [super init];
    if (self != nil) {
        CCSprite *backgroundImage;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            backgroundImage = [CCSprite spriteWithFile:@"background.png"];
        }
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            backgroundImage = [CCSprite spriteWithFile:@"backgroundIphone.png"];
        }
        CGSize size = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:CGPointMake(size.width/1.50f, size.height/2.66f)];
        [self addChild:backgroundImage z:0 tag:0];
    }
    return self;
}

@end
