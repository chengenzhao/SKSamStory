//
//  GameViewController.swift
//  SKSam's Story
//
//  Created by Chengen Zhao on 25/05/2015.
//  Copyright (c) 2015 Monash University. All rights reserved.
//

import UIKit
import SpriteKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameModel = GameModel()
        
        var recognizerRight = UISwipeGestureRecognizer(target: self, action:"respondToSwipeGesture:")
        recognizerRight.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(recognizerRight)
        
        var recognizerLeft = UISwipeGestureRecognizer(target: self, action:"respondToSwipeGesture:")
        recognizerLeft.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(recognizerLeft)
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
    
}
