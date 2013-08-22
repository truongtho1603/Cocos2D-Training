//
//  GameObject.h
//  Chap2
//
//  Created by Tho Do on 8/16/13.
//
//

#import "CCSprite.h"
#import "cocos2d.h"
#import "Constaints.h"
#import "CommonProtocols.h"

@interface GameObject : CCSprite {
    BOOL isActive;
    BOOL reactsToScreenBoundaries;
    CGSize screenSize;
    GameObjectType gameObjectType;
}

@property (readwrite) BOOL isActive;
@property (readwrite) BOOL reactsToScreenBoundaries;
@property (readwrite) CGSize screenSize;
@property (readwrite) GameObjectType gameObjectType;

- (void)changeState:(CharacterStates)newState;
- (void)updateStateWithDeltaTime:(ccTime)deltaTime
            andListOfGameObjects:(CCArray *)listOfGameObjects;
- (CGRect)adjustedBoundingBox;
- (CCAnimation *)loadPlistForAnimationWithName:(NSString *)animationName
                                  andClassName:(NSString *)className;

@end
