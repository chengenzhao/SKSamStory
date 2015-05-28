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
    var stageNodes = [SKNode]()
    
    func initialize(gameModel:GameModel){
        self.gameModel = gameModel
        setStage(0)
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
        y = screenSize.height*39/40
        
        createNode("btn_info_normal", x:screenSize.width/20, y:screenSize.height*19/20)
        createNode("btn_page_normal", x:screenSize.width/2, y:screenSize.height*19/20)
        createNode("btn_close", x:screenSize.width/2, y:screenSize.height*(1-0.19))
        
        createNode("btn_next_normal", x:screenSize.width*9/10, y:screenSize.height/2)
        createNode("btn_prev_normal", x:screenSize.width/10, y:screenSize.height/2)
        
        createNode("accomplish0", imageName:"accomplish1", x:screenSize.width*9.5/10, y:screenSize.height*19/20)
        for i in 1...4{
            var x = screenSize.width*9.5/10 - images["accomplish0"]!.size.width*CGFloat(i)
            createNode("accomplish"+String(i), imageName:"accomplish1", x:x, y:screenSize.height*19/20)
        }
        
        //0
//        createNode("window", x:screenSize.width*756/2048, y:screenSize.height*(1536-978)/1536)
//        //1
//        createNode("frame", x:screenSize.width*235.5/2048, y:screenSize.height*467.5/1536)
//        createNode("photo", x:screenSize.width*262/2048, y:screenSize.height*469/1536)
//        createNode("fire", x:screenSize.width*1084.5/2048, y:screenSize.height*815.5/1536)
//        createNode("light", x:screenSize.width*163.5/2048, y:screenSize.height*674.5/1536)
//        createNode("toy", x:screenSize.width*113/2048, y:screenSize.height*1256/1536)
//        createNode("cat1", x:screenSize.width*1658.5/2048, y:screenSize.height*988.5/1536)
//        createNode("cat2", x:screenSize.width*1658.5/2048, y:screenSize.height*988.5/1536)
//        createNode("teacher", x:screenSize.width*885/2048, y:screenSize.height*915.5/1536)
//        createNode("boy", x:screenSize.width*1187/2048, y:screenSize.height*1032.5/1536)
//        createNode("boy_arm_r", x:screenSize.width*1143.5/2048, y:screenSize.height*846.5/1536)
//        createNode("boy_arm_l", x:screenSize.width*1266/2048, y:screenSize.height*847/1536)
//        createNode("note", x:screenSize.width*611.5/2048, y:screenSize.height*444.5/1536)
//        createNode("1-lily", x:screenSize.width*590/2048, y:screenSize.height*1032/1536)
//        createNode("1-lily-r", x:screenSize.width*515/2048, y:screenSize.height*928/1536)
//        createNode("1-lily-l", x:screenSize.width*674/2048, y:screenSize.height*1084/1536)
//        //2
//        createNode("2-lily", x:screenSize.width*431/2048, y:screenSize.height*931/1536)
//        createNode("2-lily-1", x:screenSize.width*609/2048, y:screenSize.height*875.5/1536)
//        createNode("2-lily-2", x:screenSize.width*274.5/2048, y:screenSize.height*971.5/1536)
//        createNode("2-teacher", x:screenSize.width*1006/2048, y:screenSize.height*768/1536)
//        createNode("2-fire", x:screenSize.width*1138.5/2048, y:screenSize.height*996/1536)
//        createNode("2-sam", x:screenSize.width*1414.5/2048, y:screenSize.height*1105/1536)
        
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
    
    func createNode(name:String, imageName:String, x:CGFloat, y:CGFloat){
        var node = self.createNode(name,imageName:imageName)
        node.position = CGPointMake(x,y)
    }
    
    func createNode(name:String) -> SKSpriteNode{
        return self.createNode(name, imageName: name)
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
                self.setStage(stage+1)
            }
            
            if(images["btn_prev_normal"]!.containsPoint(location)){
                images["btn_prev_normal"]!.texture = SKTexture(imageNamed:"btn_prev_normal")
                var stage = self.gameModel.getCurrentStage()
                self.setStage(stage-1)
            }
            
            switch(self.gameModel.getCurrentStage()){
            case 0:
                if (abs(location.x.distanceTo(CGRectGetMidX(self.frame))) < screenSize.size.width/4
                    && abs(location.y.distanceTo(CGRectGetMidY(self.frame))) < screenSize.size.height/4){
                        self.gameModel.accomplished.remove("window")
                        self.updateAccomplish()
                        
                        self.gameModel.window = self.gameModel.window == 0 ? 1 : 0
                        if self.gameModel.window==0{
                            var node = self.createSKNode("window", x:screenSize.width*756/2048, y:screenSize.height*(1536-978)/1536)
                            self.addChild(node)//images["window"]!
                            stageNodes.append(node)
                        }else{
                            self.removeChildrenInArray([self.childNodeWithName("window")!])
                        }
                        
                        if self.gameModel.sound == 1 && self.gameModel.window == 1{
                            self.playSound("window")
                        }
                }
                break
            default:
                break
            }
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        gameModel!.update()
        
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
            var node = createSKNode("window", x:screenSize.width*756/2048, y:screenSize.height*(1536-978)/1536)
            self.addChild(node)
            self.stageNodes.append(node)
            self.gameModel.window = 0
            break
//        case 1:
//            createNode("frame", x:screenSize.width*235.5/2048, y:screenSize.height*467.5/1536)
//            createNode("photo", x:screenSize.width*262/2048, y:screenSize.height*469/1536)
//            createNode("fire", x:screenSize.width*1084.5/2048, y:screenSize.height*815.5/1536)
//            createNode("light", x:screenSize.width*163.5/2048, y:screenSize.height*674.5/1536)
//            createNode("toy", x:screenSize.width*113/2048, y:screenSize.height*1256/1536)
//            createNode("cat1", x:screenSize.width*1658.5/2048, y:screenSize.height*988.5/1536)
//            createNode("cat2", x:screenSize.width*1658.5/2048, y:screenSize.height*988.5/1536)
//            createNode("teacher", x:screenSize.width*885/2048, y:screenSize.height*915.5/1536)
//            createNode("boy", x:screenSize.width*1187/2048, y:screenSize.height*1032.5/1536)
//            createNode("boy_arm_r", x:screenSize.width*1143.5/2048, y:screenSize.height*846.5/1536)
//            createNode("boy_arm_l", x:screenSize.width*1266/2048, y:screenSize.height*847/1536)
//            createNode("note", x:screenSize.width*611.5/2048, y:screenSize.height*444.5/1536)
//            createNode("1-lily", x:screenSize.width*590/2048, y:screenSize.height*1032/1536)
//            createNode("1-lily-r", x:screenSize.width*515/2048, y:screenSize.height*928/1536)
//            createNode("1-lily-l", x:screenSize.width*674/2048, y:screenSize.height*1084/1536)
//            break
//        case 2:
//            createNode("2-lily", x:screenSize.width*431/2048, y:screenSize.height*931/1536)
//            createNode("2-lily-1", x:screenSize.width*609/2048, y:screenSize.height*875.5/1536)
//            createNode("2-lily-2", x:screenSize.width*274.5/2048, y:screenSize.height*971.5/1536)
//            createNode("2-teacher", x:screenSize.width*1006/2048, y:screenSize.height*768/1536)
//            createNode("2-fire", x:screenSize.width*1138.5/2048, y:screenSize.height*996/1536)
//            createNode("2-sam", x:screenSize.width*1414.5/2048, y:screenSize.height*1105/1536)
//            break
        default:
            break
        }
        
        self.removeChildrenInArray([images["accomplish0"]!,images["accomplish1"]!,images["accomplish2"]!,images["accomplish3"]!,images["accomplish4"]!])
        
        for i in 0...self.gameModel.toAccomplish-1{
            self.addChild(images["accomplish"+String(i)]!)
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
        self.removeChildrenInArray(self.stageNodes)
        self.stageNodes.removeAll()
//        switch self.gameModel.getCurrentStage(){
//        case 0:
//            self.gameModel.window = 0
//            break
//        default:
//            break
//        }
    }
    
    func updateAccomplish(){
        for i in 0...self.gameModel.toAccomplish-1{
            if i < self.gameModel.toAccomplish - self.gameModel.accomplished.count{
                images["accomplish"+String(i)]!.texture = SKTexture(imageNamed:"accomplish2")
            }else{
                images["accomplish"+String(i)]!.texture = SKTexture(imageNamed:"accomplish1")
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
    
}
