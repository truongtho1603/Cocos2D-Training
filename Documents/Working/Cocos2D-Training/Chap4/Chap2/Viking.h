//
//  Viking.h
//  Chap2
//
//  Created by Tho Do on 8/19/13.
//
//

#import "GameChacracter.h"
#import "SneakyButton.h"
#import "SneakyJoystick.h"
#import "cocos2d.h"

typedef enum {
    kLeftHook,
    kRightHook
} LastPunchType;

@interface Viking : GameChacracter {
    LastPunchType myLastPunch;
    BOOL isCarryingMallet;
    CCSpriteFrame *standingFrame;
    
    // Standing, breathng and walking
    CCAnimation *breathingAnim;
    CCAnimation *breathingMalletAnim;
    CCAnimation *walkingAnim;
    CCAnimation *walkingMalletAnim;
    
    // Crouching, standing and Jumping
    CCAnimation *crouchingAnim;
    CCAnimation *crouchingMalletAnim;
    CCAnimation *standingUpAnim;
    CCAnimation *standingUpMalletAnim;
    CCAnimation *jumpingAnim;
    CCAnimation *jumpingMalletAnim;
    CCAnimation *afterJumpingAnim;
    CCAnimation *afterJumpingMalletAnim;
    
    // Punching
    CCAnimation *rightPunchAnim;
    CCAnimation *leftPunchAnim;
    CCAnimation *malletPunchAnim;
    
    // Taking Damage and Death
    CCAnimation *phaserShockAnim;
    CCAnimation *deathAnim;
    
    SneakyJoystick *joystick;
    SneakyButton *jumpButton;
    SneakyButton *attackButton;
    
    float millisecondsStayingIdle;
}

// Standing, breathng and walking
@property (nonatomic, retain) CCAnimation *breathingAnim;
@property (nonatomic, retain) CCAnimation *breathingMalletAnim;
@property (nonatomic, retain) CCAnimation *walkingAnim;
@property (nonatomic, retain) CCAnimation *walkingMalletAnim;

// Crouching, standing and Jumping
@property (nonatomic, retain) CCAnimation *crouchingAnim;
@property (nonatomic, retain) CCAnimation *crouchingMalletAnim;
@property (nonatomic, retain) CCAnimation *standingUpAnim;
@property (nonatomic, retain) CCAnimation *standingUpMalletAnim;
@property (nonatomic, retain) CCAnimation *jumpingAnim;
@property (nonatomic, retain) CCAnimation *jumpingMalletAnim;
@property (nonatomic, retain) CCAnimation *afterJumpingAnim;
@property (nonatomic, retain) CCAnimation *afterJumpingMalletAnim;

// Punching
@property (nonatomic, retain) CCAnimation *rightPunchAnim;
@property (nonatomic, retain) CCAnimation *leftPunchAnim;
@property (nonatomic, retain) CCAnimation *malletPunchAnim;

// Taking Damage and Death
@property (nonatomic, retain) CCAnimation *phaserShockAnim;
@property (nonatomic, retain) CCAnimation *deathAnim;

@property (nonatomic, assign) SneakyJoystick *joystick;
@property (nonatomic, assign) SneakyButton *jumpButton;
@property (nonatomic, assign) SneakyButton *attackButton;
@end