//
//  HelloWorldLayer.m
//  Chap1
//
//  Created by Tho Do on 8/14/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

@implementation HelloWorldLayer

+ (CCScene *)scene {
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	return scene;
}

- (id)init {
    self = [super init];
	if (self != nil) {
        CCSprite *spaceCargoShip = [CCSprite spriteWithFile:@"SpaceCargoShip.png"];
        CGSize size = [[CCDirector sharedDirector] winSize];
        [spaceCargoShip setPosition:CGPointMake(size.width,size.height/2)];
        id moveAction = [CCMoveTo actionWithDuration:5.0f position:CGPointMake(0, size.height/2)];
        [spaceCargoShip runAction:moveAction];
		[self addChild:spaceCargoShip];
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
}

@end
