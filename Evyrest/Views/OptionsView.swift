//
//  OptionsView.swift
//  Evyrest
//
//  Created by sourcelocation on 30/12/2022.
//

import SwiftUI

struct OptionsView: View {
    var body: some View {
        VStack {
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 64)
                    .clipped()
                Color(hex: "00213A")
                    .opacity(0.3)
                    .clipped()
                Text("Nature")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .cornerRadius(8)
            .frame(height: 64)
            .padding()
        }
        
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(optionsPresented: true)
    }
}
