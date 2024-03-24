import SwiftUI
import RealityKit
import ARKit
import PhotosUI

struct ContentView : View {
    
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    var body: some View {
        
        ARViewContainer(selectedImageData: $selectedImageData)
            .edgesIgnoringSafeArea(.all)
        
        PhotosPicker(selection: $selectedImage, label: {
            Image(systemName: "camera")
        })
        .onChange(of: selectedImage) {
            Task{
                if let data = try? await
                    selectedImage?.loadTransferable(type: Data.self){
                    selectedImageData = data
                }
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var selectedImageData: Data?
    
    @State private var texture: TextureResource?
    
    @State private var material: SimpleMaterial = SimpleMaterial(color: .white, isMetallic: true)
    
    @State var anchor: AnchorEntity = AnchorEntity(.plane(.any, classification: .any, minimumBounds: .zero))
    
    @State var entity: ModelEntity = ModelEntity(mesh: .generateBox(size: 0.1), materials: [SimpleMaterial(color: .white, isMetallic: true)])
    
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
        
        session.run(config)
        
        // Add coaching overlay
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .anyPlane
        coachingOverlay.activatesAutomatically = true
        arView.addSubview(coachingOverlay)
        
        
        self.entity = ModelEntity(mesh: .generateBox(size: 0.1), materials: [self.material])
        self.anchor = AnchorEntity(.plane(.any, classification: .any, minimumBounds: .zero))
        anchor.addChild(entity)
        arView.scene.addAnchor(anchor)

        // Set debug options
        #if DEBUG
        arView.debugOptions = [.showFeaturePoints, .showWorldOrigin, .showSceneUnderstanding]
        #endif
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        guard self.texture == nil else {
                return // Texture already loaded, no need to load again
            }
        
        if let data = self.selectedImageData {
            let filePath = documentsDirectory.appendingPathComponent("sky.png")
            try? data.write(to: filePath)
            DispatchQueue.main.async {
                self.texture = try? TextureResource.load(contentsOf: filePath)
            }
        }
        
        if let texture = self.texture{
            self.material.baseColor = MaterialColorParameter.texture(texture)
        }
        
        print("updated")
        
    }
    
}

class BoxAnchor: Entity, HasModel {
    var material: SimpleMaterial = SimpleMaterial(color: .white, isMetallic: false)
    required init() {
        super.init()
        self.components[ModelComponent.self] = ModelComponent(
            mesh: .generateBox(size: 0.5),
            materials: [self.material]
        )
    }

    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
