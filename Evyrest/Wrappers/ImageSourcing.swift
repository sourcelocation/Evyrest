//
//  ImageSourcing.swift
//  Evyrest
//
//  Created by exerhythm on 29.11.2022.
//

import Foundation


class ImageSourcing: ObservableObject {
    enum APISource: String, CaseIterable {
        case pexels = "Pexels"
        case unsplash = "Unsplash"
        case microsoft = "Microsoft"
        case local = "Local"
    }
    
    /// API source to fetch images from
    @Published public var apiSource: APISource
    
    
    init(apiSource: APISource) {
        self.apiSource = apiSource
    }
}
