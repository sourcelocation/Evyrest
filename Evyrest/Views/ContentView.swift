//
//  ContentView.swift
//  Evyrest
//
//  Created by Toby Fox on 29/11/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var imageSourcing = ImageSourcing.shared
    @KeychainStorage("userToken") var userToken: String?
    
    var body: some View {
        VStack {
            Image("Evyrest")
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
