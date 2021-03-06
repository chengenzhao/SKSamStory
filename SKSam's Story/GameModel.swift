//
//  GameModel.swift
//  SKSam's Story
//
//  Created by Chengen Zhao on 25/05/2015.
//  Copyright (c) 2015 Monash University. All rights reserved.
//

import Foundation
import UIKit

class GameModel{
    private var currentStage:Int?
    
    var information:Int = 0
//    var page:Int = 0
    var next:Int = 0
    var prev:Int = 0
    
    var music:Int = 1
    var sound:Int = 1
    
    var toAccomplish = 1
    var accomplished = Set<String>()
    
    var window:Int = 0
    var tempM1:Int = 0
    var temp0:Int = 0
    var temp1:CGFloat = CGFloat(0)
    var temp2:Int = 0
    var temp3:Int = 0
    var temp4:Int = 0
    
    func update(){
        
    }
    
    func getCurrentStage() -> Int{
        if let c = currentStage{
            return c
        }else{
            self.setStage(0)
            return Int(0)
        }
    }
    
    func setStage(stage:Int){
        currentStage = stage
        window = 0
        tempM1 = 0
        temp0 = 0
        temp1 = CGFloat(0)
        temp2 = 0
        temp3 = 0
        temp4 = 0
        accomplished.removeAll()
        switch(stage){
        case 0:
            toAccomplish=1
            accomplished.insert("window")
            break
        case 1:
            toAccomplish=3
            accomplished.insert("lily")
            accomplished.insert("note")
            accomplished.insert("boy")
            break
        case 2:
            toAccomplish=2
            accomplished.insert("lily")
            accomplished.insert("teacher")
            break
        case 4:
            toAccomplish=3
            accomplished.insert("door")
            accomplished.insert("shake")
            accomplished.insert("boy")
            break
        case 5:
            toAccomplish=1
            accomplished.insert("door")
            break
        case 6:
            toAccomplish=1
            accomplished.insert("lily")
            break
        case 7:
            toAccomplish=1
            accomplished.insert("lily")
            break
        case 8:
            toAccomplish=2
            accomplished.insert("lily")
            accomplished.insert("raven")
            break
        case 9:
            toAccomplish=1
            accomplished.insert("lily")
            break
        case 10:
            toAccomplish=2
            accomplished.insert("swipe")
            accomplished.insert("tree")
            break
        case 12:
            toAccomplish=1
            accomplished.insert("dragon")
            break
        case 14:
            toAccomplish=1
            accomplished.insert("dragon")
            break
        case 15:
            toAccomplish=1
            accomplished.insert("drop")
            break
        case 16:
            toAccomplish=1
            accomplished.insert("touch")
            break
        case 18:
            toAccomplish=2
            accomplished.insert("swipe")
            accomplished.insert("tear")
            break
        case 19:
            toAccomplish=1
            accomplished.insert("reunion")
            break
        case 20:
            toAccomplish=1
            accomplished.insert("stone")
            break
        case 21:
            toAccomplish=3
            accomplished.insert("1")
            accomplished.insert("2")
            accomplished.insert("3")
            break
        case 23:
            toAccomplish=3
            accomplished.insert("1")
            accomplished.insert("2")
            accomplished.insert("3")
            break
        case 24:
            toAccomplish=5
            accomplished.insert("1")
            accomplished.insert("2")
            accomplished.insert("3")
            accomplished.insert("4")
            accomplished.insert("5")
            break
        case 25:
            toAccomplish=1
            accomplished.insert("boat")
            break
        case 26:
            toAccomplish=1
            accomplished.insert("end")
            break
        default:
            toAccomplish=0
            break
        }
    }
    
    func removeAccomplished(name:String){
        accomplished.remove(name)
    }
}