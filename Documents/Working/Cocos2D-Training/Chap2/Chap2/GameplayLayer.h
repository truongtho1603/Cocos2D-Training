//
//  GameplayLayer.h
//  Chap2
//
//  Created by Tho Do on 8/14/13.
//
//

#import "CCLayer.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"

@interface GameplayLayer : CCLayer {
    CCSprite *vikingSprite;
    SneakyJoystick *leftJoystick;
    SneakyButton *jumpButton;
    SneakyButton *attackButton;
}

@end
