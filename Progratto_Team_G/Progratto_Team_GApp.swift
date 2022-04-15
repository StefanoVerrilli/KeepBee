//
//  Progratto_Team_GApp.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 08/04/22.
//

import SwiftUI

@main
struct Progratto_Team_GApp: App {
    /*init(){
            SubmitChanges(StringToSubmit: "Sasha è orfana nutrire l'arnia fra 20 a no 13 giorni e regina da sostituire tra 15 giorni e ci sono 2 telai regina da sostituire tra il 25 may 2020 e ci sono ora 2 telai")
    }*/
    var body: some Scene {
        WindowGroup {
            Tabbar().environmentObject(SwiftUISpeech())
        }
    }
}

