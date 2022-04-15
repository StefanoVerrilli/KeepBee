//
//  AlternativeHiveDetail.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 10/04/22.
//

import Foundation
import SwiftUI
//import ParthenoKit

var CurrentHive: Hive = Hive()

struct AlternativeHiveDetail: View{
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
    @State var HiveName:String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var HivesList: HiveList
    init(InputHive: Hive,MyPersonalList: HiveList){
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().barTintColor = UIColor(Color("CustomOrange"))
        UINavigationBar.appearance().backgroundColor = UIColor(Color("CustomOrange"))
        UITableView.appearance().separatorColor = UIColor.black
        CurrentHive = InputHive
        
        _QueenChange = State(initialValue: CurrentHive.QueenChange)
        _HiveName = State(initialValue: CurrentHive.HiveName)
        _RoyalCellInserted = State(initialValue: CurrentHive.RoyalCellInserted)
        _QueenInserted = State(initialValue: CurrentHive.QueenInserted)
        _OrphanHive = State(initialValue: CurrentHive.OrphanHive)
        _LastNourishedDay = State(initialValue: CurrentHive.LastNourishedDay)
        _NextNutritionDay = State(initialValue: CurrentHive.NextNutritionDay)
        _SwarmPickedUp = State(initialValue: CurrentHive.SwarmPickedUp)
        _LoomsInside = State(initialValue: CurrentHive.LoomsInside)
        _HiveDiagram = State(initialValue: CurrentHive.HiveDiagram)
        
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
            GeneralInformationHiveView(LoomsInside: $LoomsInside, HiveDiagram: $HiveDiagram,HiveName: $HiveName)
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
                        var hiveToSave=Hive(QueenChange, RoyalCellInserted, QueenInserted, OrphanHive, LoomsInside, HiveDiagram, LastNourishedDay, NextNutritionDay, SwarmPickedUp, HiveName)
                        hiveToSave.id = CurrentHive.id
                        var newArrayHives = LoadArrayOfHives(keyToFind: "ArrayOfHives")
                        if (NewView == false){
                            let index = HivesList.items.firstIndex(where: {$0.id == CurrentHive.id})
                            if(index != nil){HivesList.items.remove(at:index!)}
                            RemoveHives(keyToRemove: CurrentHive.id.uuidString)
                            saveHive(hiveToSave: hiveToSave, InputKey: CurrentHive.id.uuidString)
                        }else{
                            saveHive(hiveToSave: hiveToSave, InputKey: CurrentHive.id.uuidString)}
                        CurrentHive = hiveToSave
                        HivesList.items.append(hiveToSave)
                        RemoveHives(keyToRemove: "ArrayOfHives")
                        newArrayHives = HivesList.items
                        saveArrayOfHives(myArray: newArrayHives, keyToFind: "ArrayOfHives")
                        self.presentationMode.wrappedValue.dismiss()
                    }label: {
                        Label("Confirm",systemImage: "checkmark").labelStyle(.iconOnly).accentColor(Color.black)
                    }.disabled(HiveName.isEmpty)
                }
            }).navigationTitle(HiveName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }}

struct GeneralInformationHiveView: View {
    @Binding var LoomsInside: Int
    @Binding var HiveDiagram: Bool
    @Binding var HiveName: String
    var body: some View {
        Section(header:HStack{
            Image(systemName: "archivebox.fill")
            Text("General information")
        }){
            customTextInput(stringToDisplay: "Hive Name", valueNeeded: $HiveName)
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

