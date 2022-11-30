//
//  SwiftUIPropertyWrapper.swift
//  Evyrest
//
//  Created by Lakhan Lothiyi on 30/11/2022.
//

import Foundation
import SwiftUI

@propertyWrapper
struct KeychainStorage: DynamicProperty {
    private let key: String

    var wrappedValue: String? {
        get {
            getValue()
        }

        nonmutating set {
            setValue(newValue)
        }
    }
    
    func getValue() -> String? {
        KeychainWrapper.standard.string(forKey: key)
    }
    
    func setValue(_ val: String?) {
        if let val = val {
            KeychainWrapper.standard.set(val, forKey: key)
        } else {
            KeychainWrapper.standard.removeObject(forKey: key)
        }
    }
    
    init(_ key: String) {
        self.key = key
    }
}
