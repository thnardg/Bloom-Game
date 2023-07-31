//
//  Controller.swift
//  Bloom
//
//  Created by Enrique Carvalho on 31/07/23.
//

import Foundation
import GameController

var controllerInstance = Controller()

class Controller{
    var physController: GCController = GCController()
    
    func updateController(){
        if GCController.controllers().isEmpty == false && GCController.controllers()[0].extendedGamepad != nil{
        if physController.extendedGamepad == nil{
            if GCController.controllers()[0].productCategory == "Touch Controller"{
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
