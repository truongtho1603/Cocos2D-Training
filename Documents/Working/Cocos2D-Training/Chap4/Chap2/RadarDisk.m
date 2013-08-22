//
//  RadarDisk.m
//  Chap2
//
//  Created by Tho Do on 8/19/13.
//
//

#import "RadarDisk.h"

@implementation RadarDisk

@synthesize tiltingAnim;
@synthesize trasmittingAnim;
@synthesize takingAHitAnim;
@synthesize blowingUpAnim;

- (void) dealloc {
    [tiltingAnim release];
    [trasmittingAnim release];
    [takingAHitAnim release];
    [blowingUpAnim release];
    [super dealloc];
}

- (void)changeState:(CharacterStates)newState {
    [self stopAllActions];
    id action = nil;
    [self setCharacterState:newState];
    
    switch (newState) {
        case kStateSpawning:
            CCLOG(@"RadarDish->Startiing the Spawning Animation");
            action = [CCAnimate actionWithAnimation:tiltingAnim];
            [action setRestoreOriginalFrame:NO];
            break;
        case kStateIdle:
            CCLOG(@"RadarDish->Changing state to Idle");
            action = [CCAnimate actionWithAnimation:trasmittingAnim];
            [action setRestoreOriginalFrame:NO];
            break;
        case kStateTakingDamage:
            CCLOG(@"RadarDish->Changing state to TakingDamage");
            characterHealth = characterHealth - [vikingCharacter getWeaponDamage];
            if (characterHealth <= 0.0f) {
                [self changeState:kStateDead];
            }
            else {
                action = [CCAnimate actionWithAnimation:takingAHitAnim];
                [action setRestoreOriginalFrame:NO];
            }
            break;
        case kStateDead:
            CCLOG(@"RadarDish->Changing state to Dead");
            action = [CCAnimate actionWithAnimation:blowingUpAnim];
            [action setRestoreOriginalFrame:NO];
            break;
        default:
            CCLOG(@"Unhandled state %d in RadarDish", newState);
            break;
    }
    if (action != nil) {
        [self runAction:action];
    }
}

- (void)updateStateWithDeltaTime:(ccTime)deltaTime
            andListOfGameObjects:(CCArray *)listOfGameObjects {
    if (characterState == kStateDead) {
        return;
    }
    vikingCharacter = (GameChacracter *)[[self parent] getChildByTag:kVikingSpriteTagValue];
    CGRect vikingBoundingBox = [vikingCharacter adjustedBoundingBox];
    CharacterStates vikingState = [vikingCharacter characterState];
    
    // Calculate if the Viking is attacking and nearby.
    if ((vikingState == kStateAttacking) && (CGRectIntersectsRect([self adjustedBoundingBox], vikingBoundingBox))) {
        if (characterState != kStateTakingDamage) {
            // If RadarDish is NOT already taking Damage
            [self changeState:kStateTakingDamage];
            return;
        }
    }
    if (([self numberOfRunningActions] == 0) && (characterState != kStateDead)) {
        CCLOG(@"Going to Idle");
        [self changeState:kStateIdle];
        return;
    }
}

- (void)initAnimations {
    [self setTiltingAnim:[self loadPlistForAnimationWithName:@"tiltingAnim"
                                                andClassName:NSStringFromClass([self class])]];
    [self setTrasmittingAnim:[self loadPlistForAnimationWithName:@"trasmittingAnim"
                                                     andClassName:NSStringFromClass([self class])]];
    [self setTakingAHitAnim:[self loadPlistForAnimationWithName:@"takingAHitAnim"
                                                    andClassName:NSStringFromClass([self class])]];
    [self setBlowingUpAnim:[self loadPlistForAnimationWithName:@"blowingUpAnim"
                                                    andClassName:NSStringFromClass([self class])]];
}

-(id)init {
    /*
     if ((self = [super init])) {
     }
     */
    self = [super init];
    if (self != nil) {
        CCLOG(@"### RadarDish Initialized");
        [self initAnimations];
        characterHealth = 100.0f;
        gameObjectType = kEnemyTypeRadarDish;
        [self changeState:kStateSpawning];
    }
    return self;
}

@end
