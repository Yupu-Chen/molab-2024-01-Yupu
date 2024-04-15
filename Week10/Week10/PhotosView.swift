//
//  PhotosView.swift
//  Week08
//
//  Created by Yupu Chan on 31/3/2024.
//

import SwiftUI

struct PhotosView: View {
    // Array to hold image file names
    @Binding var isShowSheet: Bool
    
    @State private var imageNames: [String] = []
    
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                        ForEach(imageNames, id: \.self) { imageName in
                            NavigationLink(destination: DetailView(imageName: imageName, isShowSheet: self.$isShowSheet), label: {
                                // Load and display images
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                //.frame(width: 100, height: 100) // Adjust size as needed
                            })
                            
                        }
                }
                .padding()
                .navigationTitle("Album")
            }
            .onAppear {
                // Load image names from the "Content" folder
                loadImagesFromFolder(named: "Content")
            }
        }
    }

    func loadImagesFromFolder(named folderName: String) {
        // Get the URL for the "Content" folder in the app's main bundle
        if let folderURL = Bundle.main.resourceURL?.appendingPathComponent(folderName),
           let contents = try? FileManager.default.contentsOfDirectory(atPath: folderURL.path) {
            // Filter only image files (you might want to customize this filter based on your file types)
            imageNames = contents.filter { $0.hasSuffix(".jpg") }
        }
        
        var newImageNames: [String] = []
        
        for item in imageNames {
            let newItem = item.dropLast(4)
            newImageNames.append(String(newItem))
        }
        
        imageNames = newImageNames
        
        print(imageNames)
    }
}
                    



//#Preview {
    //PhotosView()
//}
