//
//  Week09.swift
//  Week09
//
//  Created by Yupu Chan on 31/3/2024.
//

import SwiftUI

@main
struct Week09: App {
    
    @StateObject var imageEntity = ImageEntity()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(imageEntity)
        }
    }
}
