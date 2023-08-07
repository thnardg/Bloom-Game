//
//  Controller.swift
//  Bloom
//
//  Created by Enrique Carvalho on 31/07/23.
//

import Foundation
import GameController

var controllerInstance = Controller() // a global controller variable

class Controller{ // class used for defining a physical controller
    var physController: GCController = GCController() // defining a physical controller
    
    func updateController(){ // needs to be called in any gamescene update func
        if GCController.controllers().isEmpty == false && GCController.controllers()[0].extendedGamepad != nil{ // if any controller is detected and is recognized as an extended gamepad
        if physController.extendedGamepad == nil{ // if its extended gamepad properties aren't set yet
            if GCController.controllers()[0].productCategory == "Touch Controller"{ // ignoring the touch controllers of the game
                if GCController.controllers().count > 1{
                    physController = GCController.controllers()[1]
                }
            } else {
                physController = GCController.controllers()[0]
            }
        }
        }else{
            physController = GCController()
        }
        }
    
    
}
