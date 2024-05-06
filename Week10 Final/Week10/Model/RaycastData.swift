//
//  RaycastData.swift
//  Week10
//
//  Created by Yupu Chan on 22/4/2024.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit


//this is for controlling raycasting and creating anchor at the specific place
class RaycastData: ObservableObject {
    
    var results: [ARRaycastResult]?

    var arViewGlobal: ARView?

    var anchor: AnchorEntity?
    
    init() {
        
    }
    
}
