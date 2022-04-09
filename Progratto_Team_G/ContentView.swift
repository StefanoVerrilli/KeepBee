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
    var body: some View {
        NavigationView{
        ZStack{
            Color(red: 251/255, green: 230/255, blue: 155/255).edgesIgnoringSafeArea(.top)
            Image("Background").scaledToFit().edgesIgnoringSafeArea(.top)
            VStack(alignment:.leading,spacing:3){
                Spacer()
                HStack{
                    Text("Track your hives")
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .frame(alignment:.leading)
                    Spacer()
                    NavigationLink(destination: RecordingView()){
                        VStack{
                            ButtonView()}
                    }.buttonStyle(PlainButtonStyle())
                    }.padding()
                     HStack{
                Text("Shake the iPhone to record \nor press the \"+\" button to\ntake notes")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .font(.system(size:26))
                }.padding(.leading)
                List{
                    MaskView()
                    MaskView()
                    MaskView()
                    MaskView()
                    MaskView()
                }.padding(.top,-3).padding(.leading,-10)
                }.padding()
        }}
        
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
                Text("21/03/2022")
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
        ZStack{
            ListItem()
            NavigationLink(destination:DetailedHiveView()){
                EmptyView()
            }.buttonStyle(PlainButtonStyle())
        }.listRowBackground(Color.clear)
    }
}

struct ButtonView: View {
    var body: some View {
        Image("customplus").background(Color(red: 237/255, green: 194/255, blue: 93/255).cornerRadius(90).frame(width: 45, height: 45,alignment:.trailing)).padding(.trailing)
    }
}
