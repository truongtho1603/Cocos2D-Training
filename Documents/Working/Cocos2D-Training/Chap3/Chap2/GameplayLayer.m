//
//  GameplayLayer.m
//  Chap2
//
//  Created by Tho Do on 8/14/13.
//
//

#import "GameplayLayer.h"

@implementation GameplayLayer

- (void)initJoystickAndButtons {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGRect joystickBaseDimensions = CGRectMake(0, 0, 128.0f, 128.0f);
    CGRect jumpButtonDimensions = CGRectMake(0, 0, 64.0f, 64.0f);
    CGRect attackButtonDimensions = CGRectMake(0, 0, 64.0f, 64.0f);
    CGPoint joystickBasePosition;
    CGPoint jumpButtonPosition;
    CGPoint attackButtonPosition;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CCLOG(@"Positioning Joystick and Buttons for iPad");
        joystickBasePosition = ccp(screenSize.width*0.0625f,
                                   screenSize.height*0.05f);
        
        jumpButtonPosition = ccp(screenSize.width*(1.0f - 0.0625f),
                                 screenSize.height*0.124f);
        
        attackButtonPosition = ccp(screenSize.width*(1.0f - 0.0625f),
                                   screenSize.height*0.05f);
    }
    else {
        CCLOG(@"Positioning Joystick and Buttons for iPhone");
        joystickBasePosition = ccp(screenSize.width*0.07f,
                                   screenSize.height*0.11f);
        
        jumpButtonPosition = ccp(screenSize.width*0.93f,
                                 screenSize.height*0.011f);
        
        attackButtonPosition = ccp(screenSize.width*0.93f,
                                   screenSize.height*0.35f);
    }
    SneakyJoystickSkinnedBase *joystickBase = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    joystickBase.position = joystickBasePosition;
    joystickBase.backgroundSprite =[CCSprite spriteWithFile:@"dpadDown.png"];
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"joystickDown.png"];
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    leftJoystick = [joystickBase.joystick retain];
    [self addChild:joystickBase];
    
    SneakyButtonSkinnedBase *jumpButtonBase = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    jumpButtonBase.position = jumpButtonPosition;
    jumpButtonBase.defaultSprite = [CCSprite spriteWithFile:@"jumpUp.png"];
    jumpButtonBase.activatedSprite = [CCSprite spriteWithFile:@"jumpDown.png"];
    jumpButtonBase.pressSprite = [CCSprite spriteWithFile:@"jumpDown.png"];
    jumpButtonBase.button = [[SneakyButton alloc] initWithRect:jumpButtonDimensions];
    jumpButton = [jumpButtonBase.button retain];
    jumpButton.isToggleable = NO;
    [self addChild:jumpButtonBase];
    
    SneakyButtonSkinnedBase *attackButtonBase = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    attackButtonBase.position = attackButtonPosition;
    attackButtonBase.defaultSprite = [CCSprite spriteWithFile:@"handUp.png"];
    attackButtonBase.activatedSprite = [CCSprite spriteWithFile:@"handDown.png"];
    attackButtonBase.pressSprite = [CCSprite spriteWithFile:@"handDown.png"];
    attackButtonBase.button = [[SneakyButton alloc] initWithRect:attackButtonDimensions];
    jumpButton = [attackButtonBase.button retain];
    jumpButton.isToggleable = NO;
    [self addChild:attackButtonBase];
}

- (void)applyJoystick:(SneakyJoystick *)aJoystick toNode:(CCNode *)tempNode forTimeDelta:(float)deltaTime {
    CGPoint scaledVelocity = ccpMult(aJoystick.velocity, 1024.0f);
    CGPoint newPosition = ccp(tempNode.position.x + scaledVelocity.x * deltaTime,
                              tempNode.position.y + scaledVelocity.y * deltaTime);
    [tempNode setPosition:newPosition];
    if (jumpButton.active == YES) {
        CCLOG(@"Jump button is pressed.");
    }
    if (attackButton.active == YES) {
        CCLOG(@"Attack button is pressed.");
    }
}

- (id)init {
    self = [super init];
    if (self != nil) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        // CGSize size = [CCDirector sharedDirector].winSize;
        self.isTouchEnabled = YES;
        /*
        vikingSprite = [CCSprite spriteWithFile:@"sv_anim_1.png"];
        [vikingSprite setPosition:CGPointMake(size.width/2,size.height*0.17f)];
        [self addChild:vikingSprite];
        [self initJoystickAndButtons];
        [self scheduleUpdate];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [vikingSprite setScaleX:size.width/1024.0f];
            [vikingSprite setScaleY:size.height/768.0f];
        }
         */
        
        
        CCSpriteBatchNode *chapetr2SpriteBatchNode;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"myTex1.plist"];
            chapetr2SpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"myTex1.png"];
        }
        else {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"myTex1iPhone.plist"];
            chapetr2SpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"myTex1iPhone.png"];
        }
        vikingSprite = [CCSprite spriteWithSpriteFrameName:@"sv_anim_1.png"];
        [vikingSprite setPosition:CGPointMake(size.width/2, size.height*0.17f)];
        [self addChild:vikingSprite];
        
        /*Chap3 added*/
        CCSprite *animatingRobot = [CCSprite spriteWithFile:@"an1_anim1.png"];
        [animatingRobot setPosition:ccp([vikingSprite position].x + 50.0f, [vikingSprite position].y)];
        [self addChild:animatingRobot];
        
        /*Chap3 using CCSpriteAnimationCache
        [[CCAnimationCache sharedAnimationCache] addAnimation:animationToCache name:@"AnimationName"];
        CCAnimation *myAnimation = [[CCAnimationCache sharedAnimationCache] animationByName:@"AnimationName"];
         */
        
        CCAnimation *robotAnim = [CCAnimation animation];
        [robotAnim addSpriteFrameWithFilename:@"an1_anim2.png"];
        [robotAnim addSpriteFrameWithFilename:@"an1_anim3.png"];
        [robotAnim addSpriteFrameWithFilename:@"an1_anim4.png"];
        
        id robotAnimationAction = [CCAnimate actionWithDuration:0.5f];
        [robotAnimationAction setAnimation:robotAnim];
        [robotAnimationAction setRestoreOriginalFrame:YES];

        id repeatRobotAnimation = [CCRepeatForever actionWithAction:robotAnimationAction];
        [animatingRobot runAction:repeatRobotAnimation];
        /**/
        
        
        
        [self initJoystickAndButtons];
        [self scheduleUpdate];
        
    }
    return self;
}

#pragma mark -
#pragma mark Update Method
- (void)update:(ccTime)deltaTime {
    [self applyJoystick:leftJoystick toNode:vikingSprite forTimeDelta:deltaTime];
}

@end
