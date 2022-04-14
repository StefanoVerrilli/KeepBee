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
        HivesList.items = LoadHivesArray(keyToFind: "HivesArray")
    }
    @State private var showDetailedView = false
    @State private var SelectedHive : Hive? = nil
    @ObservedObject var HivesList = HiveList()
    var body: some View {
       NavigationView{
            VStack(spacing:0){
                HStack{
                    Text("Track your hives")
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .frame(alignment:.leading)
                        Spacer()
                            Button(action: {showDetailedView = true}, label:{Image("customplus").resizable().padding().background(Color("CustomOrange")).cornerRadius(90).frame(width:55,height: 55)}).listRowBackground(Color.clear)
                        .navigationBarHidden(true).sheet(isPresented:$showDetailedView,onDismiss: {showDetailedView = false}){
                        AlternativeHiveDetail(MyPersonalList: HivesList)
                    }
                }.padding()
            
                
                     HStack{
                Text("Press the \"+\" button to\nadd an hive.")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .font(.system(size:26))
                }.padding(.leading)
                List{
                    ForEach(HivesList.items){ hive in
                        Button(action: {
                            print(hive)
                            self.SelectedHive = hive
                        }, label:{ListItem(title: hive.HiveName)}).listRowBackground(Color.clear)
                    }
                }.padding(.leading,-10).sheet(item: self.$SelectedHive){hive in
                    AlternativeHiveDetail(InputHive: hive, MyPersonalList: HivesList)
                }
            }.background(BackgroundView())
       }.navigationViewStyle(.stack)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()    }
}

struct ListItem: View {
    var title: String
    var hiveToOpen: Hive?
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
                Text(title)
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
        Button(action: {print("button tap")}, label:{ListItem(title: "Hive n.1")}).listRowBackground(Color.clear)
    }
}

