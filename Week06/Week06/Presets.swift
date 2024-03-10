//
//  Presets.swift
//  Week06
//
//  Created by Yupu Chan on 7/3/2024.
//

import SwiftUI
import AVFoundation

struct Preset: Identifiable, Codable{
    var id = UUID()
    var player: Int
    var time: Int
    
}
