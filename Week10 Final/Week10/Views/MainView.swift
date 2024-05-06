//
//  MainView.swift
//  Week 08 New
//
//  Created by Yupu Chan on 5/4/2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var showAlbum = false
    
    //@State var location: CGPoint
    
    @EnvironmentObject var imageEntity: ImageEntity
    
    @State var arView = ARViewContainer()
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                
                self.arView
                    .onAppear{
                        self.arView.location = CGPoint(x: geo.size.width/2, y: geo.size.height/2)
                        print(self.arView.location)
                    }
                    .edgesIgnoringSafeArea(.all)
                
                Image(systemName: "chevron.up.chevron.down")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .position(CGPoint(x: geo.size.width/2, y: geo.size.height/2))
                
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
                            if let arViewGlobal = arView.raycastData.arViewGlobal{
                                arView.setAnchor(arViewGlobal)
                            }
                        }, label: {
                            Text("Add")
                                .font(.system(size: 19))
                                .frame(width: 35, height: 23)
                        })
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        Spacer()
                    }
                    Spacer()
                }
                .sheet(isPresented: $showAlbum, content: {
                    NavigationStack{
                        PhotosView(isShowSheet: self.$showAlbum)
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
}

//#Preview {
    //MainView()
//}
