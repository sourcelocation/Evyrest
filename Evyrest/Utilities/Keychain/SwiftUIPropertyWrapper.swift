//
//  SwiftUIPropertyWrapper.swift
//  Evyrest
//
//  Created by Lakhan Lothiyi on 30/11/2022.
//

import Foundation
import SwiftUI

@propertyWrapper
struct KeychainStorage<String>: DynamicProperty {
    private let key: String?

    var wrappedValue: String {
        get {
            getValue()
        }

        nonmutating set {
            setValue(newValue)
        }
    }
    
    func getValue() -> String {
        KeychainWrapper.standard.string(forKey: key)
    }
    
    func setValue(_ val: String) {
        KeychainWrapper.standard.set(val, forKey: key)
    }
    
    init(_ key: String) {
        self.key = key
    }
}
