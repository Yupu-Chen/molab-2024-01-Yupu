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
    
    init(){
        
    }
    
    
    func AddNewImage(name: String) -> AnchorEntity? {
        var anchor: AnchorEntity?
        if let texture = self.texture {
            self.material.color = .init(tint: .white, texture: .init(texture))
            anchor = AnchorEntity(.plane(.vertical, classification: .any, minimumBounds: .zero))
            if let image = UIImage(named: name) {
                let entity: ModelEntity = ModelEntity(mesh: .generateBox(width: Float(image.size.width)/2200, height: 0.05, depth: Float(image.size.height)/2200), materials: [material])
                anchor?.addChild(entity)
            }
        }
        return(anchor)
    }
}
