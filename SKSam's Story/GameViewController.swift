//
//  GameViewController.swift
//  SKSam's Story
//
//  Created by Chengen Zhao on 25/05/2015.
//  Copyright (c) 2015 Monash University. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import CoreMotion

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    var gameModel:GameModel?
    var gameScene:GameScene?
    
    let motionManager:CMMotionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameModel = GameModel()
        
        var recognizerRight = UISwipeGestureRecognizer(target: self, action:"respondToSwipeGesture:")
        recognizerRight.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(recognizerRight)
        
        var recognizerLeft = UISwipeGestureRecognizer(target: self, action:"respondToSwipeGesture:")
        recognizerLeft.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(recognizerLeft)
        
        musicPlayer = AVAudioPlayer(contentsOfURL: musicSound, error: nil)
        
        musicPlayer.prepareToPlay()
        musicPlayer.numberOfLoops = -1
        musicPlayer.play()
        
        
        if  motionManager.accelerometerAvailable{
            
            if  motionManager.accelerometerActive  ==  false{
                
                motionManager.accelerometerUpdateInterval  =  40.0  /  40.0
                
                motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(),
                    withHandler:  {(data:  CMAccelerometerData!,  error:  NSError!)  in
                        
//                        println("Acceleration  x  =  \(data.acceleration.x)")
//                        println("Acceleration  y  =  \(data.acceleration.y)")
//                        println("Acceleration  z  =  \(data.acceleration.z)")
                        self.rotate(data.acceleration.x, y: data.acceleration.y)
                        
                })
                
            }  else  {
                println("Gyro  is  already  active")
            }
            
        }  else  {
            println("Gyro  isn't  available")
        }
        
//        if  motionManager.gyroAvailable{
//            
//            if  motionManager.gyroActive  ==  false{
//                
//                motionManager.gyroUpdateInterval  =  40.0*10  /  40.0
//                
//                motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue(),
//                    withHandler:  {(data:  CMGyroData!,  error:  NSError!)  in
//                        
//                        println("Gyro  Rotation  x  =  \(data.rotationRate.x)")
//                        println("Gyro  Rotation  y  =  \(data.rotationRate.y)")
//                        println("Gyro  Rotation  z  =  \(data.rotationRate.z)")
//                        
//                })
//                
//            }  else  {
//                println("Gyro  is  already  active")
//            }
//            
//        }  else  {
//            println("Gyro  isn't  available")
//        }
//
//        
//        println(motionManager.deviceMotionActive) // print false
//
//        motionManager.accelerometerData.acceleration.x
    }
    
    override func viewDidAppear(animated: Bool) {
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
            
            scene.initialize(gameModel!)
            
            self.gameScene = scene
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer){
//        println("test");
        if let scene = gameScene{
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.Right:
                scene.moveRight = true
                break
            case UISwipeGestureRecognizerDirection.Left:
                scene.moveLeft = true
                break
            default:
                break
                
            }
        }
            
        }
    }
    
    var startPoint:CGPoint!
    
    override func touchesBegan(touches: Set<NSObject>, withEvent: UIEvent){
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(gameScene)
            startPoint = location
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent: UIEvent){
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(gameScene)
            
            gameScene!.velocity = location.x - startPoint.x
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        
        if motion == .MotionShake{
            if let scene = self.gameScene{
                scene.shake()
            }
        }
    }
    
    func rotate(x:Double, y:Double){
        if let scene = self.gameScene{
            scene.rotate(atan(-y/x))
        }
    }
    
    
}
