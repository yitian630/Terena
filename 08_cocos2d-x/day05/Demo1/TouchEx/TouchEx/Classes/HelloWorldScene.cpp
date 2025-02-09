#include "HelloWorldScene.h"
#include "SimpleAudioEngine.h"
#include "TargetedTouch.h"
#include "StandardTouch.h"
using namespace cocos2d;
using namespace CocosDenshion;

CCScene* HelloWorld::scene()
{
    // 'scene' is an autorelease object
    CCScene *scene = CCScene::create();
    
    // 'layer' is an autorelease object
    HelloWorld *layer = HelloWorld::create();

    // add layer as a child to scene
    scene->addChild(layer);

    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
bool HelloWorld::init()
{
    //////////////////////////////
    // 1. super init first
    if ( !CCLayer::init() )
    {
        return false;
    }
    
    TargetedTouch *touch = TargetedTouch::create();
    this->addChild(touch, 0 , 1);

    
    StandardTouch *stouch = StandardTouch::create();
    this->addChild(stouch);
    
    this->scheduleUpdate();
    return true;
}

void HelloWorld::update(float time) {
    CCNode *touch = this->getChildByTag(1);
    if (touch) {
//        this->removeChild(touch);
    }
}

void HelloWorld::menuCloseCallback(CCObject* pSender)
{
    CCDirector::sharedDirector()->end();

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    exit(0);
#endif
}
