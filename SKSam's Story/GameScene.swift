//
//  GameScene.swift
//  SKSam's Story
//
//  Created by Chengen Zhao on 25/05/2015.
//  Copyright (c) 2015 Monash University. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var gameModel:GameModel!
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    var images = [String:SKSpriteNode]()
    var coordinates = [String:(CGFloat,CGFloat)]()
    var rect:SKShapeNode?
    
    var x:CGFloat?
    var y:CGFloat?
    
    func initialize(gameModel:GameModel){
        self.gameModel = gameModel
        
    }
    
    var bear : SKSpriteNode!
    var bearWalkingFrames : [SKTexture]!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 65;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
        x = screenSize.width/40
        y = screenSize.height/40
        
        createNode("btn_info_normal", x:screenSize.width/20, y:screenSize.height*19/20)
        createNode("btn_page_normal", x:screenSize.width/2, y:screenSize.height*19/20)
        createNode("btn_close", x:screenSize.width/2, y:screenSize.height*(1-0.19))
        
        createNode("btn_next_normal", x:screenSize.width*9/10, y:screenSize.height/2)
        createNode("btn_next_pressed", x:screenSize.width*9/10, y:screenSize.height/2)
        createNode("btn_prev_normal", x:screenSize.width/10, y:screenSize.height/2)
        createNode("btn_prev_pressed", x:screenSize.width/10, y:screenSize.height/2)
        
        createNode("accomplish1", x:screenSize.width*9/10, y:screenSize.height/20)
        createNode("accomplish2", x:screenSize.width*9/10, y:screenSize.height/20)
        //0
        createNode("window", x:screenSize.width*756/2048, y:screenSize.height*978/1536)
        //1
        createNode("frame", x:screenSize.width*235.5/2048, y:screenSize.height*467.5/1536)
        createNode("photo", x:screenSize.width*262/2048, y:screenSize.height*469/1536)
        createNode("fire", x:screenSize.width*1084.5/2048, y:screenSize.height*815.5/1536)
        createNode("light", x:screenSize.width*163.5/2048, y:screenSize.height*674.5/1536)
        createNode("toy", x:screenSize.width*113/2048, y:screenSize.height*1256/1536)
        createNode("cat1", x:screenSize.width*1658.5/2048, y:screenSize.height*988.5/1536)
        createNode("cat2", x:screenSize.width*1658.5/2048, y:screenSize.height*988.5/1536)
        createNode("teacher", x:screenSize.width*885/2048, y:screenSize.height*915.5/1536)
        createNode("boy", x:screenSize.width*1187/2048, y:screenSize.height*1032.5/1536)
        createNode("boy_arm_r", x:screenSize.width*1143.5/2048, y:screenSize.height*846.5/1536)
        createNode("boy_arm_l", x:screenSize.width*1266/2048, y:screenSize.height*847/1536)
        createNode("note", x:screenSize.width*611.5/2048, y:screenSize.height*444.5/1536)
        createNode("1-lily", x:screenSize.width*590/2048, y:screenSize.height*1032/1536)
        createNode("1-lily-r", x:screenSize.width*515/2048, y:screenSize.height*928/1536)
        createNode("1-lily-l", x:screenSize.width*674/2048, y:screenSize.height*1084/1536)
        //2
        createNode("2-lily", x:screenSize.width*431/2048, y:screenSize.height*931/1536)
        createNode("2-lily-1", x:screenSize.width*609/2048, y:screenSize.height*875.5/1536)
        createNode("2-lily-2", x:screenSize.width*274.5/2048, y:screenSize.height*971.5/1536)
        createNode("2-teacher", x:screenSize.width*1006/2048, y:screenSize.height*768/1536)
        createNode("2-fire", x:screenSize.width*1138.5/2048, y:screenSize.height*996/1536)
        createNode("2-sam", x:screenSize.width*1414.5/2048, y:screenSize.height*1105/1536)
        
        createNode("btn_music", x:screenSize.width*10/12, y:screenSize.height*19/20)
        createNode("btn_music_off", x:screenSize.width*10/12, y:screenSize.height/20)
        createNode("btn_sound", x:screenSize.width*11/12, y:screenSize.height*19/20)
        createNode("btn_sound_off", x:screenSize.width*11/12, y:screenSize.height/20)
        
        createNode("btn_chn", x:screenSize.width*10.5/12, y:screenSize.height*8.7/10)
        createNode("btn_eng", x:screenSize.width*11.5/12, y:screenSize.height*8.7/10)
        
        createNode("s0")
        createNode("s1")
        createNode("s2")
        createNode("s3")
        createNode("s4")
        createNode("s5")
        createNode("s6")
        
        createNode("0-bg")
        createNode("1-bg")
        createNode("2-bg")
        
        createNode("bar", x:screenSize.width*2.3/6, y:screenSize.height*(1-1.7/20))
        
        self.addChild(images["0-bg"]!)
        self.addChild(images["btn_info_normal"]!)
        self.addChild(images["btn_page_normal"]!)
        
        rect = SKShapeNode(rect:CGRectMake(0, 0, screenSize.width, screenSize.height*0.175))
        rect!.fillColor = UIColor(red: 197/255.0, green: 61/255.0, blue: 25/255.0, alpha: 1.0)
        rect!.strokeColor = rect!.fillColor
        rect!.position = CGPointMake(0, screenSize.height*(1-0.175))
        rect!.zPosition = 1
        
//        let bearAnimatedAtlas = SKTextureAtlas(named: "BearImages")
//        var walkFrames = [SKTexture]()
//        
//        let numImages = bearAnimatedAtlas.textureNames.count
//        for var i=1; i<=numImages/2; i++ {
//            let bearTextureName = "bear\(i)"
//            walkFrames.append(bearAnimatedAtlas.textureNamed(bearTextureName))
//        }
//        
//        bearWalkingFrames = walkFrames
//        
//        let firstFrame = bearWalkingFrames[0]
//        bear = SKSpriteNode(texture: firstFrame)
//        bear.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
//        addChild(bear)
//        
//        walkingBear() 
    }
    
    func walkingBear() {
        //This is our general runAction method to make our bear walk.
        bear.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(bearWalkingFrames,
                timePerFrame: (0.1),
                resize: false,
                restore: true)),
            withKey:"walkingInPlaceBear")
        
        
    }
    
//    func createNode(name:String, x:CGFloat, y:CGFloat){
//        coordinates[name] = (x,y)
//        self.createNode(name)
//    }
    
    func createNode(name:String, x:CGFloat, y:CGFloat){
        var node = self.createNode(name)
        node.position = CGPointMake(x,y)
    }
    
    func createNode(name:String) -> SKSpriteNode{
        var node = SKSpriteNode(imageNamed:name)
        node.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        images[name] = node
        return node
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if(images["btn_info_normal"]!.containsPoint(location)){
                images["btn_info_normal"]!.texture = SKTexture(imageNamed:"btn_info_pressed")
               
            }
            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if(images["btn_info_normal"]!.containsPoint(location)  && self.gameModel.information == 0){
                images["btn_info_normal"]!.texture = SKTexture(imageNamed:"btn_info_normal")
                self.gameModel.information = 1
                self.removeChildrenInArray([images["btn_info_normal"]!])
                self.addChild(rect!)
                
                images["bar"]!.zPosition = 2
                self.addChild(images["bar"]!)
                images["btn_close"]!.zPosition = 2
                self.addChild(images["btn_close"]!)
                images["btn_music"]!.zPosition = 2
                self.addChild(images["btn_music"]!)
                images["btn_sound"]!.zPosition = 2
                self.addChild(images["btn_sound"]!)
                images["btn_chn"]!.zPosition = 2
                self.addChild(images["btn_chn"]!)
                images["btn_eng"]!.zPosition = 2
                self.addChild(images["btn_eng"]!)
            }
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        gameModel!.update()
    }
}
