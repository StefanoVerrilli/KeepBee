//
//  AlternativeHiveDetail.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 10/04/22.
//

import Foundation
import SwiftUI
//import ParthenoKit

//var CurrentHive: Hive = Hive()

struct AlternativeHiveDetail: View{
    var CurrentHive: Hive
    @State private var NewView: Bool = false
    @State private var QueenChange: Date
    @State private var RoyalCellInserted: Date
    @State private var QueenInserted: Date
    @State private var OrphanHive: Bool
    @State private var LastNourishedDay:Date
    @State private var NextNutritionDay:Date
    @State private var SwarmPickedUp:Date
    @State private var LoomsInside: Int
    @State private var HiveDiagram: Bool
    @State private var HiveWheight: String
    @State private var HiveName:String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var HivesList: HiveList
    init(InputHive: Hive,MyPersonalList: HiveList){
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().barTintColor = UIColor(Color("CustomOrange"))
        UINavigationBar.appearance().backgroundColor = UIColor(Color("CustomOrange"))
        UITableView.appearance().separatorColor = UIColor.black
        CurrentHive = InputHive
        
        _QueenChange = State(initialValue: InputHive.QueenChange)
        _HiveName = State(initialValue: InputHive.HiveName)
        _HiveWheight = State(initialValue: InputHive.HiveWheight)
        _RoyalCellInserted = State(initialValue: InputHive.RoyalCellInserted)
        _QueenInserted = State(initialValue: InputHive.QueenInserted)
        _OrphanHive = State(initialValue: InputHive.OrphanHive)
        _LastNourishedDay = State(initialValue: InputHive.LastNourishedDay)
        _NextNutritionDay = State(initialValue: InputHive.NextNutritionDay)
        _SwarmPickedUp = State(initialValue: InputHive.SwarmPickedUp)
        _LoomsInside = State(initialValue: InputHive.LoomsInside)
        _HiveDiagram = State(initialValue: InputHive.HiveDiagram)
        
        HivesList = MyPersonalList
        }
    init(MyPersonalList: HiveList){
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().barTintColor = UIColor(Color("CustomOrange"))
        UINavigationBar.appearance().backgroundColor = UIColor(Color("CustomOrange"))
        UITableView.appearance().separatorColor = UIColor.black
        CurrentHive = Hive()
        
        _QueenChange = State(initialValue: CurrentHive.QueenChange)
        _HiveName = State(initialValue: CurrentHive.HiveName)
        _HiveWheight = State(initialValue: CurrentHive.HiveWheight)
        _RoyalCellInserted = State(initialValue: CurrentHive.RoyalCellInserted)
        _QueenInserted = State(initialValue: CurrentHive.QueenInserted)
        _OrphanHive = State(initialValue: CurrentHive.OrphanHive)
        _LastNourishedDay = State(initialValue: CurrentHive.LastNourishedDay)
        _NextNutritionDay = State(initialValue: CurrentHive.NextNutritionDay)
        _SwarmPickedUp = State(initialValue: CurrentHive.SwarmPickedUp)
        _LoomsInside = State(initialValue: CurrentHive.LoomsInside)
        _HiveDiagram = State(initialValue: CurrentHive.HiveDiagram)
        
        HivesList = MyPersonalList
        NewView = true
        }
    
    @State private var navigateBack = false
    var body: some View{
        NavigationView{
        Form{
            GeneralInformationHiveView(LoomsInside: $LoomsInside, HiveDiagram: $HiveDiagram,HiveName: $HiveName,HiveWheight: $HiveWheight)
            HiveHealthView(FirstDate: $LastNourishedDay, SecondDate: $NextNutritionDay, ThirdDate: $SwarmPickedUp)
            QueenBeeDetailsView(QueenChange: $QueenChange, RoyalCellInserted: $RoyalCellInserted, QueenInserted: $QueenInserted, isHorphan: $OrphanHive)
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
                        var hiveToSave=Hive(QueenChange, RoyalCellInserted, QueenInserted, OrphanHive, LoomsInside, HiveDiagram, LastNourishedDay, NextNutritionDay, SwarmPickedUp, HiveName,HiveWheight)
                        hiveToSave.id = CurrentHive.id
                        var newArrayHives = LoadArrayOfHives(keyToFind: "ArrayOfHives")
                        if (NewView == false){
                            let index = HivesList.items.firstIndex(where: {$0.id == CurrentHive.id})
                            if(index != nil){HivesList.items.remove(at:index!)}
                            RemoveHives(keyToRemove: CurrentHive.id.uuidString)
                            saveHive(hiveToSave: hiveToSave, InputKey: CurrentHive.id.uuidString)
                        }else{
                            saveHive(hiveToSave: hiveToSave, InputKey: CurrentHive.id.uuidString)}
                        HivesList.items.insert(hiveToSave, at: 0)
                        RemoveHives(keyToRemove: "ArrayOfHives")
                        newArrayHives = HivesList.items
                        saveArrayOfHives(myArray: newArrayHives, keyToFind: "ArrayOfHives")
                        self.presentationMode.wrappedValue.dismiss()
                    }label: {
                        Label("Confirm",systemImage: "checkmark").labelStyle(.iconOnly).accentColor(Color.black)
                    }.disabled(HiveName.isEmpty || (HivesList.items.filter{HiveName.range(of: $0.HiveName,options: .caseInsensitive) != nil}.count == 1 && NewView == true))
                }
            }).navigationTitle(HiveName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }}

struct GeneralInformationHiveView: View {
    @Binding var LoomsInside: Int
    @Binding var HiveDiagram: Bool
    @Binding var HiveName: String
    @Binding var HiveWheight: String
    var body: some View {
        Section(header:HStack{
            Image(systemName: "archivebox.fill")
            Text("General information")
        }){
            AlternativeTextInput(stringToDisplay: "Hive Name", valueNeeded: $HiveName)
            AlternativeTextInput(stringToDisplay: "Hive Wheight", valueNeeded: $HiveWheight)
            customPicker(StringToDisplay: "Looms inside", pickerValue: $LoomsInside)
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
    @Binding var isHorphan:Bool
    var body: some View {
        Section(header:HStack{
            Image(systemName: "crown.fill")
            Text("Queen bee details")
        }){
            CustomToggle(toggleVar: $isHorphan,StringToDisplay: "Orphan: ")
            CustomDatePicker(dateToTrack: $RoyalCellInserted, StringToDisplay: "Royal cell inserted")
            CustomDatePicker(dateToTrack: $QueenChange,StringToDisplay: "Need to be changed in")
            CustomDatePicker(dateToTrack: $QueenInserted,StringToDisplay: "Queen inserted in")
        }
    }
    
}

struct HiveHealthView: View {
    @Binding var FirstDate:Date
    @Binding var SecondDate:Date
    @Binding var ThirdDate:Date
    var body: some View {
        Section(header:HStack{
            Image(systemName: "heart.fill")
            Text("Hive Health")
        }){
            CustomDatePicker(dateToTrack: $FirstDate, StringToDisplay: "Last nourished day")
            CustomDatePicker(dateToTrack: $SecondDate, StringToDisplay: "Next nutrition day")
            CustomDatePicker(dateToTrack: $ThirdDate, StringToDisplay: "Swarm picked up")
        }
    }
}

