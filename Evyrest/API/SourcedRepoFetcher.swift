//
//  SourcedRepoAPI.swift
//  Evyrest
//
//  Created by exerhythm on 30.11.2022.
//

import Foundation

/// Sourced Repo fetcher
class SourcedRepoFetcher: ObservableObject {
    
    let serverURL = URL(string: "http://home.sourceloc.net:8080/")
    var session = URLSession.shared
    
    /// Logs into Sourced and, if successful, returns a token
    func login(username: String, password: String) async throws {
        var request = URLRequest(url: serverURL!.appendingPathComponent("account/login"))
        request.httpMethod = "POST"
        let authBase64 = "\(username):\(password)".data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authBase64)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await session.data(for: request) as! (Data, HTTPURLResponse)
        
        print(response)
    }
}
