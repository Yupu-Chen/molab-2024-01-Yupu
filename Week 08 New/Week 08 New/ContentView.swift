import SwiftUI
import RealityKit
import ARKit
import PhotosUI

struct ContentView : View {
    
    @State private var selectedImage: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    var body: some View {
        
        //ARViewContainer(selectedImageData: $selectedImageData)
            //.edgesIgnoringSafeArea(.all)
        
        PhotosView()
        
        /*PhotosPicker(selection: $selectedImage, label: {
            Image(systemName: "camera")
        })
        .onChange(of: selectedImage) {
            Task {
                if let data = try? await selectedImage?.loadTransferable(type: Data.self) {
                    selectedImageData = data
                    print("selectedImage = data", data)
                    return
                }
                print("selectedImage loadTransferable failed")
            }
        }*/
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var selectedImageData: Data?
    
    var ARImage: ImageEntity = ImageEntity()
    
//    @State private var texture: TextureResource?
//    @State private var material: SimpleMaterial = SimpleMaterial(color: .white, isMetallic: true)
//    @State var anchor: AnchorEntity = AnchorEntity(.plane(.any, classification: .any, minimumBounds: .zero))
//    @State var entity: ModelEntity = ModelEntity(mesh: .generateBox(size: 0.5), materials: [SimpleMaterial(color: .white, isMetallic: true)])
    
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
        
        
//        entity = ModelEntity(mesh: .generateBox(size: 0.5), materials: [material])
//        anchor = AnchorEntity(.plane(.any, classification: .any, minimumBounds: .zero))
//        anchor.addChild(entity)
//        arView.scene.addAnchor(anchor)
        
        // Set debug options
#if DEBUG
        arView.debugOptions = [.showFeaturePoints, .showWorldOrigin, .showSceneUnderstanding]
#endif
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // disable to try to allow repeated assignement of texture
        // yields error:
        // Can't create new immutable asset. An asset with specified load descriptor MemoryAsset already exists.
//        guard self.texture == nil else {
//            print("ARViewContainer updateUIView return")
//            return // Texture already loaded, no need to load again
//        }
        
        if let data = self.selectedImageData {
            let imageName = "image1.png";
            let filePath = documentsDirectory.appendingPathComponent(imageName)
            print("updateUIView imageName =", imageName)
            print("updateUIView data =", data)
            try? data.write(to: filePath)
            DispatchQueue.main.async {
                let texture = try? TextureResource.load(contentsOf: filePath)
                print("updateUIView self.texture =", texture ?? "-none-")
                if let texture = texture {
                    ARImage.texture = texture
                    uiView.scene.addAnchor(ARImage.AddNewImage()!)
                    print("updateUIView let texture", texture)
                }
            }
        }
        
        print("updateUIView updated selectedImageData", selectedImageData ?? "-none-")
    }
    
}



// Is there a limit on texture image dimensions?
// Find example of applying image texture from resource

// https://stackoverflow.com/questions/72324083/applying-different-image-texture-material-to-each-side-of-the-box-in-realitykit

// material.color = .init(tint: .white, texture: .init(texture))

