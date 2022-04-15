//
//  Progratto_Team_GApp.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 08/04/22.
//

import SwiftUI

@main
struct Progratto_Team_GApp: App {
    var body: some Scene {
        WindowGroup {
            Tabbar().environmentObject(SwiftUISpeech())
        }
    }
}

