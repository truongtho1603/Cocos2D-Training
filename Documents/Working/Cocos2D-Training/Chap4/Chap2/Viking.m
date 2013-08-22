//
//  Viking.m
//  Chap2
//
//  Created by Tho Do on 8/19/13.
//
//

#import "Viking.h"

@implementation Viking

@synthesize joystick;
@synthesize jumpButton;
@synthesize attackButton;

// Standing, breathing and walking
@synthesize breathingAnim;
@synthesize breathingMalletAnim;
@synthesize walkingAnim;
@synthesize walkingMalletAnim;
// Crouching, standing up, jumping
@synthesize crouchingAnim;
@synthesize crouchingMalletAnim;
@synthesize standingUpAnim;
@synthesize standingUpMalletAnim;
@synthesize jumpingAnim;
@synthesize jumpingMalletAnim;
@synthesize afterJumpingAnim;
@synthesize afterJumpingMalletAnim;
// Punching
@synthesize rightPunchAnim;
@synthesize leftPunchAnim;
@synthesize malletPunchAnim;
// Taking damage and death
@synthesize phaserShockAnim;
@synthesize deathAnim;

- (void)dealloc {
    joystick = nil;
    jumpButton = nil;
    attackButton = nil;
    [breathingAnim release];
    [breathingMalletAnim release];
    [walkingAnim release];
    [walkingMalletAnim release];
    [crouchingAnim release];
    [crouchingMalletAnim release];
    [standingUpAnim release];
    [standingUpMalletAnim release];
    [jumpingAnim release];
    [jumpingMalletAnim release];
    [afterJumpingAnim release];
    [afterJumpingMalletAnim release];
    [rightPunchAnim release];
    [leftPunchAnim release];
    [malletPunchAnim release];
    [phaserShockAnim release];
    [deathAnim release];
    
    [super dealloc];
}

- (void)applyJoystick:(SneakyJoystick *)aJoystick
         forTimeDelta:(float)deltaTime{
    CGPoint scaledVelocity = ccpMult(aJoystick.velocity, 128.0f);
    CGPoint oldPosition = [self position];
    CGPoint newPosition = ccp(oldPosition.x + scaledVelocity.x * deltaTime, oldPosition.y);
    [self setPosition:newPosition];

    if (oldPosition.x > newPosition.x) {
        self.flipX = YES;
    }
    else {
        self.flipX = NO;
    }
}

- (void)checkAndClampSpritePosition {
    if (self.characterState != kStateJumping) {
        if ([self position].y > 110.0f) {
            [self setPosition:ccp([self position].x, 110.0f)];
        }
    }
    [super checkAndClampSpritePosition];
}

// Easier to navigate to other method containing hyphen (-)
#pragma mark -
- (void)changeState:(CharacterStates)newState {
    [self stopAllActions];
    id action = nil;
    id movementAction = nil;
    CGPoint newPosition;
    [self setCharacterState:newState];
    
    switch (newState) {
        case kStateIdle: {
            if (isCarryingMallet) {
                [self setDisplayFrame:
                 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_mallet_1.png"]];
            }
            else {
                [self setDisplayFrame:
                 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_anim_1.png"]];
            }
            break;
        }
        case kStateWalking: {
            if (isCarryingMallet) {
                action = [CCAnimate actionWithAnimation:walkingMalletAnim];
                [action setRestoreOriginalFrame:NO];
            }
            else {
                action = [CCAnimate actionWithAnimation:walkingAnim];
                [action setRestoreOriginalFrame:NO];
            }
            break;
        }
        case kStateCrouching: {
            if (isCarryingMallet) {
                action = [CCAnimate actionWithAnimation:crouchingMalletAnim];
                [action setRestoreOriginalFrame:NO];
            }
            else {
                action = [CCAnimate actionWithAnimation:crouchingAnim];
                [action setRestoreOriginalFrame:NO];
            }
            break;
        }
        case kStateStandingUp: {
            if (isCarryingMallet) {
                action = [CCAnimate actionWithAnimation:standingUpMalletAnim];
                [action setRestoreOriginalFrame:NO];
            }
            else {
                action = [CCAnimate actionWithAnimation:standingUpAnim];
                [action setRestoreOriginalFrame:NO];
            }
            break;
        }
        case kStateBreathing: {
            if (isCarryingMallet) {
                action = [CCAnimate actionWithAnimation:breathingMalletAnim];
                [action setRestoreOriginalFrame:YES];
            }
            else {
                action = [CCAnimate actionWithAnimation:breathingAnim];
                [action setRestoreOriginalFrame:YES];
            }
            break;
        }
        case kStateJumping: {
            newPosition = ccp(screenSize.width * 0.2f, 0.0f);
            if ([self flipX] == YES) {
                newPosition = ccp(newPosition.x * -1.0f, 0.0f);
            }
            movementAction = [CCJumpBy actionWithDuration:0.5f
                                                 position:newPosition
                                                   height:160.0f
                                                    jumps:1]; // parabolic movement for Ole the Viking
            if (isCarryingMallet) {
                // Viking Jumping animation with Mallet
                id temp = [CCAnimate actionWithAnimation:crouchingMalletAnim];
                [temp setRestoreOriginalFrame:NO];
                id temp2 = [CCAnimate actionWithAnimation:jumpingMalletAnim];
                [temp2 setRestoreOriginalFrame:YES];
                id temp3 = [CCAnimate actionWithAnimation:afterJumpingMalletAnim];
                [temp3 setRestoreOriginalFrame:NO];
                
                // CCSequence actions: ties all actions together
                // CCSpawn actions: more than 1 action at the same time
                action = [CCSequence actions:temp, [CCSpawn actions:temp2, movementAction, nil], temp3, nil];
            }
            else {
                // Viking Jumping animation without the Mallet: cai gay
                id temp = [CCAnimate actionWithAnimation:crouchingAnim];
                [temp setRestoreOriginalFrame:NO];
                id temp2 = [CCAnimate actionWithAnimation:jumpingAnim];
                [temp2 setRestoreOriginalFrame:YES];
                id temp3 = [CCAnimate actionWithAnimation:afterJumpingAnim];
                [temp3 setRestoreOriginalFrame:NO];
                action = [CCSequence actions:temp, [CCSpawn actions:temp2, movementAction, nil], temp3, nil];
            }
            break;
        }
        case kStateAttacking: {
            if (isCarryingMallet == YES) {
                action = [CCAnimate actionWithAnimation:malletPunchAnim];
                [action setRestoreOriginalFrame:YES];
            }
            else {
                if (kLeftHook == myLastPunch) {
                    // Execute a right hook
                    myLastPunch = kRightHook;
                    action = [CCAnimate actionWithAnimation:rightPunchAnim];
                    [action setRestoreOriginalFrame:NO];
                }
                else {
                    myLastPunch = kLeftHook;
                    action = [CCAnimate actionWithAnimation:leftPunchAnim];
                    [action setRestoreOriginalFrame:NO];
                }                
            }
            break;
        }
        case kStateTakingDamage: {
            self.characterHealth = self.characterHealth - 10.0f;
                action = [CCAnimate actionWithAnimation:phaserShockAnim];
                [action setRestoreOriginalFrame:YES];
            break;
        }
        case kStateDead: {
            action = [CCAnimate actionWithAnimation:deathAnim];
            [action setRestoreOriginalFrame:NO];
            break;
        }
        default:
            break;
    }
    if (action != nil) {
        [self runAction:action];
    }
}

#pragma mark -
- (void)updateStateWithDeltaTime:(ccTime)deltaTime
            andListOfGameObjects:(CCArray *)listOfGameObjects {
    if (self.characterState == kStateDead) {
        return;
    }
    if ( (self.characterState == kStateTakingDamage) && ([self numberOfRunningActions] > 0) ) {
        return; // currently playing the taking damage animation
        
        // check for collisions
        // change this to keep the object count from querying it each time
        CGRect myBoundingBox = [self adjustedBoundingBox];
        for (GameChacracter *character in listOfGameObjects) {
            // This is Ole the Viking himself
            // No need to check collision with one's self
            if ([character tag] == kVikingSpriteTagValue)
                continue;
            
            CGRect characterBox = [character adjustedBoundingBox];
            if (CGRectIntersectsRect(myBoundingBox, characterBox)) {
                // Remove the PhaserBullet from scene
                if ([character gameObjectType] == kEnemyTypePhaser) {
                    [self changeState:kStateTakingDamage];
                    [character changeState:kStateDead];
                }
                else if ([character gameObjectType] == kPowerUpTypeMallet) {
                    // Update the frame to indicate Viking is
                    // carrying the mallet
                    isCarryingMallet = YES;
                    [self changeState:kStateIdle];
                    // remove the mallet from the scene
                    [character changeState:kStateDead];
                }
                else if ([character gameObjectType] == kPowerUpTypeHealth) {
                    [self setCharacterHealth:100.0f];
                    // Remove the health power-up from the scene
                    [character changeState:kStateDead];
                }
            }
        }
        [self checkAndClampSpritePosition];
        if ((self.characterState == kStateIdle) ||
            (self.characterState == kStateWalking) ||
            (self.characterState == kStateCrouching) ||
            (self.characterState == kStateStandingUp) ||
            (self.characterState == kStateBreathing)) {
            
            if (jumpButton.active) {
                [self changeState:kStateJumping];
            }
            else if (attackButton.active) {
                [self changeState:kStateAttacking];
            }
            else if ((joystick.velocity.x == 0.0f) && (joystick.velocity.y == 0.0f)) {
                if (self.characterState == kStateCrouching) {
                    [self changeState:kStateStandingUp];
                }
            }
            else if (joystick.velocity.y < -0.45f) {
                if (self.characterState != kStateCrouching) {
                    [self changeState:kStateCrouching];
                }
            }
            else if (joystick.velocity.x != 0.0f) { // dpad moving
                if (self.characterState != kStateWalking) {
                    [self changeState:kStateWalking];
                }
                [self applyJoystick:joystick
                       forTimeDelta:deltaTime];
            }
        }
        
        if ([self numberOfRunningActions] == 0) {
            // not playing an animation
            if (self.characterHealth <= 0.0f) {
                [self changeState:kStateDead];
            }
            else if (self.characterState == kStateIdle) {
                millisecondsStayingIdle = millisecondsStayingIdle + deltaTime;
                if (millisecondsStayingIdle > kVikingIdleTimer) {
                    [self changeState:kStateBreathing];
                }
            }
            else if ((self.characterState != kStateCrouching) &&
                     (self.characterState != kStateIdle)) {
                millisecondsStayingIdle = 0.0f;
                [self changeState:kStateIdle];
            }
        }        
    }
}

#pragma mark -
- (CGRect)adjustedBoundingBox {
    // adjust the bounding box to the size of the sprite
    // without the transparent space
    CGRect vikingBoundingBox = [self boundingBox];
    float xOffset;
    float xCropAmount = vikingBoundingBox.size.width * 0.5482f;
    float yCropAmount = vikingBoundingBox.size.height * 0.095f;
    
    if ([self flipX] == NO) {
        // Viking is facing to the right, back is on the left
        xOffset = vikingBoundingBox.size.width * 0.1566f;
    }
    else {
        // Viking is facing to the left, back facing right
        xOffset = vikingBoundingBox.size.width * 0.4217f;
    }
    vikingBoundingBox = CGRectMake(vikingBoundingBox.origin.x + xOffset,
                                   vikingBoundingBox.origin.y,
                                   vikingBoundingBox.size.width - xCropAmount,
                                   vikingBoundingBox.size.height - yCropAmount);
    
    if (characterState == kStateCrouching) {
        // Shrink the bounding box to 56% of height
        // 88 pixels on top on iPad
        vikingBoundingBox = CGRectMake(vikingBoundingBox.origin.x,
                                       vikingBoundingBox.origin.y,
                                       vikingBoundingBox.size.width,
                                       vikingBoundingBox.size.height * 0.56f);
    }
    return vikingBoundingBox;
}

#pragma mark -
- (void)initAnimations {
    [self setBreathingAnim:[self loadPlistForAnimationWithName:
                            @"breathingAnim" andClassName:NSStringFromClass([self class])]];
    [self setBreathingMalletAnim:[self loadPlistForAnimationWithName:
                                  @"breathingMalletAnim" andClassName:NSStringFromClass([self class])]];
    [self setWalkingAnim:[self loadPlistForAnimationWithName:
                          @"walkingAnim" andClassName:NSStringFromClass([self class])]];
    [self setWalkingMalletAnim:[self loadPlistForAnimationWithName:
                                @"walkingMalletAnim" andClassName:NSStringFromClass([self class])]];
    [self setCrouchingAnim:[self loadPlistForAnimationWithName:
                            @"crouchingAnim" andClassName:NSStringFromClass([self class])]];
    [self setCrouchingMalletAnim:[self loadPlistForAnimationWithName:
                                  @"crouchingMalletAnim" andClassName:NSStringFromClass([self class])]];
    [self setStandingUpAnim:[self loadPlistForAnimationWithName:
                             @"standingUpAnim" andClassName:NSStringFromClass([self class])]];
    [self setStandingUpMalletAnim:[self loadPlistForAnimationWithName:
                                   @"standingUpMalletAnim" andClassName:NSStringFromClass([self class])]];
    [self setJumpingAnim:[self loadPlistForAnimationWithName:
                          @"jumpingAnim" andClassName:NSStringFromClass([self class])]];
    [self setJumpingMalletAnim:[self loadPlistForAnimationWithName:
                                @"jumpingMalletAnim" andClassName:NSStringFromClass([self class])]];
    [self setAfterJumpingAnim:[self loadPlistForAnimationWithName:
                               @"afterJumpingAnim" andClassName:NSStringFromClass([self class])]];
    [self setAfterJumpingMalletAnim:[self loadPlistForAnimationWithName:
                                     @"afterJumpingMalletAnim" andClassName:NSStringFromClass([self class])]];
    // Punches
    [self setRightPunchAnim:[self loadPlistForAnimationWithName:
                             @"rightPunchAnim" andClassName:NSStringFromClass([self class])]];
    [self setLeftPunchAnim:[self loadPlistForAnimationWithName:
                            @"leftPunchAnim" andClassName:NSStringFromClass([self class])]];
    [self setMalletPunchAnim:[self loadPlistForAnimationWithName:
                              @"malletPunchAnim" andClassName:NSStringFromClass([self class])]];
    // Taking Damage and Death
    [self setPhaserShockAnim:[self loadPlistForAnimationWithName:
                              @"phaserShockAnim" andClassName:NSStringFromClass([self class])]];
    [self setDeathAnim:[self loadPlistForAnimationWithName:@"vikingDeathAnim"
                                              andClassName:NSStringFromClass([self class])]];
}

#pragma mark -
-(id) init {
    if( (self=[super init]) ) {
        joystick = nil;
        jumpButton = nil;
        attackButton = nil;
        self.gameObjectType = kVikingType;
        myLastPunch = kRightHook;
        millisecondsStayingIdle = 0.0f;
        isCarryingMallet = NO;
        [self initAnimations];
    }
    return self;
}

@end
