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
            header
            sourceLocation
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading, content: {
            Text("gm")
        })
        .background {
            Image("Background")
                .resizable()
                .scaledToFill()
                .blur(radius: 10)
                .ignoresSafeArea()
        }
        .background(Color("BackgroundColor"))
        .safeAreaInset(edge: .bottom) {
            Text(copyrightLine)
        }
    }
    
    @ViewBuilder
    var header: some View {
        Image("Evyrest")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .frame(maxWidth: 175)
    }
    
    @ViewBuilder
    var sourceLocation: some View {
        VStack {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
