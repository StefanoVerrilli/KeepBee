//
//  DetailedHiveView.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 09/04/22.
//

import Foundation
import SwiftUI

struct DetailedHiveView: View{
    init() {
        UINavigationBar.appearance().backgroundColor = .none
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(Color.black)
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
    }
    
    @State private var GenericDate = Date()
    @State private var LoomsInside: Int = Int()
    @State private var HiveDiagram:Bool = false
    
    var body: some View{
        VStack{
            VStack(alignment:.leading,spacing: 10){
                Label("General information", systemImage: "archivebox.fill")
                    .padding(.top)
                    .padding(.leading)
                Divider()
                    .frame(height:1,alignment: .trailing)
                    .background(Color(red: 56/255,green:56/255,blue:58/255))
                    .padding(.leading)
                    .listRowInsets(EdgeInsets())
                CustomDatePicker()
                CustomNumPicker(LoomsInside: LoomsInside)
                Toggle(isOn: $HiveDiagram){
                    Text("Hive Diagram")
                }.padding().offset(y:-4)

            }.background(Color(red: 237/255, green: 194/255, blue: 93/255)).cornerRadius(10).padding()
        }.background(BackgroundView()).navigationTitle(Text("Hive A")).navigationBarTitleDisplayMode(.inline)
        }
}

struct DetailedHiveView_Previews: PreviewProvider{
    static var previews: some View{
        DetailedHiveView()
    }
}

struct CustomNumPicker: View {
    @State public var LoomsInside: Int
    var body: some View {
        Menu{
            Picker(selection: $LoomsInside,label: EmptyView()){
                ForEach(0..<10){
                    Text("\($0)")
                }
            }.menuStyle(.borderlessButton)} label:{
                HStack {
                    Text("Looms inside")
                    Spacer()
                    Text(String(LoomsInside))
                    Image(systemName:"chevron.right")}
                .foregroundColor(.white)
                .padding()
                .frame(height:64)
                .background(Color(red: 28/255, green: 28/255, blue: 30/255))
            }
    }
}

struct CustomDatePicker: View {
    @State public var GenericDate = Date()
    var body: some View {
        DatePicker("Pick a date", selection: $GenericDate, displayedComponents: .date)
            .padding()
            .background(Color(red: 28/255, green: 28/255, blue: 30/255))
            .foregroundColor(Color.white)
            .accentColor(.orange)
            .colorScheme(.dark)
            .background(Color.clear)
        }
}
