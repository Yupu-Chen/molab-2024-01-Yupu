import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    
    var location: CGPoint?
    
    @EnvironmentObject var imageEntity: ImageEntity
    
    var ARImage: ImageEntity = ImageEntity()
    
    @ObservedObject var raycastData = RaycastData()
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
    
        // Start AR session
        let session = arView.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.vertical, .horizontal]
        config.environmentTexturing = .automatic
        
        // toggle occulusion
        
        //1. check if supported by devcie
        guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) else {
            fatalError("People occlusion is not supported on this device.")
        }
        
        //2. add to the config
        config.frameSemantics.insert(.personSegmentationWithDepth)
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
            config.sceneReconstruction = .meshWithClassification
        } // check if the device supports LiDR for higher precision and accuracy
        
        arView.environment.sceneUnderstanding.options.insert(.occlusion)
        
        session.run(config)
        
        // Add coaching overlay
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .anyPlane
        coachingOverlay.activatesAutomatically = true
        arView.addSubview(coachingOverlay)
        
        // Set debug options
#if DEBUG
        arView.debugOptions = [.showFeaturePoints, .showWorldOrigin, .showSceneUnderstanding]
#endif
        self.raycastData.arViewGlobal = arView
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if let filePath = Bundle.main.url(forResource: imageEntity.imageName, withExtension:".jpg", subdirectory:"Content"){
            Swift.print("updateUIView imageName =", imageEntity.imageName)
            //print("updateUIView data =", data)
            //try? data.write(to: filePath)
            DispatchQueue.main.async {
                let texture = try? TextureResource.load(contentsOf: filePath)
                print("updateUIView self.texture=", texture ?? "-none-")
                if let texture = texture {
                    ARImage.texture = texture
                    if let anchor = self.raycastData.anchor {
                        print("Setting Anchor")
                        if let entity = ARImage.AddNewImage(name: imageEntity.imageName){
                            uiView.installGestures([.scale, .translation], for: entity as! HasCollision)
                            anchor.addChild(entity)
                            uiView.scene.addAnchor(anchor)
                        }
                    }
                    print("updateUIView let texture", texture)
                }
            }
        }
        print("updateUIView updated selectedImage", ARImage.imageName)
    }
    
    // this is used to save the first raycast result as the anchor entity
    func setAnchor(_ uiView: ARView) {
        print("DEBUG: SetAnchor: ", self.raycastData.results)
        if let location = self.location{
            print("Raycast successful")
            self.raycastData.results = uiView.raycast(from: location, allowing: .estimatedPlane, alignment: .vertical)
        }
        if let firstResult = self.raycastData.results?.first {
            print("PLANE HIT")
            let worldPos = firstResult.worldTransform
            self.raycastData.anchor = AnchorEntity(world: worldPos)
        } else {
            self.raycastData.anchor = nil
        }
        
        print("DEBUG: Anchor: ", self.raycastData.anchor)
    }
    
}



// Is there a limit on texture image dimensions?
// Find example of applying image texture from resource

// https://stackoverflow.com/questions/72324083/applying-different-image-texture-material-to-each-side-of-the-box-in-realitykit

// material.color = .init(tint: .white, texture: .init(texture))

