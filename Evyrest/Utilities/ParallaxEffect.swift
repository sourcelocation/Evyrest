//
//  MotionManager.swift
//  Evyrest
//
//  Created by exerhythm on 02.12.2022.
//

import Foundation
import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {

    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0

    static let shared = MotionManager()
    
    private var manager: CMMotionManager

    init() {
        self.manager = CMMotionManager()
        self.manager.deviceMotionUpdateInterval = 1/60
        self.manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
            guard error == nil else {
                print(error!)
                return
            }

            if let motionData = motionData {
                self.pitch = motionData.attitude.pitch
                self.roll = motionData.attitude.roll
            }
        }
    }
    
    deinit {
        self.manager.stopDeviceMotionUpdates()
        self.pitch = 0
        self.roll = 0
    }
}

struct ParallaxMotionModifier: ViewModifier {
    
    @ObservedObject var manager = MotionManager.shared
    var magnitude: Double
    
    func body(content: Content) -> some View {
        let scale = magnitude * 2
        let mag = magnitude * 15
        content
            .scaleEffect(scale, anchor: .center)
            .offset(x: CGFloat(manager.roll * mag), y: CGFloat(manager.pitch * mag))
            .animation(.spring(), value: manager.roll)
            .animation(.spring(), value: manager.pitch)
    }
}

extension View {
    func parallaxed(magnitude: Double) -> some View {
        modifier(ParallaxMotionModifier(magnitude: magnitude))
    }
}
