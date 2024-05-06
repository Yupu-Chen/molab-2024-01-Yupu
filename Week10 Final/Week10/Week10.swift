//
//  Week10.swift
//  Week10
//
//  Created by Yupu Chan on 31/3/2024.
//

import SwiftUI

@main
struct Week10: App {
    
    @StateObject var imageEntity = ImageEntity()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(imageEntity)
        }
    }
}
