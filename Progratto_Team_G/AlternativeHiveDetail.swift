//
//  AlternativeHiveDetail.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 10/04/22.
//

import Foundation
import SwiftUI

struct AlternativeHiveDetail: View{
    @State private var Data = Date()
    @State private var LoomsInside: Int = Int()
    @State private var HiveDiagram: Bool = false
    init(){
            UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = UIColor.black
        }
    var body: some View{
        Form{
            Section(header:HStack{
                Image(systemName: "heart.fill")
                Text("Hive Health")
                }){
                    DatePicker("Last nourished day",selection: $Data,displayedComponents: .date)
                        .listRowBackground(Color(red: 237/255, green: 194/255, blue: 93/255))
                        .padding(.vertical)
                        .datePickerStyle(.compact)
                    DatePicker("Next nutrition day",selection: $Data,displayedComponents: .date)
                        .listRowBackground(Color(red: 237/255, green: 194/255, blue: 93/255))
                        .padding(.vertical)
                    DatePicker("Swarm picked up",selection: $Data,displayedComponents: .date)
                        .listRowBackground(Color(red: 237/255, green: 194/255, blue: 93/255))
                        .padding(.vertical)
                }
            Section(header:HStack{
                Image(systemName: "archivebox.fill")
                Text("General information")
            }){
                Picker("Looms inside", selection: $LoomsInside) {
                    ForEach(0..<10){
                        Text("\($0)")
                    }
                }.padding(.vertical).listRowBackground(Color(red: 237/255, green: 194/255, blue: 93/255)).foregroundColor(Color.black)
                Toggle(isOn: $HiveDiagram){
                    Text("Hive Diagram")
                }
                .padding(.vertical)
                .listRowBackground(Color(red: 237/255, green: 194/255, blue: 93/255))
            }
        }.background(BackgroundView())
            .navigationTitle(Text("Hive A"))
            .navigationBarTitleDisplayMode(.inline)
    }
}


struct AlternativeHiveDetail_Previews: PreviewProvider{
    static var previews: some View{
        AlternativeHiveDetail()
    }
}

/*struct CustomDatePicker: View {
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
}*/
