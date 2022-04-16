//
//  ContentView.swift
//  Tabbar
//
//  Created by Chiara Criscuolo on 09/04/22.
//

import SwiftUI
struct Tabbar: View {
    @StateObject var hives: ObservableList = ObservableList()
    var body: some View {
        TabView {
            RecordingView(hivesArray: hives).environmentObject(SwiftUISpeech(HivesKey: hives))
            .tabItem {
                Image(systemName: "mic")
                Text("Record")
            }
            ContentView(ArrayToModify: hives)
                .tabItem {
                    Image(systemName: "archivebox")
                    Text("Hives")
                }
        }.accentColor(.black)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(red: 237/255.0, green: 194/255.0, blue: 93/255.0, alpha: 1.0)
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance}
    }
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Tabbar()
        }
    }
}


