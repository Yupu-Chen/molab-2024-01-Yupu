//
//  ImageView.swift
//  Week 08 New
//
//  Created by Yupu Chan on 7/4/2024.
//

import SwiftUI

struct DetailView: View {
    var imageName: String
    @State var selected: Bool = false

    @EnvironmentObject var imageEntity: ImageEntity
    
    var body: some View {
        NavigationStack{
            VStack{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                Text(imageName)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .toolbar {
                ToolbarItem{
                    Button(action: {
                        
                    }, label: {
                        Text("Select")
                    })
                }
            }
        }
    }
}

#Preview {
    DetailView(imageName: "1931.522 - The Bewitched Mill")
}
