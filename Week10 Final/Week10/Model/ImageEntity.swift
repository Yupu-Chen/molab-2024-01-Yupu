//
//  ImageEntity.swift
//  Week08
//
//  Created by Yupu Chan on 28/3/2024.
//

import Foundation
import SwiftUI
import RealityKit

class ImageEntity: ObservableObject {
    // Temp fix for error: Modifying state during view update, this will cause undefined behavior.
    // Convert these to model class and pass into ARViewContainer

    @Published var texture: TextureResource?
    
    @Published var imageName: String = ""
    
    var material: SimpleMaterial = SimpleMaterial(color: .white, isMetallic: false)
    
    var imageCount: Int = 0;
    
    var entity: ModelEntity?
    
    init(){

    }
    
    
    func AddNewImage(name: String) -> Entity? {
        if let texture = self.texture {
            self.material.color = .init(tint: .white, texture: .init(texture))
            //anchor = AnchorEntity(.plane(.vertical, classification: .any, minimumBounds: .zero))
            if let image = UIImage(named: name) {
                self.entity = ModelEntity(mesh: .generateBox(width: Float(image.size.width)/2200, height: 0.05, depth: Float(image.size.height)/2200), materials: [material])
                self.entity?.generateCollisionShapes(recursive: true)

                //anchor?.addChild(entity)
            }
        }
        return(self.entity)
    }
}
