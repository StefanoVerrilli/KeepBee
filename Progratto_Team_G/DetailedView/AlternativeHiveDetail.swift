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
    let defaults = UserDefaults.standard
    @State private var navigateBack = false
    @State private var HiveName:String = "Hive"
    @State private var QueenChange = Date()
    @State private var RoyalCellInserted = Date()
    @State private var QueenInserted = Date()
    @State private var OrphanHive: Bool = false
    @State private var LastNourishedDay:Date = Date()
    @State private var NextNutritionDay:Date = Date()
    @State private var SwarmPickedUp:Date = Date()
    @State private var LoomsInside: Int = 4
    @State private var HiveDiagram: Bool = false
    if let savedHive = defaults.object(forKey: "Hive1") as? Data{
            let decoder = JSONDecoder()
            if let loadedHive = try? decoder.decode(Hive.self, from: savedHive)
            {
                print(loadedHive.name)
            }
        }
    var body: some View{
        NavigationView{
        Form{
            HiveHealthView(Data: $LastNourishedDay, Data2: $NextNutritionDay, Data3: $SwarmPickedUp)
            GeneralInformationHiveView(LoomsInside: $LoomsInside, HiveDiagram: $HiveDiagram)
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
                       let myhive=Hive(QueenChange, RoyalCellInserted, QueenInserted, OrphanHive, LoomsInside, HiveDiagram, LastNourishedDay, NextNutritionDay, SwarmPickedUp)
                        print(myhive)
                        let encoder = JSONEncoder();
                        if let encoded = try? encoder.encode(myhive) { let defaults = UserDefaults.standard
                            defaults.set(encoded, forKey: "Hive1")}
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
    @Binding var LoomsInside: Int
    @Binding var HiveDiagram: Bool
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
            CustomToggle(StringToDisplay: "Orphan: ")
            CustomDatePicker(dateToTrack: $RoyalCellInserted, StringToDisplay: "Royal cell inserted")
            CustomDatePicker(dateToTrack: $QueenChange,StringToDisplay: "Need to be changed in")
            CustomDatePicker(dateToTrack: $QueenInserted,StringToDisplay: "Queen inserted in")
        }
    }
    
}

struct HiveHealthView: View {
    @Binding var Data:Date
    @Binding var Data2:Date
    @Binding var Data3:Date
    var body: some View {
        Section(header:HStack{
            Image(systemName: "heart.fill")
            Text("Hive Health")
        }){
            CustomDatePicker(dateToTrack: $Data, StringToDisplay: "Last nourished day")
            CustomDatePicker(dateToTrack: $Data2, StringToDisplay: "Next nutrition day")
            CustomDatePicker(dateToTrack: $Data3, StringToDisplay: "Swarm picked up")
        }
    }
}

