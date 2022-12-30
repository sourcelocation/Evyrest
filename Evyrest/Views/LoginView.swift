//
//  LoginView.swift
//  Evyrest
//
//  Created by exerhythm on 30.11.2022.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var username = ""
    @State var password = ""
    
    @EnvironmentObject var sourceRepoFetcher: SourcedRepoFetcher
    
    var body: some View {
        VStack {
            Image("evyrest_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.accentColor)
                .frame(width: 80)
                .padding(.top, 32)
            Text("Welcome to\nEvyrest")
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
            HStack {
                Image(systemName: "lanyardcard")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.accentColor)
                    .frame(height: 24)
                Text("Please log in into your Sourced Repo account to continue")
                    .padding(10)
            }
            TextField("Email", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding(4)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 4)
            
            Spacer()
            Button("Forgot password?") {
                
            }
            .padding(4)
            Button(action: {
                Task {
                    do {
                        try await sourceRepoFetcher.login(username: username, password: password)
                        try await sourceRepoFetcher.linkDevice()
                        dismiss()
                    } catch {
                        DispatchQueue.main.async {
                            UIApplication.shared.alert(body: "\(error.localizedDescription)")
                        }
                    }
                }
            }) {
                Text("Log in")
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .frame(maxWidth: 325, maxHeight: .infinity)
        .interactiveDismissDisabled()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
