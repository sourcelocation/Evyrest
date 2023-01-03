//
//  ImageSourcing.swift
//  Evyrest
//
//  Created by exerhythm on 29.11.2022.
//

import UIKit

class ImageSourcing: ObservableObject {
    
    static let shared = ImageSourcing()
    
    enum APISource: String, CaseIterable, Codable {
        case unsplash = "Unsplash"
        case pexels = "Pexels"
        case microsoft = "Microsoft"
        case local = "Local"
    }
    
    static func getImage(from apiSource: APISource, searchTerm: String?) async throws -> (String, UIImage) {
        var url: String!
        
        if apiSource != .local {
            switch apiSource {
            case .pexels:
                url = ""
            case .unsplash:
                url = "https://source.unsplash.com/random/\(Int(await UIScreen.main.nativeBounds.width))x\(Int(await UIScreen.main.nativeBounds.height))" + (searchTerm != nil ? "?\(searchTerm!)" : "")
            case .microsoft:
                // Microsoft gives data about image in JSON, we have to fetch the metadata first and then load the image using extracted url
                let jsonURL = "http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US"
                
                let request = URLRequest(url: .init(string: jsonURL)!)
                let (data, response) = try await URLSession.shared.data(for: request)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw "Non 200 code from \(apiSource) 1. Error code 4-\((response as? HTTPURLResponse)?.statusCode ?? 0)" }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw "response is not json" }
                guard let url1 = (json["images"] as? [[String: Any]])?[0]["url"] as? String else { throw "no url in images response from microsoft" }
                url = "https://bing.com" + url1
            case .local: break
                
            }
            
            // load image using url we got
            guard let urlForRequrest = URL(string: url) else { throw "Invalid URL / not yet implemented" }
            let request = URLRequest(url: urlForRequrest)
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw "Non 200 code from \(apiSource). Error code 4-\((response as? HTTPURLResponse)?.statusCode ?? 0)" }
            guard let image = UIImage(data: data) else { throw "Response wasn't an image." }
            
            var id: String?
            switch apiSource {
            case .unsplash:
                id = response.url!.lastPathComponent + ".png"
            case .pexels: break
            case .microsoft:
                id = URLComponents(string: response.url!.absoluteString)!
                    .queryItems!.first(where: { $0.name == "id" })?.value!
            case .local:
                break
            }
            guard let id = id else { throw "Couldn't extract id from response from \(apiSource.rawValue). URL=\(response.url!.absoluteString)"}
            return (id,image)
        } else {
            // TODO: Local
            return ("person", UIImage(systemName: "person")!)
        }
    }
}
