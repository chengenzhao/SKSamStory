//
//  GameScene.swift
//  SKSam's Story
//
//  Created by Chengen Zhao on 25/05/2015.
//  Copyright (c) 2015 Monash University. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    var gameModel:GameModel!
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    var images = [String:SKSpriteNode]()
    var coordinates = [String:(CGFloat,CGFloat)]()
    var rect:SKShapeNode?
    var moveLeft = false
    var moveRight = false
    var velocity = CGFloat(0.0)
    var x:CGFloat?
    var y:CGFloat?
    var node:SKSpriteNode?
    
    func initialize(gameModel:GameModel){
        self.gameModel = gameModel
        setStage(0)
    }
    
//    var bear : SKSpriteNode!
//    var bearWalkingFrames : [SKTexture]!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 65;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
        

        x = screenSize.width/40
        y = screenSize.height*39/40
        
        createNode("btn_info_normal", x:screenSize.width/20, y:screenSize.height*19/20)
        createNode("btn_page_normal", x:screenSize.width/2, y:screenSize.height*19/20)
        createNode("btn_close", x:screenSize.width/2, y:screenSize.height*(1-0.19))
        
        createNode("btn_next_normal", x:screenSize.width*19/20, y:screenSize.height/2)
        createNode("btn_prev_normal", x:screenSize.width/20, y:screenSize.height/2)
        
        createNode("accomplish0", imageName:"accomplish1", x:screenSize.width*9.5/10, y:screenSize.height*19/20).zPosition = 0.5
        for i in 1...4{
            var x = screenSize.width*9.5/10 - images["accomplish0"]!.size.width*CGFloat(i)
            createNode("accomplish"+String(i), imageName:"accomplish1", x:x, y:screenSize.height*19/20).zPosition = 0.5
        }
        
        createNode("btn_music_normal", x:screenSize.width*10/12, y:screenSize.height*19/20)
        createNode("btn_sound_normal", x:screenSize.width*11/12, y:screenSize.height*19/20)
        
        createNode("btn_chn", x:screenSize.width*10.5/12, y:screenSize.height*8.7/10)
        createNode("btn_eng", x:screenSize.width*11.5/12, y:screenSize.height*8.7/10)
        
        for i in 0...25{
            createNode("s"+String(i))
        }
        
        createNode("bar", x:screenSize.width*2.3/6, y:screenSize.height*(1-1.7/20))
        
        var bg = SKSpriteNode(imageNamed:"0-bg")
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        bg.zPosition = -1
        bg.name = "bg"
        self.addChild(bg)
        
        self.addChild(images["btn_info_normal"]!)
        self.addChild(images["btn_page_normal"]!)
        self.addChild(images["btn_next_normal"]!)
        self.addChild(images["btn_prev_normal"]!)
        
        images["btn_info_normal"]!.zPosition = 2
        images["btn_page_normal"]!.zPosition = 2
        images["btn_next_normal"]!.zPosition = 2
        images["btn_prev_normal"]!.zPosition = 2
        
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
        
//        var w = createAndAddSKNodeWithAnchorPoint("touch", imageName:"touch1",x:100,y:100,corner:Corner.RIGHT_BOTTOM)
//        let action = SKAction.rotateByAngle(CGFloat(-M_PI), duration:2)
//        w.runAction(SKAction.repeatActionForever(action))
    }
    

    
    func createAnimationNode(name:String, texture:String, location: CGPoint) -> (SKSpriteNode, [SKTexture]){
        
        var node : SKSpriteNode!
        var textures : [SKTexture]!
        
        let animatedAtlas = SKTextureAtlas(named: name)
        var walkFrames = [SKTexture]()
        
        let numImages = animatedAtlas.textureNames.count
        for var i=1; i<=numImages/2; i++ {
            let texture = texture+"\(i)"
            walkFrames.append(animatedAtlas.textureNamed(texture))
//            print(texture)
        }
        
        textures = walkFrames
        
        let firstFrame = textures[0]
        node = SKSpriteNode(texture: firstFrame)
        node.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        node.name = name
        self.addChild(node)
        
        return (node, textures)
    }
    
    func walkingBear(node:SKSpriteNode, texture:[SKTexture]) {
        //This is our general runAction method to make our bear walk.
        node.runAction(//SKAction.repeatActionForever(
            SKAction.animateWithTextures(texture,
                timePerFrame: (1),
                resize: false,
                restore: true),//)
            withKey:"walkingInPlaceBear")
        
    }
    
    func createNode(name:String, imageName:String) -> SKSpriteNode{
        var node = SKSpriteNode(imageNamed:imageName)
        node.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        images[name] = node
        node.name = name
        return node
    }
    
    func createNode(name:String, x:CGFloat, y:CGFloat) -> SKSpriteNode{
        var node = self.createNode(name)
        node.position = CGPointMake(x,y)
        return node
    }
    
    func createSKNode(name:String, x:CGFloat, y:CGFloat) -> SKSpriteNode{
        var node = SKSpriteNode(imageNamed:name)
        node.position = CGPointMake(x,y)
        node.name = name
        return node
    }
    
    func createNode(name:String, imageName:String, x:CGFloat, y:CGFloat) -> SKSpriteNode{
        var node = self.createNode(name,imageName:imageName)
        node.position = CGPointMake(x,y)
        return node
    }
    
    func createNode(name:String) -> SKSpriteNode{
        return self.createNode(name, imageName: name)
    }
    
    func createAndAddSKNode(name: String, x:CGFloat, y:CGFloat) -> SKSpriteNode{
        var node = self.createSKNode(name, x: x, y: y)
        self.addChild(node)
        return node
    }
    
    func createAddHiddenSKNode(name: String, x:CGFloat, y:CGFloat) -> SKSpriteNode{
        var node = createAndAddSKNode(name, x: x, y: y)
        node.alpha = 0
        return node
    }
    
    func createAndAddSKNodeWithAnchorPoint(name: String, imageName:String, x:CGFloat, y:CGFloat, anchorXOffset:CGFloat, anchorYOffset:CGFloat) -> SKSpriteNode{
        var node = SKSpriteNode()
        node.name = name
        node.position = CGPointMake(x+anchorXOffset, y+anchorYOffset)
        var child = self.createNode(imageName)
        child.position = CGPointMake(-anchorXOffset, -anchorYOffset)
        node.addChild(child)
        self.addChild(node)
        return node
    }
    
    func createAndAddSKNodeWithAnchorPoint(name: String, imageName:String, x:CGFloat, y:CGFloat, corner:Corner) -> SKSpriteNode{
        var node = SKSpriteNode()
        var child = self.createNode(imageName)
        var anchorXOffset = child.size.width/2
        var anchorYOffset = child.size.height/2
        switch(corner){
        case Corner.LEFT_TOP:
            anchorXOffset = -1 * anchorXOffset
            break
        case Corner.LEFT_BOTTOM:
            anchorXOffset = -1 * anchorXOffset
            anchorYOffset = -1 * anchorYOffset
            break
        case Corner.RIGHT_BOTTOM:
            anchorYOffset = -1 * anchorYOffset
            break
        default:
            break
        }
        node.name = name
        node.position = CGPointMake(x+anchorXOffset, y+anchorYOffset)
        
        child.position = CGPointMake(-anchorXOffset, -anchorYOffset)
        node.addChild(child)
        self.addChild(node)
        return node
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if let model = gameModel{
            
        }else{
            return
        }
        
        self.moveLeft = false
        self.moveRight = false
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if(images["btn_info_normal"]!.containsPoint(location)){
                images["btn_info_normal"]!.texture = SKTexture(imageNamed:"btn_info_pressed")
            }
            
            if(images["btn_page_normal"]!.containsPoint(location)){
                images["btn_page_normal"]!.texture = SKTexture(imageNamed:"btn_page_pressed")
            }
            
            if(images["btn_next_normal"]!.containsPoint(location)){
                images["btn_next_normal"]!.texture = SKTexture(imageNamed:"btn_next_pressed")
            }
            
            if(images["btn_prev_normal"]!.containsPoint(location)){
                images["btn_prev_normal"]!.texture = SKTexture(imageNamed:"btn_prev_pressed")
            }
            
            if self.gameModel!.information == 2{
                for i in 0...MAX_SMALL_PAGES-1{
                    if images["s"+String(i)]!.containsPoint(location) {
                        self.setStage(i)
                    }
                }
            }
            
           
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let model = gameModel{
            
        }else{
            return
        }
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if let model = gameModel{
            
        }else{
            return
        }
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            if(images["btn_info_normal"]!.containsPoint(location)  && self.gameModel.information == 0){
                images["btn_info_normal"]!.texture = SKTexture(imageNamed:"btn_info_normal")
                self.gameModel.information = 1
                self.removeChildrenInArray([images["btn_info_normal"]!,images["btn_page_normal"]!, rect!])
                self.addChild(rect!)
                
                images["bar"]!.zPosition = 2
                self.addChild(images["bar"]!)
                images["btn_close"]!.zPosition = 2
                self.addChild(images["btn_close"]!)
                images["btn_music_normal"]!.zPosition = 2
                self.addChild(images["btn_music_normal"]!)
                images["btn_sound_normal"]!.zPosition = 2
                self.addChild(images["btn_sound_normal"]!)
                images["btn_chn"]!.zPosition = 2
                self.addChild(images["btn_chn"]!)
                images["btn_eng"]!.zPosition = 2
                self.addChild(images["btn_eng"]!)
            }
            
            if(images["btn_page_normal"]!.containsPoint(location)  && self.gameModel.information == 0){
                images["btn_page_normal"]!.texture = SKTexture(imageNamed:"btn_page_normal")
                self.gameModel.information = 2
                
                self.removeChildrenInArray([images["btn_info_normal"]!,images["btn_page_normal"]!, rect!])
                
                self.addChild(rect!)
                
                images["btn_close"]!.zPosition = 2
                self.addChild(images["btn_close"]!)
                for i in 0...MAX_SMALL_PAGES-1{
                    images["s"+String(i)]!.zPosition = 2
                    
                    images["s"+String(i)]!.position = CGPointMake(x! + images["s"+String(i)]!.size.width/2 + (images["s"+String(i)]!.size.width+screenSize.width/40)*CGFloat(i), y!-images["s"+String(i)]!.size.height/2)
                    self.addChild(images["s"+String(i)]!)
                }
            }
            
            if images["btn_music_normal"]!.containsPoint(location) && self.gameModel!.information == 1{
                self.gameModel.music = self.gameModel.music == 0 ? 1:0
                if self.gameModel.music == 0{
                    images["btn_music_normal"]!.texture = SKTexture(imageNamed: "btn_music_pressed")
                }else{
                    images["btn_music_normal"]!.texture = SKTexture(imageNamed: "btn_music_normal")
                }
                
                if self.gameModel!.music == 1 && !musicPlayer.playing
                    && self.stageHasMusic(self.gameModel!.getCurrentStage()){
                        musicPlayer.play()
                }
                
                if self.gameModel!.music == 0 && musicPlayer.playing{
                    musicPlayer.stop()
                }
            }
            
            if images["btn_sound_normal"]!.containsPoint(location) && self.gameModel!.information == 1{
                self.gameModel.sound = self.gameModel.sound == 0 ? 1:0
                if self.gameModel.sound == 0{
                    images["btn_sound_normal"]!.texture = SKTexture(imageNamed: "btn_sound_pressed")
                }else{
                    images["btn_sound_normal"]!.texture = SKTexture(imageNamed: "btn_sound_normal")
                }
            }
            
            if(images["btn_close"]!.containsPoint(location) && (self.gameModel!.information == 1||self.gameModel!.information == 2)){
                if(self.gameModel.information == 1){
                    self.gameModel.information = 0
                    self.removeChildrenInArray([rect!,images["bar"]!,images["btn_close"]!,images["btn_music_normal"]!,images["btn_sound_normal"]!,images["btn_chn"]!,images["btn_eng"]!])
                }
                if(self.gameModel.information == 2){
                    self.gameModel.information = 0
                    self.removeChildrenInArray([rect!,images["bar"]!,images["btn_close"]!])
                    for i in 0...MAX_SMALL_PAGES-1{
                        images["s"+String(i)]!.zPosition = 2
                        self.removeChildrenInArray([images["s"+String(i)]!])
                    }
                }
                self.addChild(images["btn_info_normal"]!)
                self.addChild(images["btn_page_normal"]!)
            }
            
            if(images["btn_next_normal"]!.containsPoint(location)){
                images["btn_next_normal"]!.texture = SKTexture(imageNamed:"btn_next_normal")
                var stage = self.gameModel.getCurrentStage()
                if stage < MAX_PAGES-1{
                    self.setStage(stage+1)
                }
            }
            
            if(images["btn_prev_normal"]!.containsPoint(location)){
                images["btn_prev_normal"]!.texture = SKTexture(imageNamed:"btn_prev_normal")
                var stage = self.gameModel.getCurrentStage()
                if stage > 0{
                    self.setStage(stage-1)
                }
            }
            
            switch(self.gameModel.getCurrentStage()){
            case 0:
                if (abs(location.x.distanceTo(CGRectGetMidX(self.frame))) < screenSize.size.width/4
                    && abs(location.y.distanceTo(CGRectGetMidY(self.frame))) < screenSize.size.height/4){
                        self.gameModel.accomplished.remove("window")
                        self.removeSKNode("touch1")
                        self.updateAccomplish()
                        
                        self.gameModel.window = self.gameModel.window == 0 ? 1 : 0
                        if self.gameModel.window==0{
                            var node = self.createSKNode("window", x:screenSize.width*756/2048, y:screenSize.height*(1536-978)/1536)
                            self.addChild(node)//images["window"]!
                        }else{
                            self.removeSKNode("window")
                        }
                        
                        if self.gameModel.sound == 1 && self.gameModel.window == 1{
                            self.playSound("window")
                        }
                }
                break
            case 1:
                self.alternateNode("cat-1", location:location, alterTexture:"cat-2")
                self.alternateNode("light1", location:location, alterTexture:"light2")
                self.alternateNode("toy", location:location, alterTexture:"toy2")

                self.wave("1-lily-r", radians: CGFloat(-M_PI*25/180), location: location)
                self.wave("1-lily-l", radians: CGFloat(M_PI*25/180), location: location)
                
                self.display("teacher",name:"note", location: location)
                break
            case 2:
//                self.wave("2-lily-1", radians: CGFloat(M_PI*25/180), location: location)
                
//                self.display("2-teacher",name:"dialog", location: location)
                
                if let node = self.childNodeWithName("dialog") as? SKSpriteNode{
                    if let touches = self.childNodeWithName("2-teacher") as? SKSpriteNode{
                        if touches.containsPoint(location){
                            node.alpha = 1
                            self.gameModel.accomplished.remove("teacher")
                            self.updateAccomplish()
                        }
                        
                    }
                    
                }
                
                if self.childNodeWithName("2-lily")!.containsPoint(location){
                    self.childNodeWithName("hello")!.alpha = 1
                    self.childNodeWithName("imlily")!.alpha = 1
                    if let node = self.childNodeWithName("2-lily-1") as? SKSpriteNode{
                        if !node.hasActions(){
                            let action0 = SKAction.rotateByAngle(CGFloat(M_PI*25/180), duration:1)
                            let action1 = SKAction.rotateByAngle(-CGFloat(M_PI*25/180), duration:1)
                            node.runAction(SKAction.sequence([action0,action1]))
                        }
                    }
                    self.gameModel.accomplished.remove("lily")
                    self.updateAccomplish()
                }
                
//                if let node = self.childNodeWithName("dialog") as? SKSpriteNode{
//                    if let touches = self.childNodeWithName("2-teacher") as? SKSpriteNode{
//                        if touches.containsPoint(location){
//                            node.alpha = 1
//                        }
//                    }
//                    self.gameModel.accomplished.remove("teacher")
//                    self.updateAccomplish()
//                }
//                self.display("2-lily",name:"hello", location: location)
//                self.display("2-lily",name:"imlily", location: location)
                
                break
            case 3:
                self.display("l1",name:"l1", location: location)
                self.display("l2",name:"l2", location: location)
                self.display("l3",name:"l3", location: location)
                self.display("l4",name:"l4", location: location)
                self.display("l5",name:"l5", location: location)
                self.display("l6",name:"l6", location: location)
                self.display("l7",name:"l7", location: location)
                if let node = self.childNodeWithName("touch1"){
                    if node.containsPoint(location){
                        self.removeSKNode("touch1")
                    }
                }
                break
            case 4:
                self.alternateNode("cat-1", location: location, alterTexture: "cat-2")
                if let node = self.childNodeWithName("4-toy_inbox"){
                    if !node.hasActions() && node.containsPoint(location){
                        let action0 = SKAction.rotateByAngle(CGFloat(M_PI*15/180), duration:1)
                        let action1 = SKAction.rotateByAngle(-CGFloat(M_PI*15/180), duration:1)
                        node.runAction(SKAction.sequence([action0,action1,action0,action1,action0,action1]))
                    }
                }
                if let node = self.childNodeWithName("4-ball"){
                    if !node.hasActions() && node.containsPoint(location){
                        let action0 = SKAction.rotateByAngle(CGFloat(2*M_PI), duration:0.5)
                        node.runAction(SKAction.sequence([action0,action0,action0]))
                    }
                }
                if let node = self.childNodeWithName("4-toy-1"){
                    if !node.hasActions() && node.containsPoint(location){
                        let action0 = SKAction.rotateByAngle(CGFloat(M_PI*15/180), duration:0.25)
                        let action1 = SKAction.rotateByAngle(-CGFloat(M_PI*15/180), duration:0.25)
                        node.runAction(SKAction.sequence([action0,action1,action0,action1,action0,action1]))
                    }
                }
                if let node = self.childNodeWithName("4-plane"){
                    if !node.hasActions() && node.containsPoint(location){
                        let action0 = SKAction.rotateByAngle(CGFloat(M_PI*15/180), duration:1)
                        let action1 = SKAction.rotateByAngle(-CGFloat(M_PI*15/180), duration:1)
                        node.runAction(SKAction.sequence([action0,action1,action0,action1,action0,action1]))
                    }
                }
                if let node = self.childNodeWithName("4-boy_arm"){
                    if !node.hasActions() && node.containsPoint(location){
                        let action0 = SKAction.rotateByAngle(CGFloat(M_PI*30/180), duration:1)
                        let action1 = SKAction.rotateByAngle(-CGFloat(M_PI*30/180), duration:1)
                        node.runAction(SKAction.sequence([action0,action1]))
                        if let n = self.childNodeWithName("4-car"){
                            let action2 = SKAction.moveByX(100,y:0, duration: 0.5)
                            self.childNodeWithName("4-car")!.runAction(SKAction.repeatActionForever(action2))
                        }
                    }
                }
                if self.childNodeWithName("4-door")!.containsPoint(location){
                    
                    self.childNodeWithName("4-door")!.alpha = self.childNodeWithName("4-door")!.alpha > 0.5 ? 0:1
                    let action0 = SKAction.rotateByAngle(-CGFloat(M_PI*30/180), duration:1)
                    let action1 = SKAction.rotateByAngle(CGFloat(M_PI*30/180), duration:1)
                    if !self.childNodeWithName("4-lily_head")!.hasActions(){
                        self.childNodeWithName("4-lily_head")!.runAction(SKAction.sequence([action0,action1]))
                    }
                    self.gameModel.accomplished.remove("door")
                    self.updateAccomplish()
                }
                break
            case 16:
                if let node = self.childNodeWithName("touch1"){
                    if node.containsPoint(location){
                        self.removeSKNode("touch1")
                    }
                }
                self.display("16_01",name:"16_01",location:location)
                self.display("16_02",name:"16_02",location:location)
                self.display("16_03",name:"16_03",location:location)
                for i in 13...21{
                    self.display("16_"+String(i),name:"16_"+String(i), location: location)
                }
                break
            default:
                break
            }
            
        }
    }
    
    func display(touch:String, name:String, location:CGPoint){
        
        if let node = self.childNodeWithName(name) as? SKSpriteNode{
            if let touches = self.childNodeWithName(touch) as? SKSpriteNode{
                if touches.containsPoint(location){
                    node.alpha = 1
                }
            }
        }
    }
    
    func wave(name:String, radians:CGFloat, duration:NSTimeInterval = 1, location: CGPoint){
        if self.childNodeWithName(name)!.containsPoint(location){
            if let node = self.childNodeWithName(name) as? SKSpriteNode{
                if !node.hasActions(){
                    let action0 = SKAction.rotateByAngle(radians, duration:duration)
                    let action1 = SKAction.rotateByAngle(-radians, duration:duration)
                    node.runAction(SKAction.sequence([action0,action1]))
                }
            }
        }
    }
    
    var dic = [String:Int]()
    
    func alternateNode(name:String, location:CGPoint, alterTexture:String){
        if self.childNodeWithName(name)!.containsPoint(location){
            dic[name] = dic[name] == nil ? 1:nil
            if dic[name] == nil{
                (self.childNodeWithName(name)! as! SKSpriteNode).texture = SKTexture(imageNamed: name)
            }else{
                (self.childNodeWithName(name)! as! SKSpriteNode).texture = SKTexture(imageNamed: alterTexture)
            }
        }
    }
    
    func alternateAlpha(name:String, alpha0:CGFloat, alpha1: CGFloat, index:Int){
        if let node = self.childNodeWithName(name) as? SKSpriteNode{
            dic[name] = dic[name] == nil ? 1: nil
            if dic[name] == nil{
                node.alpha = alpha0
            }else{
                node.alpha = alpha1
            }
        }
    }
    
    func alternateImage(name:String, image1: SKTexture, index:Int){
        if let node = self.childNodeWithName(name) as? SKSpriteNode{
            dic[name] = dic[name] == nil ? 1: nil
            if dic[name] == nil{
                node.texture = SKTexture(imageNamed:name)
            }else{
                node.texture = image1
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        gameModel!.update()
        self.gameModel.temp0 += 1
        
        switch self.gameModel.getCurrentStage(){
        case 0:
            if self.gameModel.temp0 % 13 == 0{
                self.alternateImage("touch1", image1: SKTexture(imageNamed: "touch2"), index: self.gameModel.temp0 % 26)
            }
            break
        case 1:
            if self.gameModel.temp0 % 13 == 0{
                
                self.alternateImage("shake1", image1: SKTexture(imageNamed: "shake2"), index: self.gameModel.temp0 % 26)
                
                self.alternateAlpha("fire", alpha0: 200.0/255, alpha1: 0.5, index:self.gameModel.temp0 % 26)
                
            }
            break
        case 2:
            if self.gameModel.temp0 % 13 == 0{
                
                self.alternateAlpha("2-fire", alpha0: 200.0/255, alpha1: 0.5, index:self.gameModel.temp0 % 26)
            }
            break
        case 3:
            if self.gameModel.temp0 % 13 == 0{
                self.alternateImage("touch1", image1: SKTexture(imageNamed: "touch2"), index: self.gameModel.temp0 % 26)
            }
            break
        case 4:
            if self.gameModel.temp0 % 13 == 0{
                
                self.alternateImage("shake1", image1: SKTexture(imageNamed: "shake2"), index: self.gameModel.temp0 % 26)
                
                self.alternateAlpha("fire", alpha0: 200.0/255, alpha1: 0.5, index:self.gameModel.temp0 % 26)
            }
            break
        case 16:
            if self.gameModel.temp0 % 13 == 0{
                self.alternateImage("touch1", image1: SKTexture(imageNamed: "touch2"), index: self.gameModel.temp0 % 26)
            }
            break
        case 10:
            if let node = self.childNodeWithName("swipe"){
                if self.gameModel.temp0 > 75{
                    self.gameModel.temp0 = 0
                }
                node.position.x = CGFloat(252/2+self.gameModel.temp0)
            }
            break
        case 18:
            if let node = self.childNodeWithName("swipe"){
                if self.gameModel.temp0 > 75{
                    self.gameModel.temp0 = 0
                }
                node.position.x = CGFloat(252/2+self.gameModel.temp0)
            }
            break
        default:
            break
        }
        
        if self.moveRight || self.moveLeft{
            
            var barWidth:CGFloat = (images["s0"]!.size.width + screenSize.width/40) * CGFloat(MAX_SMALL_PAGES)
            
            var x = images["s0"]!.position.x
            
            if(x + velocity <= screenSize.width - barWidth + images["s0"]!.size.width/2){
                x = screenSize.width - barWidth + images["s0"]!.size.width/2
            }else if x + velocity >= screenSize.width/40 + images["s0"]!.size.width/2{
                x = screenSize.width/40 + images["s0"]!.size.width/2
            }else{
                x = x + velocity
            }
            
            if velocity > 0{
                velocity--
            }
            
            if velocity < 0{
                velocity++
            }
            
            for i in 0...MAX_SMALL_PAGES-1{
                images["s"+String(i)]!.position = CGPointMake(x + (images["s"+String(i)]!.size.width+screenSize.width/40)*CGFloat(i), y!-images["s"+String(i)]!.size.height/2)
            }
        }
        
    }
    
    func setStage(stage:Int) -> Int{
        
        if self.stageHasMusic(stage) && self.gameModel!.music == 1{
            musicPlayer.stop()
            if stage==0 {
                musicSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music0", ofType: "mp3")!)
                musicPlayer = AVAudioPlayer(contentsOfURL: musicSound, error: nil)
            }
            
            musicPlayer.play()
        }else{
            musicPlayer.stop()
        }
        
        self.clean()
        
        var s = stage < 0 ? 0 : stage
        s = s >= MAX_PAGES ? MAX_PAGES-1 : s
        
        self.gameModel.setStage(s)
        
        switch(stage){
        case 0:
            createAndAddSKNode("window", x:screenSize.width*756/2048, y:screenSize.height*(1536-978)/1536)
            createAndAddSKNode("touch1", x:screenSize.width*905/2048, y:screenSize.height*(764/1536))
            break
        case 1:
            createAndAddSKNode("frame", x:screenSize.width*235.5/2048, y:screenSize.height*(1-467.5/1536))
            createAndAddSKNode("photo", x:screenSize.width*262/2048, y:screenSize.height*(1-469/1536))
            createAndAddSKNode("fire", x:screenSize.width*1084.5/2048, y:screenSize.height*(1-815.5/1536))
            createAndAddSKNode("light1", x:screenSize.width*163.5/2048, y:screenSize.height*(1-674.5/1536))
            createAndAddSKNode("toy", x:screenSize.width*113/2048, y:screenSize.height*(1-1256/1536))
            createAndAddSKNode("cat-1", x:screenSize.width*1658.5/2048, y:screenSize.height*(1-988.5/1536))
            createAndAddSKNode("teacher", x:screenSize.width*885/2048, y:screenSize.height*(1-915.5/1536))
            createAndAddSKNode("boy", x:screenSize.width*1187/2048, y:screenSize.height*(1-1032.5/1536))
            createAndAddSKNode("boy_arm_r", x:screenSize.width*1143.5/2048, y:screenSize.height*(1-846.5/1536))
            createAndAddSKNode("boy_arm_l", x:screenSize.width*1266/2048, y:screenSize.height*(1-847/1536))
            createAddHiddenSKNode("note", x:screenSize.width*611.5/2048, y:screenSize.height*(1-444.5/1536))
            createAndAddSKNode("lily_body", x:screenSize.width*590/2048, y:screenSize.height*(1-1032/1536))
            createAndAddSKNodeWithAnchorPoint("1-lily-r", imageName:"1-lily-r", x:screenSize.width*515/2048, y:screenSize.height*(1-928/1536), corner: Corner.RIGHT_BOTTOM)
            createAndAddSKNodeWithAnchorPoint("1-lily-l", imageName:"1-lily-l", x:screenSize.width*674/2048, y:screenSize.height*(1-1084/1536), corner: Corner.LEFT_TOP)
            createAndAddSKNode("shake1", x: screenSize.width*874/2048, y:screenSize.height*(1-269/1536))
            break
        case 2:
            createAndAddSKNode("2-fire", x:screenSize.width*1138.5/2048, y:screenSize.height*540/1536)
            createAndAddSKNode("2-lily", x:screenSize.width*431/2048, y:screenSize.height*(1-931/1536))
            createAndAddSKNodeWithAnchorPoint("2-lily-1",  imageName:"2-lily-1", x:screenSize.width*609/2048, y:screenSize.height*(1-875.5/1536), corner:Corner.LEFT_TOP).zPosition = 2
            createAndAddSKNode("2-lily-2", x:screenSize.width*274.5/2048, y:screenSize.height*(1-971.5/1536))
            createAndAddSKNode("2-teacher", x:screenSize.width*1006/2048, y:screenSize.height*(1-768/1536))
            createAndAddSKNode("2-sam", x:screenSize.width*1414.5/2048, y:screenSize.height*(1-1105/1536))
            createAddHiddenSKNode("hello", x:screenSize.width*627.5/2048, y:screenSize.height*(1-455.5/1536))
            createAddHiddenSKNode("imlily", x:screenSize.width*639/2048, y:screenSize.height*(1-773.5/1536))
            createAddHiddenSKNode("dialog", x:screenSize.width*1310/2048, y:screenSize.height*(1-279.5/1536))
            break
        case 3:
            createAndAddSKNode("3-sam", x:screenSize.width*1193.5/2048, y:screenSize.height*(1-850.5/1536))
            createAddHiddenSKNode("l1", x:screenSize.width*716.5/2048, y:screenSize.height*(1-156/1536))
            createAddHiddenSKNode("l2", x:screenSize.width*874/2048, y:screenSize.height*(1-373/1536))
            createAddHiddenSKNode("l3", x:screenSize.width*1643/2048, y:screenSize.height*(1-594.5/1536))
            createAddHiddenSKNode("l4", x:screenSize.width*628/2048, y:screenSize.height*(1-844.5/1536))
            createAddHiddenSKNode("l5", x:screenSize.width*656.5/2048, y:screenSize.height*(1-1244.5/1536))
            createAddHiddenSKNode("l6", x:screenSize.width*1581.5/2048, y:screenSize.height*(1-1392/1536))
            createAddHiddenSKNode("l7", x:screenSize.width*1396.5/2048, y:screenSize.height*(1-1048/1536))
            createAndAddSKNode("touch1", x:screenSize.width*905/2048, y:screenSize.height*(764/1536))
            break
        case 4:
            createAddHiddenSKNode("4-door", x:screenSize.width*708.5/2048, y:screenSize.height*(1-598/1536))
            createAndAddSKNode("frame", x:screenSize.width*235.5/2048, y:screenSize.height*(1-467.5/1536))
            createAndAddSKNode("shake1", x: screenSize.width*874/2048, y:screenSize.height*(1-269/1536))
            createAndAddSKNode("photo", x:screenSize.width*262/2048, y:screenSize.height*(1-469/1536))
            createAndAddSKNode("fire", x:screenSize.width*1084.5/2048, y:screenSize.height*(1-815.5/1536))
            createAndAddSKNode("cat-1", x:screenSize.width*2004.5/2048, y:screenSize.height*(1-1140/1536))
            createAndAddSKNode("4-box2", x:screenSize.width*1260.5/2048, y:screenSize.height*(1-1103.5/1536))
            createAndAddSKNode("4-toy_inbox2", x:screenSize.width*1324/2048, y:screenSize.height*(1-975.5/1536))
            createAndAddSKNode("4-ball", x:screenSize.width*1341.5/2048, y:screenSize.height*(1-1031.5/1536))
            createAndAddSKNode("4-toy_inbox", x:screenSize.width*1213/2048, y:screenSize.height*(1-1004/1536))
            createAndAddSKNode("4-car", x:screenSize.width*1002/2048, y:screenSize.height*(1-1262/1536))
            createAndAddSKNode("4-boy_body", x:screenSize.width*792.5/2048, y:screenSize.height*(1-1086/1536))
            createAndAddSKNodeWithAnchorPoint("4-boy_arm", imageName:"4-boy_arm", x:screenSize.width*921.5/2048, y:screenSize.height*(1-1199/1536), corner: Corner.LEFT_TOP)
            createAndAddSKNode("4-doll", x:screenSize.width*1429/2048, y:screenSize.height*(1-1221/1536))
            createAndAddSKNode("4-magician", x:screenSize.width*406/2048, y:screenSize.height*(1-861.5/1536))
            createAndAddSKNode("4-toy-1", x:screenSize.width*449/2048, y:screenSize.height*(1-788/1536))
            createAndAddSKNodeWithAnchorPoint("4-lily_head", imageName: "4-lily_head", x:screenSize.width*1563/2048, y:screenSize.height*(1-1071/1536), anchorXOffset:0,anchorYOffset:-121/2)
            createAndAddSKNode("4-lily_body", x:screenSize.width*1441.5/2048, y:screenSize.height*(1-1328.5/1536))
            createAndAddSKNode("4-box", x:screenSize.width*233.5/2048, y:screenSize.height*(1-1380.5/1536))
            createAndAddSKNode("4-plane", x:screenSize.width*398.5/2048, y:screenSize.height*(1-1345/1536))
            break
        case 5:
            createAndAddSKNode("5-TV", x:screenSize.width*833/2048, y:screenSize.height*(1-1153.5/1536))
            createAndAddSKNode("5-sam", x:screenSize.width*1370.5/2048, y:screenSize.height*(1-806.5/1536))
//            createAndAddSKNode("5-llily1", x:screenSize.width*581.5/2048, y:screenSize.height*(1-768/1536))
            var lily=createAnimationNode("5-lily",texture:"llily",location:CGPointMake(screenSize.width*970.5/2048, screenSize.height*(1-768/1536)))
            self.walkingBear(lily.0,texture: lily.1)
            break
        case 6:
            createAndAddSKNode("wcat1", x:screenSize.width*1792.5/2048, y:screenSize.height*(1-1147.5/1536))
            createAndAddSKNode("6-lily", x:screenSize.width*1279.5/2048, y:screenSize.height*(1-815.5/1536))
            createAndAddSKNode("6-light1", x:screenSize.width*922.5/2048, y:screenSize.height*(1-501.5/1536))
            break
        case 7:
            createAndAddSKNode("wcat1", x:screenSize.width*210.5/2048, y:screenSize.height*(1-835.5/1536))
            createAndAddSKNode("7-doll", x:screenSize.width*614/2048, y:screenSize.height*(1-777.5/1536))
            createAndAddSKNode("7-lily_leg_1", x:screenSize.width*802/2048, y:screenSize.height*(1-914/1536))
            createAndAddSKNode("7-lily_arm_2", x:screenSize.width*1000.5/2048, y:screenSize.height*(1-572/1536))
            createAndAddSKNode("7-lily_arm_1", x:screenSize.width*733.5/2048, y:screenSize.height*(1-561.5/1536))
            createAndAddSKNode("7-lily", x:screenSize.width*869/2048, y:screenSize.height*(1-474.5/1536))
            createAndAddSKNode("7-sam_leg_2", x:screenSize.width*1407/2048, y:screenSize.height*(1-1307.5/1536))
            createAndAddSKNode("7-sam", x:screenSize.width*1402.4/2048, y:screenSize.height*(1-856.5/1536))
            break
        case 8:
            createAndAddSKNode("8-tree_1", x:screenSize.width*493/2048, y:screenSize.height*(1-595/1536))
            createAndAddSKNode("8-raven_1", x:screenSize.width*1831/2048, y:screenSize.height*(1-1184/1536))
            createAndAddSKNode("8-lily", x:screenSize.width*646.5/2048, y:screenSize.height*(1-867/1536))
            createAndAddSKNode("8-lily_leg_2", x:screenSize.width*660.5/2048, y:screenSize.height*(1-1021.5/1536))
            createAndAddSKNode("8-lily_leg_1", x:screenSize.width*636/2048, y:screenSize.height*(1-1023/1536))
            createAndAddSKNode("8-mouth1", x:screenSize.width*674.5/2048, y:screenSize.height*(1-803/1536))
            createAndAddSKNode("8-sam_leg_1", x:screenSize.width*368.5/2048, y:screenSize.height*(1-1420/1536))
            createAndAddSKNode("8-sam_leg_2", x:screenSize.width*452/2048, y:screenSize.height*(1-1440/1536))
            createAndAddSKNode("8-sam_body", x:screenSize.width*451.5/2048, y:screenSize.height*(1-1175.5/1536))
            break
        case 9:
            createAndAddSKNode("9-cape1", x:screenSize.width*1343/2048, y:screenSize.height*(1-957/1536))
            createAndAddSKNode("9-body", x:screenSize.width*1272/2048, y:screenSize.height*(1-721.5/1536))
            createAndAddSKNode("9-leg1", x:screenSize.width*1378/2048, y:screenSize.height*(1-1298/1536))
            createAndAddSKNode("9-hand1", x:screenSize.width*937.5/2048, y:screenSize.height*(1-905/1536))
            createAndAddSKNode("9-mouth1", x:screenSize.width*1325/2048, y:screenSize.height*(1-542.5/1536))

            break
        case 10:
            createAndAddSKNode("10-mi", x:screenSize.width*(1564.5/2048 - 1), y:screenSize.height*(1-418.5/1536))
            createAndAddSKNode("10-do", x:screenSize.width*(3693.5/2048 - 1), y:screenSize.height*(1-573.5/1536))
            createAndAddSKNode("10-fa", x:screenSize.width*(1983.5/2048 - 1), y:screenSize.height*(1-886/1536))
            createAndAddSKNode("10-si", x:screenSize.width*(2875/2048 - 1), y:screenSize.height*(1-938.5/1536))
            createAndAddSKNode("10-re", x:screenSize.width*(2494/2048 - 1), y:screenSize.height*(1-539.5/1536))
            createAndAddSKNode("10-doo", x:screenSize.width*(2428.5/2048 - 1), y:screenSize.height*(1-920/1536))
            createAndAddSKNode("10-so", x:screenSize.width*(3509.5/2048 - 1), y:screenSize.height*(1-928/1536))
            createAndAddSKNode("10-la", x:screenSize.width*(3219.5/2048 - 1), y:screenSize.height*(1-932/1536))
            createAndAddSKNode("10-dragon1", x:screenSize.width*(1081.0/2048 - 1), y:screenSize.height*(1-1017.5/1536))
            createAndAddSKNode("10-cloud", x:screenSize.width*(1806.0/2048 - 1), y:screenSize.height*(1-673/1536))
            
            createAndAddSKNode("swipeline", x:screenSize.width*300/2048, y:screenSize.height*(1-650.0/1536))
            createAndAddSKNode("swipe", x:screenSize.width*252/2048, y:screenSize.height*(1-708.5/1536))
            
            break
        case 11:
            createAndAddSKNode("11-tree", x:screenSize.width*689.5/2048, y:screenSize.height*(1-1244/1536))
            createAndAddSKNode("11-step1", x:screenSize.width*758.5/2048, y:screenSize.height*(1-1083.5/1536))
            createAndAddSKNode("11-dragon1", x:screenSize.width*1548/2048, y:screenSize.height*(1-400/1536))
            createAndAddSKNode("11-mask", x:screenSize.width*1024/2048, y:screenSize.height*768/1536)
            break
        case 12:
            createAndAddSKNode("12-wing2", x:screenSize.width*573/2048, y:screenSize.height*(1-1045/1536))
            createAndAddSKNode("12-wing1", x:screenSize.width*1567/2048, y:screenSize.height*(1-1075/1536))
            createAndAddSKNode("12-body", x:screenSize.width*1170/2048, y:screenSize.height*(1-873/1536))
            createAndAddSKNode("12-head", x:screenSize.width*877.5/2048, y:screenSize.height*(1-315/1536))
            createAndAddSKNode("12-fire1", x:screenSize.width*446/2048, y:screenSize.height*(1-630.5/1536))
            createAndAddSKNode("12-fire2", x:screenSize.width*224/2048, y:screenSize.height*(1-873/1536))
            break
        case 13:
            createAndAddSKNode("13-sam_l", x:screenSize.width*969/2048, y:screenSize.height*(1-727/1536))
            createAndAddSKNode("13-state1", x:screenSize.width*1036/2048, y:screenSize.height*(1-764/1536))
            createAndAddSKNode("13-sam_r_1", x:screenSize.width*1298.5/2048, y:screenSize.height*(1-756.5/1536))
            createAndAddSKNode("13-sam_r_2", x:screenSize.width*1351/2048, y:screenSize.height*(1-750/1536))
            createAndAddSKNode("13-sam_r_3", x:screenSize.width*1405.5/2048, y:screenSize.height*(1-664/1536))
            createAndAddSKNode("13-tremble", x:screenSize.width*1109/2048, y:screenSize.height*(1-919.5/1536))
            break
        case 14:
            createAndAddSKNode("12-wing2", x:screenSize.width*573/2048, y:screenSize.height*(1-1045/1536))
            createAndAddSKNode("12-wing1", x:screenSize.width*1567/2048, y:screenSize.height*(1-1075/1536))
            createAndAddSKNode("14-body", x:screenSize.width*1170/2048, y:screenSize.height*(1-873/1536))
            createAndAddSKNode("12-head", x:screenSize.width*877.5/2048, y:screenSize.height*(1-315/1536))
            createAndAddSKNode("14-hand", x:screenSize.width*910/2048, y:screenSize.height*(1-1154.5/1536))
            break
        case 15:
            createAndAddSKNode("15-line", x:screenSize.width*947/2048, y:screenSize.height*(1-910.5/1536))
            createAndAddSKNode("15-characters", x:screenSize.width*992/2048, y:screenSize.height*(1-653.5/1536))
            break
        case 16:
            createAndAddSKNode("16_dia", x:screenSize.width*1034.5/2048, y:screenSize.height*(1-635.5/1536))
            createAddHiddenSKNode("16_01", x:screenSize.width*393.5/2048, y:screenSize.height*(1-160.5/1536))
            createAddHiddenSKNode("16_02", x:screenSize.width*1152.5/2048, y:screenSize.height*(1-160.5/1536))
            createAddHiddenSKNode("16_03", x:screenSize.width*1783/2048, y:screenSize.height*(1-160.5/1536))
            createAddHiddenSKNode("16_13", x:screenSize.width*218/2048, y:screenSize.height*(1-651/1536))
            createAddHiddenSKNode("16_14", x:screenSize.width*678.5/2048, y:screenSize.height*(1-694.5/1536))
            createAddHiddenSKNode("16_15", x:screenSize.width*1155.5/2048, y:screenSize.height*(1-720.5/1536))
            createAddHiddenSKNode("16_16", x:screenSize.width*1591/2048, y:screenSize.height*(1-720.5/1536))
            createAddHiddenSKNode("16_17", x:screenSize.width*1920/2048, y:screenSize.height*(1-720.5/1536))
            createAddHiddenSKNode("16_18", x:screenSize.width*218/2048, y:screenSize.height*(1-1258.5/1536))
            createAddHiddenSKNode("16_19", x:screenSize.width*678.5/2048, y:screenSize.height*(1-1302/1536))
            createAddHiddenSKNode("16_20", x:screenSize.width*1155.5/2048, y:screenSize.height*(1-1328/1536))
            createAddHiddenSKNode("16_21", x:screenSize.width*1719/2048, y:screenSize.height*(1-1328/1536))
            
            createAndAddSKNode("touch1", x:screenSize.width*905/2048, y:screenSize.height*(764/1536))
            
            break
        case 17:
            createAndAddSKNode("17-smoke", x:screenSize.width*1188/2048, y:screenSize.height*(1-520.5/1536))
            createAndAddSKNode("17-fire", x:screenSize.width*959/2048, y:screenSize.height*(1-1132/1536))
            break
        case 18:
            createAndAddSKNode("18-smoke", x:0, y:screenSize.height*(1-768/1536))
            createAndAddSKNode("18-sam", x:screenSize.width*(2969-2048)/2048, y:screenSize.height*(1-768/1536))
            createAndAddSKNode("18-lily", x:screenSize.width*(1699.5-2048)/2048, y:screenSize.height*(1-1044.5/1536))
            createAndAddSKNode("18-tear1", x:screenSize.width*(3273.5-2048)/2048, y:screenSize.height*(1-809.5/1536))
            
            createAndAddSKNode("swipeline", x:screenSize.width*300/2048, y:screenSize.height*(1-650.0/1536))
            createAndAddSKNode("swipe", x:screenSize.width*252/2048, y:screenSize.height*(1-708.5/1536))
            
            break
        case 19:
            createAndAddSKNode("19-mom1", x:screenSize.width*756/2048, y:screenSize.height*(1-710.5/1536))
            createAndAddSKNode("19-sam1", x:screenSize.width*1882/2048, y:screenSize.height*(1-1449.5/1536))
            break
        case 20:
            createAndAddSKNode("20-moutain", x:screenSize.width*1257/2048, y:screenSize.height*(1-669.5/1536))
            createAndAddSKNode("20-ground", x:screenSize.width*1024/2048, y:screenSize.height*(1-1085/1536))
            createAndAddSKNode("20-flying1", x:screenSize.width*911.5/2048, y:screenSize.height*(1-287.5/1536))
            createAndAddSKNode("20-flying2", x:screenSize.width*1470/2048, y:screenSize.height*(1-250/1536))
            createAndAddSKNode("20-rock", x:screenSize.width*1161/2048, y:screenSize.height*(1-1038/1536))
            break
        case 21:
            createAndAddSKNode("21-state1", x:screenSize.width*1030/2048, y:screenSize.height*(1-759.5/1536))
            createAndAddSKNode("21-mask", x:screenSize.width*1024/2048, y:screenSize.height*(768/1536))
            break
        case 22:
            createAndAddSKNode("20-moutain", x:screenSize.width*1257/2048, y:screenSize.height*(1-669.5/1536))
            createAndAddSKNode("20-ground", x:screenSize.width*1024/2048, y:screenSize.height*(1-1085/1536))
            createAndAddSKNode("22-mom", x:screenSize.width*550/2048, y:screenSize.height*(1-600/1536)).zPosition = 1
            createAndAddSKNode("22-sam", x:screenSize.width*1129/2048, y:screenSize.height*(1-929/1536)).zPosition = 1
            createAndAddSKNode("22-lily", x:screenSize.width*1604/2048, y:screenSize.height*(1-1012.5/1536)).zPosition = 1
            break
        case 23:
            createAndAddSKNode("20-moutain", x:screenSize.width*1257/2048, y:screenSize.height*(1-669.5/1536))
            createAndAddSKNode("20-ground", x:screenSize.width*1024/2048, y:screenSize.height*(1-1085/1536))
            createAndAddSKNode("23-state1", x:screenSize.width*1122/2048, y:screenSize.height*(1-910/1536)).zPosition = 1
            break;
        case 24:
            createAndAddSKNode("24-water1", x:screenSize.width*1460.5/2048, y:screenSize.height*(1-1034.5/1536))
            createAndAddSKNode("24-tree1", x:screenSize.width*557.5/2048, y:screenSize.height*(1-786/1536))
            break
        case 25:
            createAndAddSKNode("25-lady1", x:screenSize.width*1105/2048, y:screenSize.height*(1-508/1536))
            createAndAddSKNode("25-river", x:screenSize.width*1024/2048, y:screenSize.height*(1-933/1536))
            createAndAddSKNode("25-lady2", x:screenSize.width*562.5/2048, y:screenSize.height*(1-754.5/1536))
            
            break
        default:
            break
        }
        
        self.removeChildrenInArray([images["accomplish0"]!,images["accomplish1"]!,images["accomplish2"]!,images["accomplish3"]!,images["accomplish4"]!])
        if self.gameModel.toAccomplish > 0{
            for i in 0...self.gameModel.toAccomplish-1{
                images["accomplish"+String(i)]!.zPosition = 0.5
                self.addChild(images["accomplish"+String(i)]!)
            }
        }
        
        self.updateAccomplish()
        
        var texture:SKTexture!
        
        if s == 22 || s==23{
            texture = SKTexture(imageNamed:"20-bg")
        }else if s == 11{
            texture = SKTexture(imageNamed:"16-bg")
        }else{
            texture = SKTexture(imageNamed:String(s)+"-bg")
        }
        
        (self.childNodeWithName("bg") as! SKSpriteNode).size = texture.size()
        (self.childNodeWithName("bg") as! SKSpriteNode).texture = texture
        
        if s == 10 || s == 18{
            self.childNodeWithName("bg")!.position = CGPointMake(0,(self.childNodeWithName("bg") as! SKSpriteNode).size.height/2)
        }else{
            self.childNodeWithName("bg")!.position = CGPointMake((self.childNodeWithName("bg") as! SKSpriteNode).size.width/2,(self.childNodeWithName("bg") as! SKSpriteNode).size.height/2)
        }
        
        return s
    }
    
    func clean(){
        dic.removeAll()
        switch self.gameModel.getCurrentStage(){
        case 0:
            self.removeSKNode("window")
            self.removeSKNode("touch1")
            break
        case 1:
            self.removeSKNode("frame")
            self.removeSKNode("photo")
            self.removeSKNode("fire")
            self.removeSKNode("light1")
            self.removeSKNode("toy")
            self.removeSKNode("cat-1")
            self.removeSKNode("teacher")
            self.removeSKNode("boy")
            self.removeSKNode("boy_arm_r")
            self.removeSKNode("boy_arm_l")
            self.removeSKNode("note")
            self.removeSKNode("lily_body")
            self.removeSKNode("1-lily-r")
            self.removeSKNode("1-lily-l")
            self.removeSKNode("shake1")
            break
        case 2:
            self.removeSKNode("2-lily")
            self.removeSKNode("2-lily-1")
            self.removeSKNode("2-lily-2")
            self.removeSKNode("2-teacher")
            self.removeSKNode("2-fire")
            self.removeSKNode("2-sam")
            self.removeSKNode("imlily")
            self.removeSKNode("hello")
            self.removeSKNode("dialog")
            break
        case 3:
            self.removeSKNode("3-sam")
            for i in 1...7{
                self.removeSKNode("l"+String(i))
            }
            self.removeSKNode("touch1")
            break
        case 4:
            self.removeSKNode("4-door")
            self.removeSKNode("frame")
            self.removeSKNode("shake1")
            self.removeSKNode("photo")
            self.removeSKNode("fire")
            self.removeSKNode("cat-1")
            self.removeSKNode("4-box2")
            self.removeSKNode("4-toy_inbox2")
            self.removeSKNode("4-ball")
            self.removeSKNode("4-toy_inbox")
            self.removeSKNode("4-car")
            self.removeSKNode("4-boy_body")
            self.removeSKNode("4-boy_arm")
            self.removeSKNode("4-doll")
            self.removeSKNode("4-magician")
            self.removeSKNode("4-toy-1")
            self.removeSKNode("4-lily_head")
            self.removeSKNode("4-lily_body")
            self.removeSKNode("4-box")
            self.removeSKNode("4-plane")
            break
        case 5:
            self.removeSKNode("5-TV")
            self.removeSKNode("5-sam")
            self.removeSKNode("5-lily")
            break
        case 6:
            self.removeSKNode("wcat1")
            self.removeSKNode("6-lily")
            self.removeSKNode("6-light1")
            break
        case 7:
            self.removeSKNode("wcat1")
            self.removeSKNode("7-doll")
            self.removeSKNode("7-lily_leg_1")
            self.removeSKNode("7-lily_arm_2")
            self.removeSKNode("7-lily_arm_1")
            self.removeSKNode("7-lily")
            self.removeSKNode("7-sam_leg_2")
            self.removeSKNode("7-sam")
            break
        case 8:
            self.removeSKNode("8-tree_1")
            self.removeSKNode("8-raven_1")
            self.removeSKNode("8-lily")
            self.removeSKNode("8-lily_leg_2")
            self.removeSKNode("8-lily_leg_1")
            self.removeSKNode("8-mouth1")
            self.removeSKNode("8-sam_leg_1")
            self.removeSKNode("8-sam_leg_2")
            self.removeSKNode("8-sam_body")
            break
        case 9:
            self.removeSKNode("9-cape1")
            self.removeSKNode("9-body")
            self.removeSKNode("9-leg1")
            self.removeSKNode("9-hand1")
            self.removeSKNode("9-mouth1")
            break
        case 10:
            self.removeSKNode("10-mi")
            self.removeSKNode("10-do")
            self.removeSKNode("10-fa")
            self.removeSKNode("10-si")
            self.removeSKNode("10-re")
            self.removeSKNode("10-doo")
            self.removeSKNode("10-so")
            self.removeSKNode("10-la")
            self.removeSKNode("10-dragon1")
            self.removeSKNode("10-cloud")
            self.removeSKNode("swipeline")
            self.removeSKNode("swipe")
            break
        case 11:
            self.removeSKNode("11-step1")
            self.removeSKNode("11-dragon1")
            self.removeSKNode("11-mask")
            self.removeSKNode("11-tree")
            break
        case 12:
            self.removeSKNode("12-wing1")
            self.removeSKNode("12-wing2")
            self.removeSKNode("12-head")
            self.removeSKNode("12-body")
            self.removeSKNode("12-fire1")
            self.removeSKNode("12-fire2")
            break
        case 13:
            self.removeSKNode("13-sam_l")
            self.removeSKNode("13-state1")
            self.removeSKNode("13-sam_r_1")
            self.removeSKNode("13-sam_r_2")
            self.removeSKNode("13-sam_r_3")
            self.removeSKNode("13-tremble")
            break
        case 14:
            self.removeSKNode("12-wing2")
            self.removeSKNode("12-wing1")
            self.removeSKNode("14-body")
            self.removeSKNode("12-head")
            self.removeSKNode("14-hand")
            break
        case 15:
            self.removeSKNode("15-line")
            self.removeSKNode("15-characters")
            break
        case 16:
            self.removeSKNode("16_01")
            self.removeSKNode("16_02")
            self.removeSKNode("16_03")
            for i in 13...21{
                self.removeSKNode("16_"+String(i))
                
            }
            self.removeSKNode("16_dia")
            self.removeSKNode("touch1")
            break
        case 17:
            self.removeSKNode("17-smoke")
            self.removeSKNode("17-fire")
            break
        case 18:
            self.removeSKNode("18-smoke")
            self.removeSKNode("18-sam")
            self.removeSKNode("18-lily")
            self.removeSKNode("18-tear1")
            self.removeSKNode("swipeline")
            self.removeSKNode("swipe")
            break
        case 19:
            self.removeSKNode("19-mom1")
            self.removeSKNode("19-sam1")
            break
        case 20:
            self.removeSKNode("20-moutain")
            self.removeSKNode("20-ground")
            self.removeSKNode("20-flying1")
            self.removeSKNode("20-flying2")
            self.removeSKNode("20-rock")
            break
        case 21:
            self.removeSKNode("21-mask")
            self.removeSKNode("21-state1")
            break
        case 22:
            self.removeSKNode("20-moutain")
            self.removeSKNode("20-ground")
            self.removeSKNode("22-mom")
            self.removeSKNode("22-sam")
            self.removeSKNode("22-lily")
            break
        case 23:
            self.removeSKNode("20-moutain")
            self.removeSKNode("20-ground")
            self.removeSKNode("23-state1")
            break
        case 24:
            self.removeSKNode("24-water1")
            self.removeSKNode("24-tree1")
            break
        case 25:
            self.removeSKNode("25-lady1")
            self.removeSKNode("25-river")
            self.removeSKNode("25-lady2")
            break
        default:
            break
        }
    }
    
    func removeSKNode(name:String){
        if let node = self.childNodeWithName(name){
            self.removeChildrenInArray([node])
        }
    }
    
    func updateAccomplish(){
        if self.gameModel.toAccomplish>0{
        for i in 0...self.gameModel.toAccomplish-1{
            if i < self.gameModel.toAccomplish - self.gameModel.accomplished.count{
                images["accomplish"+String(i)]!.texture = SKTexture(imageNamed:"accomplish2")
            }else{
                images["accomplish"+String(i)]!.texture = SKTexture(imageNamed:"accomplish1")
            }
        }
        }
    }
    
    func stageHasMusic(stage:Int) -> Bool{
        if stage == 0{
            return true;
        }
        return false;
    }
    
    func stageHasSound(stage:Int) -> Bool{
        if stage == 1{
            return true;
        }
        return false;
    }

    func playSound(name:String){
        
        var sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(name, ofType: "mp3")!)
        soundPlayer = AVAudioPlayer(contentsOfURL: sound, error: nil)
        
        soundPlayer.prepareToPlay()
        soundPlayer.play()
    }
    
    func playSound(name:String, type:String){
        
        var sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(name, ofType: type)!)
        soundPlayer = AVAudioPlayer(contentsOfURL: sound, error: nil)
        
        soundPlayer.prepareToPlay()
        soundPlayer.play()
    }
    
    func shake(){
        switch(self.gameModel.getCurrentStage()){
        case 1:
            self.removeSKNode("shake1")
            self.gameModel.temp1 = 1
            break
        case 4:
            self.removeSKNode("shake1")
            self.gameModel.temp1 = 1
            break
        default:
            break
        }
    }
    func rotate(angle:Double){
        switch(self.gameModel.getCurrentStage()){
        case 1:
            if self.gameModel.temp1 == 1{
            var ta = angle
            ta = ta > M_PI / 4 ? M_PI / 4 : ta
            var lower = -M_PI / 4
            ta = ta < lower ? lower : ta
            let action = SKAction.rotateToAngle(CGFloat(ta), duration:1)
            
            if let node = self.childNodeWithName("frame") as? SKSpriteNode{
                node.removeAllActions()
                node.runAction(action)
            }
            }
            break
        case 4:
            if self.gameModel.temp1 == 1{
                var ta = angle
                ta = ta > M_PI / 4 ? M_PI / 4 : ta
                var lower = -M_PI / 4
                ta = ta < lower ? lower : ta
                let action = SKAction.rotateToAngle(CGFloat(ta), duration:1)
                
                if let node = self.childNodeWithName("frame") as? SKSpriteNode{
                    node.removeAllActions()
                    node.runAction(action)
                }
            }
            break
        default:
            break
        }
    }
    
}
