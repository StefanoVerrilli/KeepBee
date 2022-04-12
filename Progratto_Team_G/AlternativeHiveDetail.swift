//
//  AlternativeHiveDetail.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 10/04/22.
//

import Foundation
import SwiftUI

struct AlternativeHiveDetail: View{
    init(){
            UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = UIColor.black
        }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateBack = false
    @State private var HiveName:String = "Hive"
    var body: some View{
        NavigationView{
        Form{
            HiveHealthView()
            GeneralInformationHiveView()
            QueenBeeDetailsView()
        }.background(BackgroundView())
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        self.presentationMode.wrappedValue.dismiss()
                    }label: {
                        Label("cancel",systemImage: "xmark").labelStyle(.iconOnly)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        navigateBack = true
                        self.presentationMode.wrappedValue.dismiss()
                    }label: {
                        Label("Confirm",systemImage: "checkmark").labelStyle(.iconOnly)
                    }.disabled(HiveName.isEmpty)
                }
            }).navigationTitle("Hive A")
            .navigationBarTitleDisplayMode(.inline)
        }
    }}


struct AlternativeHiveDetail_Previews: PreviewProvider{
    static var previews: some View{
        AlternativeHiveDetail()
    }
}

struct GeneralInformationHiveView: View {
    @State private var LoomsInside: Int = Int()
    @State private var HiveDiagram: Bool = false
    var body: some View {
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
    }
}

struct QueenBeeDetailsView: View {
    @State private var QueenChange = Date()
    @State private var RoyalCellInserted = Date()
    @State private var QueenInserted = Date()
    @State private var OrphanHive: Bool = false
    var body: some View {
        Section(header:HStack{
            Image(systemName: "crown.fill")
            Text("Queen bee details")
        }){
            Toggle(isOn: $OrphanHive){
                Text("Orphan: ")
            }.padding(.vertical)
                .listRowBackground(Color(red: 237/255, green: 194/255, blue: 93/255))
            DatePicker("Inserted in",selection: $QueenInserted,displayedComponents: .date)
                .listRowBackground(Color(red: 237/255, green: 194/255, blue: 93/255))
                .padding(.vertical)
                .datePickerStyle(.compact)
            DatePicker("Need to be changed in",selection: $QueenChange,displayedComponents: .date)
                .listRowBackground(Color(red: 237/255, green: 194/255, blue: 93/255))
                .padding(.vertical)
                .datePickerStyle(.compact)
            DatePicker("Royal cell inserted in",selection: $RoyalCellInserted,displayedComponents: .date)
                .listRowBackground(Color(red: 237/255, green: 194/255, blue: 93/255))
                .padding(.vertical)
                .datePickerStyle(.compact)
        }
    }
}

struct HiveHealthView: View {
    @State private var Data = Date()
    var body: some View {
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
    }
}
