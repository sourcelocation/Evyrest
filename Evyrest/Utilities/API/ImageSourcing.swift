//
//  ImageSourcing.swift
//  Evyrest
//
//  Created by exerhythm on 29.11.2022.
//

import Foundation


class ImageSourcing: ObservableObject {
    
    static let shared = ImageSourcing()
    
    @Published var apiSource: APISource = .pexels
    
    enum APISource: String, CaseIterable, Codable {
        case pexels = "Pexels"
        case unsplash = "Unsplash"
        case microsoft = "Microsoft"
        case local = "Local"
    }
}
