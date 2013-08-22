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
#import "Constaints.h"
#import "CommonProtocols.h"
#import "RadarDisk.h"
#import "Viking.h"

@interface GameplayLayer : CCLayer {
    CCSprite *vikingSprite;
    SneakyJoystick *leftJoystick;
    SneakyButton *jumpButton;
    SneakyButton *attackButton;
    CCSpriteBatchNode *sceneSpriteBatchNode;
}

@end
