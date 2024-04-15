//
//  ImageView.swift
//  Week 08 New
//
//  Created by Yupu Chan on 7/4/2024.
//

import SwiftUI

struct DetailView: View {
    var imageName: String?
    @State var selected: Bool = false

    @EnvironmentObject var imageEntity: ImageEntity
    
    @Binding var isShowSheet: Bool
    
    var body: some View {
        NavigationStack{
            VStack{
                if let imageName = self.imageName{
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .padding()
                    Text(imageName)
                        .font(.title2)
                        .fontWeight(.bold)
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

