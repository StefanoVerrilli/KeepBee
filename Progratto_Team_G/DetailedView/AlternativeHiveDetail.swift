//
//  AlternativeHiveDetail.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 10/04/22.
//

import Foundation
import SwiftUI
//import ParthenoKit

struct AlternativeHiveDetail: View{
    init(){
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().barTintColor = UIColor(Color("CustomOrange"))
        UINavigationBar.appearance().backgroundColor = UIColor(Color("CustomOrange"))
        UITableView.appearance().separatorColor = UIColor.black
        }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateBack = false
    @State private var HiveName:String = "Hive"
    @State private var QueenChange = Date()
    @State private var RoyalCellInserted = Date()
    @State private var QueenInserted = Date()
    @State private var OrphanHive: Bool = false
    var MyHide:Hive = Hive()
    var body: some View{
        NavigationView{
        Form{
            HiveHealthView()
            GeneralInformationHiveView()
            QueenBeeDetailsView(QueenChange: $QueenChange, RoyalCellInserted: $RoyalCellInserted, QueenInserted: $QueenInserted)
        }.background(BackgroundView())
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        self.presentationMode.wrappedValue.dismiss()
                    }label: {
                        Label("cancel",systemImage: "xmark").labelStyle(.iconOnly)
                            .foregroundColor(Color.black)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        navigateBack = true
                        self.presentationMode.wrappedValue.dismiss()
                    }label: {
                        Label("Confirm",systemImage: "checkmark").labelStyle(.iconOnly).foregroundColor(Color.black)
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
            //CustomPicker()
            Toggle(isOn: $HiveDiagram){
                Text("Hive Diagram")
            }
            .padding(.vertical)
            .listRowBackground(Color("CustomOrange"))
        }
    }
}

struct QueenBeeDetailsView: View {
    @Binding var QueenChange:Date
    @Binding var RoyalCellInserted:Date
    @Binding var QueenInserted:Date
    var body: some View {
        Section(header:HStack{
            Image(systemName: "crown.fill")
            Text("Queen bee details")
        }){
            let OrphanHiveToggle = CustomToggle(StringToDisplay: "Orphan: ")
            OrphanHiveToggle
            CustomDatePicker(dateToTrack: $RoyalCellInserted, StringToDisplay: "Royal cell inserted")
            CustomDatePicker(dateToTrack: $QueenChange,StringToDisplay: "Need to be changed in")
            CustomDatePicker(dateToTrack: $QueenInserted,StringToDisplay: "Queen inserted in")
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
                .listRowBackground(Color("CustomOrange"))
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

