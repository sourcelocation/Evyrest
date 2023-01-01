//
//  AboutView.swift
//  Evyrest
//
//  Created by Lakhan Lothiyi on 30/12/2022.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Credits")
                .font(.headline)
//                .padding(12)
            VStack(spacing: 4) {
                Text("Made by sourcelocation")
                Text("with help from llsc12")
                    .font(.footnote)
                    .opacity(0.6)
            }
            Text("MIT - Skittyblock/WallpaperSetter\nPublic Domain - rileytestut/Clip")
                .font(.footnote)
                .opacity(0.6)
            VStack {
                Button(action: {
                    openURL(URL(string: "https://discord.gg/HTseVFhEbK")!)
                }) {
                    HStack {
                        Spacer()
                        Image("discord")
                        Text("Discord")
                        Spacer()
                    }
                    .padding(8)
                    .background(MaterialView(.light))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                }
                Button(action: {
                    openURL(URL(string: "https://twitter.com/sourceloc")!)
                }) {
                    HStack {
                        Spacer()
                        Image("github")
                        Text("Github")
                        Spacer()
                    }
                    .padding(8)
                    .background(MaterialView(.light))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                }
            }
            Spacer()
            Text("You are awesome for using this app! :)")
                .font(.footnote)
                .opacity(0.6)
        }
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .frame(height: 400)
    }
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(aboutPresented: true)
    }
}
