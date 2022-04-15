//
//  Progratto_Team_GApp.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 08/04/22.
//

import SwiftUI

@main
struct Progratto_Team_GApp: App {
    init(){
            SubmitChanges(StringToSubmit: "è orfana nutrire l'arnia fra 20 cazzo no 13 giorni e regina da sostituire tra 15 giorni e ci sono 2 telai regina da sostituire Peppina il 25 may 2020 e ci sono ora 7 telai e pesa 20 chili a no 50 chili eeee no pesa 10 chili e ci sono 2 telai")
    }
    var body: some Scene {
        WindowGroup {
            Tabbar().environmentObject(SwiftUISpeech())
        }
    }
}

