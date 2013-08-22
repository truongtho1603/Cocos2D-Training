//
//  RadarDisk.h
//  Chap2
//
//  Created by Tho Do on 8/19/13.
//
//

#import "GameChacracter.h"

@interface RadarDisk : GameChacracter {
    CCAnimation *tiltingAnim;
    CCAnimation *transmittingAnim;
    CCAnimation *takingAHitAnim;
    CCAnimation *blowingUpAnim;
    GameChacracter *vikingCharacter;
}

@property (nonatomic, retain) CCAnimation *tiltingAnim;
@property (nonatomic, retain) CCAnimation *trasmittingAnim;
@property (nonatomic, retain) CCAnimation *takingAHitAnim;
@property (nonatomic, retain) CCAnimation *blowingUpAnim;

@end
