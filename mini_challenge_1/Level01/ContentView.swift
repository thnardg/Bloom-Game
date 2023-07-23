//
//  ContentView.swift
//  mini_challenge_1
//
//  Created by Jairo Júnior on 22/07/23.
//

import Foundation
import SpriteKit
import SwiftUI


struct ContentView: View{
    var scene = Level01Scene()
    
    var body: some View{
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView().previewInterfaceOrientation(.landscapeLeft)
    }
}


