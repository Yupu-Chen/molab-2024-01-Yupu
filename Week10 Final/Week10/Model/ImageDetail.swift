//
//  ImageDetail.swift
//  Week10
//
//  Created by Yupu Chan on 27/4/2024.
//

import Foundation


struct ImageDetail: Codable, Hashable, Identifiable {
    var id: UUID
    var name: String
    var artist: String
    var year: String
    var description: String
    var link: URL
}
