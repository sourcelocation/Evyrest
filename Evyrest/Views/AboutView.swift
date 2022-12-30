//
//  AboutView.swift
//  Evyrest
//
//  Created by Lakhan Lothiyi on 30/12/2022.
//

import SwiftUI

struct AboutView: View {
    
    var apps: [LSApplicationProxy]
    
    init() {
        apps = []
        let allApps = LSApplicationWorkspace.default().allApplications().compactMap { return $0 }
        apps = allApps
    }
    
    var body: some View {
        ScrollView {
            ForEach(apps) { app in
                Text(app.localizedName()!)
            }
        }
        .frame(maxHeight: 400)
    }
}

extension LSApplicationProxy: Identifiable {
    public var id: String { self.bundleIdentifier! }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
