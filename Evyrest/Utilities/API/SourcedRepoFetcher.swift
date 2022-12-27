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
    
    @KeychainStorage("userToken") var userToken: String?
    
    /// Logs into Sourced and, if successful, returns a token
    func login(username: String, password: String) async throws {
        var request = URLRequest(url: serverURL!.appendingPathComponent("account/login"))
        request.httpMethod = "POST"
        let authBase64 = "\(username):\(password)".data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authBase64)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await session.data(for: request) as! (Data, HTTPURLResponse)
        guard response.statusCode == 200 else { throw "Invalid email / password" }
        let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as! [String: Any]
        guard let token = (json["token"] as? [String: Any])?["value"] as? String else { throw "Couldn't parse token" }
        userToken = token
    }
    
    /// Logs into Sourced and, if successful, returns a token
    func linkDevice() async throws {
        guard let userToken = userToken else { throw "Not logged in." }
        var request = URLRequest(url: serverURL!.appendingPathComponent("account/linkDevice?id=\(udid())"))
        request.httpMethod = "POST"
        request.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await session.data(for: request) as! (Data, HTTPURLResponse)
        guard response.statusCode == 200 else { throw "You've reached maximum amount of linked devices to your account. Please remove some at repo.sourceloc.net/account/devices" }
    }
    
    private func udid() -> String {
        let aaDeviceInfo: AnyClass? = NSClassFromString("A" + "A" + "D" + "e" + "v" + "i" + "c" + "e" + "I" + "n" + "f" + "o")
        return aaDeviceInfo?.value(forKey: "u"+"d"+"i"+"d") as! String
    }
}

