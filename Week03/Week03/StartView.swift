//
//  StartView.swift
//  Week03
//
//  Created by Yupu Chan on 11/2/2024.
//

import SwiftUI

struct StartView: View {
    @State private var started = false;
    
    var body: some View {
            NavigationStack{
                Spacer()
                Text("Yayoi Kusama")
                    .font(.largeTitle)
                Text("Simulator")
                    .font(.title2)
                Spacer()
                NavigationLink("Start"){
                    ContentView()
                }
                .buttonStyle(.borderedProminent)
                .clipShape(Capsule())
                .controlSize(.large)
            }
    }
}

#Preview {
    StartView()
}
