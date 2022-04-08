//
//  ContentView.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 08/04/22.
//

import SwiftUI

struct ContentView: View{
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(Color.clear)
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
    }
    var body: some View {
        ZStack{
            Color(red: 251/255, green: 230/255, blue: 155/255)
            Image("Background").scaledToFit()
            VStack{
                Spacer(minLength: 50)
                HStack{
                    Text("Track your hives")
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .frame(alignment: .leading)
                        .padding()
                    Spacer()
                    Image("Plus").padding()
                }.padding(.leading).padding(.top).padding(.trailing)
                HStack{
                Text("Shake the iPhone to record \nor press the \"+\" button to\ntake notes")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .font(.system(size:26))
                    .padding(.leading)
                }.padding(.leading)
                List{
                    ListItem()
                    ListItem()
                    ListItem()
                    ListItem()
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()    }
}

struct ListItem: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.pink)
                .frame(height: 137)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:4, x:0, y:4)
            VStack(alignment: .leading){
                Text("21/03/2022")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity, alignment: .topLeading)
                    .padding(.leading)
                    .padding(.top)
                Text("Tap to see in detail")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity, alignment: .topLeading)
                    .padding(.leading)
                Spacer()
            }
        }.listRowBackground(Color.clear)
    }
}
