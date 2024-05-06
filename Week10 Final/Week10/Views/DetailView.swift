//
//  ImageView.swift
//  Week 08 New
//
//  Created by Yupu Chan on 7/4/2024.
//

import SwiftUI
import UIKit
import SafariServices

struct DetailView: View {
    var imageName: String?
    @State var selected: Bool = false

    @EnvironmentObject var imageEntity: ImageEntity
    
    @Binding var isShowSheet: Bool
    
    let images = Bundle.main.decode([ImageDetail].self, from: "images.json")
    
    @State private var linkOpened = false
    
    var body: some View {
        NavigationStack{
            VStack{
                if let imageName = self.imageName{
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .padding()
                    VStack (alignment: .leading){
                        Text(imageName)
                            .font(.title2)
                            .fontWeight(.bold)
                        ForEach(images) { image in
                            if image.name == imageName {
                                Text("\(image.artist), \(image.year)")
                                    .font(.body)
                                    .fontWeight(.bold)
                                Text(image.description)
                                    .font(.body)
                                Text("[Read More]")
                                    .foregroundColor(.blue)
                                    .underline()
                                    .onTapGesture {
                                        // When text is tapped, present the sheet
                                        self.linkOpened.toggle()
                                    }
                                    .sheet(isPresented: $linkOpened) {
                                        // Sheet view
                                        SafariView(url: image.link)
                                    }
                            }
                        }
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem{
                    Button(action: {
                        if let imageName = self.imageName{
                            imageEntity.imageName = imageName
                        }
                        self.isShowSheet.toggle()
                    }, label: {
                        Text("Select")
                    })
                }
            }
        }
    }
}

// SafariView to display URL
struct SafariView: View {
    let url: URL
    
    var body: some View {
        SafariViewController(url: url)
            .edgesIgnoringSafeArea(.all)
    }
}

// SafariViewController to present Safari
struct SafariViewController: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariViewController = SFSafariViewController(url: url)
        return safariViewController
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // Update view controller if needed
    }
}
