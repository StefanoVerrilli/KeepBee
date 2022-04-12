//
//  ContentView.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 08/04/22.
//

import SwiftUI

struct ContentView: View{
    init() {
        UINavigationBar.appearance().backgroundColor = .none
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(Color.clear)
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
    }
    @State private var showDetailedView = false
    var body: some View {
       NavigationView{
            VStack(spacing:0){
                HStack{
                    Text("Track your hives")
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .frame(alignment:.leading)
                        Spacer()
                    NavigationLink(destination: RecordingView()){
                        Image("customplus").resizable().padding().background(Color(red: 237/255, green: 194/255, blue: 93/255)).cornerRadius(90).frame(width:55,height: 55)}.navigationBarHidden(true)
                }.padding()
                     HStack{
                Text("Shake the iPhone to record \nor press the \"+\" button to\ntake notes")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .font(.system(size:26))
                }.padding(.leading)
                List{
                    Button(action: {showDetailedView = true}, label:{ListItem()}).listRowBackground(Color.clear)
                }.padding(.leading,-10)
            }.background(BackgroundView())
       }.navigationViewStyle(.stack)
            .sheet(isPresented: $showDetailedView){
                AlternativeHiveDetail()
            }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()    }
}

struct ListItem: View {
    var body: some View {
        ZStack(alignment:.topLeading){
            Image("hives")
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight:137,alignment: .bottomTrailing)
                    .cornerRadius(10)
                    .brightness(-0.1)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.clear, lineWidth: 4))
                    .shadow(radius: 10)
            VStack{
                Text("Hive n.1")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.top)
                Text("Tap to see in detail")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(.leading)
                Spacer()
            }
        }.listRowBackground(Color.clear).clipped()
    }
}

struct MaskView: View {
    var body: some View {
        Button(action: {print("button tap")}, label:{ListItem()}).listRowBackground(Color.clear)
        /*ZStack{
            ListItem()
            NavigationLink(destination:AlternativeHiveDetail()){
                EmptyView()
            }.buttonStyle(PlainButtonStyle()).navigationViewStyle(.stack)
        }.listRowBackground(Color.clear)*/
    }
}
