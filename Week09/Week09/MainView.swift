//
//  MainView.swift
//  Week 08 New
//
//  Created by Yupu Chan on 5/4/2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var showAlbum = false
    
    @State private var selectedImageData: Data?
    
    @EnvironmentObject var imageEntity: ImageEntity
    
    var body: some View {
        ZStack{
            
            ARViewContainer(selectedImageData: selectedImageData)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Button(action: {
                        showAlbum.toggle()
                    }, label: {
                        Image(systemName:"plus.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                    })
                    Spacer()
                }
                Spacer()
            }
            .sheet(isPresented: $showAlbum, content: {
                NavigationStack{
                    PhotosView()
                        .environmentObject(imageEntity)
                        .toolbar {
                            ToolbarItem {
                                Button("Done") {
                                    showAlbum.toggle()
                                }
                            }
                        }
                }
            })
        }
    }
}

#Preview {
    MainView()
}
