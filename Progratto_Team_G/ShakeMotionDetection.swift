//
//  ShakeMotionDetection.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 16/04/22.
//

import SwiftUI
import Foundation

public extension Notification.Name {
    static let shakeEnded = Notification.Name("ShakeEnded")
}

public extension UIWindow {
     override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: .shakeEnded, object: nil)
        }
        super.motionEnded(motion, with: event)
     }
}

struct ShakeDetector: ViewModifier {
    let onShake: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: .shakeEnded)) { _ in
                onShake()
            }
    }
}

public extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(ShakeDetector(onShake: action))
    }
}
