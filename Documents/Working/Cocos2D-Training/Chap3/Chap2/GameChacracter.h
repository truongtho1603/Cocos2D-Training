//
//  GameChacracter.h
//  Chap2
//
//  Created by Tho Do on 8/16/13.
//
//

#import "GameObject.h"

@interface GameChacracter : GameObject {
    int characterHealth;
    CharacterStates characterState;
}

- (void)chaeckAndClampSpritePosition;
- (int)getWeaponDamage;

@property (readwrite) int characterHealth;
@property (readwrite) CharacterStates characterState;

@end
