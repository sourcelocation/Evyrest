//
//  OptionsView.swift
//  Evyrest
//
//  Created by sourcelocation on 30/12/2022.
//

import SwiftUI

struct OptionsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                
            }) {
                ZStack {
                    Image("Background2")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 80)
                        .clipped()
                    Color(hex: "00213A")
                        .opacity(0.3)
                        .clipped()
                    Text("Nature")
                        .font(.headline)
                }
                .overlay(alignment: .trailing) {
                    Image(systemName: "chevron.right")
                        .padding(8)
                }
                .cornerRadius(8)
                .frame(height: 80)
            }
            
            VStack(spacing: 8) {
                HStack {
                    Text("Recents")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Clear")
                            .font(.body)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 8)
                            .background(MaterialView(.light))
                            .cornerRadius(8)
                    }
                }
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0...10, id: \.self) { n in
                            Button(action: {
                                
                            }) {
                                Image("Background2")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70)
                                    .clipped()
                                    .overlay(alignment: .bottom) {
                                        MaterialView(.dark)
                                            .frame(height: 40)
                                            .opacity(0.75)
                                        Image(systemName: "square.and.arrow.down")
                                    }
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .frame(height: 150)
            }
        }
        .padding()
        .foregroundColor(.white)
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(optionsPresented: true)
    }
}
