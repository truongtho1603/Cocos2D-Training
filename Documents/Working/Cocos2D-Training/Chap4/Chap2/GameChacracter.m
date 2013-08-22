//
//  GameChacracter.m
//  Chap2
//
//  Created by Tho Do on 8/16/13.
//
//

#import "GameChacracter.h"

@implementation GameChacracter

@synthesize characterHealth;
@synthesize characterState;

- (void)dealloc{
    [super dealloc];
}

- (int)getWeaponDamage {
    // Default to zero damage
    CCLOG(@"getWeaponDamage should be overriden");
    return 0;
}

- (void)checkAndClampSpritePosition {
    CGPoint currentSpritePosition = [self position];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Clamp for the ipad
        if (currentSpritePosition.x < 30.0f) {
            [self setPosition:ccp(30.0f, currentSpritePosition.y)];
        }
        else if (currentSpritePosition.x > 1000.0f) {
            [self setPosition:ccp(1000.0f, currentSpritePosition.y)];
        }
    }
    else {
        // Clamp for the iPhone, iPhone 4 or iPod touch
        if (currentSpritePosition.x < 24.0f) {
            [self setPosition:ccp(24.0f, currentSpritePosition.y)];
        }
        else if (currentSpritePosition.x > 456.0f) {
            [self setPosition:ccp(456.0f, currentSpritePosition.y)];
        }
    }
}

@end
