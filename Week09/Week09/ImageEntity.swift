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
    var material: SimpleMaterial = SimpleMaterial(color: .white, isMetallic: true)
    
    var imageCount: Int = 0;
    
    init(){
        
    }
    
    func AddNewImage() -> AnchorEntity? {
        var anchor: AnchorEntity?
        if let texture = self.texture {
            self.material.color = .init(tint: .white, texture: .init(texture))
            anchor = AnchorEntity(.plane(.any, classification: .any, minimumBounds: .zero))
            let entity: ModelEntity = ModelEntity(mesh: .generateBox(size: 0.5), materials: [material])
            anchor?.addChild(entity)
        }
        return(anchor)
    }
}
