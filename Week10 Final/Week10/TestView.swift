//
//  TestView.swift
//  Week10
//
//  Created by Yupu Chan on 12/4/2024.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Button(action: {
            //showAlbum.toggle()
        }, label: {
            Text("Add")
                .font(.system(size: 19))
                .frame(width: 35, height: 23)
        })
        .buttonStyle(.borderedProminent)
        .tint(.blue)
    }
    
    func findFilePath() {
        if let audioFilePath = Bundle.main.path(forResource: "1919.753 - View of Cotopaxi", ofType: ".jpg", inDirectory: "Content") {
            print("FilePath", audioFilePath)
        }
    }
}

#Preview {
    TestView()
}
