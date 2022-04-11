//
//  ContentView.swift
//  Tabbar
//
//  Created by Chiara Criscuolo on 09/04/22.
//

import SwiftUI
struct TabView_WithListScrollBehind: View {
    var body: some View {
        TabView {
            
            
            
            RecordingView()
            .tabItem {
                Image(systemName: "mic")
                Text("Record")
            }
            ContentView()
                .tabItem {
                    Image(systemName: "archivebox")
                    Text("Hives")
                }
        }.accentColor(.black)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(red: 237/255.0, green: 194/255.0, blue: 93/255.0, alpha: 1.0)
            
            // Use this appearance when scrolling behind the TabView:
            UITabBar.appearance().standardAppearance = appearance
            // Use this appearance when scrolled all the way up:
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            } else {
                // Fallback on earlier versions
            }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       TabView_WithListScrollBehind()
        
        
    }
}
}


