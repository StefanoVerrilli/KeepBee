//
//  AlternativeHiveDetail.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 10/04/22.
//

import Foundation
import SwiftUI
//import ParthenoKit

var myInformations = LoadHive(keyToFind: "MyHives")
var MyHive = myInformations
var Hives = LoadHivesArray(keyToFind: "HivesArray")

struct AlternativeHiveDetail: View{
    init(){
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().barTintColor = UIColor(Color("CustomOrange"))
        UINavigationBar.appearance().backgroundColor = UIColor(Color("CustomOrange"))
        UITableView.appearance().separatorColor = UIColor.black
        }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var navigateBack = false
    @State private var HiveName:String = MyHive.HiveName
    @State private var QueenChange = MyHive.QueenChange
    @State private var RoyalCellInserted = MyHive.RoyalCellInserted
    @State private var QueenInserted = MyHive.QueenInserted
    @State private var OrphanHive: Bool = MyHive.OrphanHive
    @State private var LastNourishedDay:Date = MyHive.LastNourishedDay
    @State private var NextNutritionDay:Date = MyHive.NextNutritionDay
    @State private var SwarmPickedUp:Date = MyHive.SwarmPickedUp
    @State private var LoomsInside: Int = MyHive.LoomsInside
    @State private var HiveDiagram: Bool = MyHive.HiveDiagram
    @State var CurrentHive: Hive? = nil
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
                        var myhive=Hive(QueenChange, RoyalCellInserted, QueenInserted, OrphanHive, LoomsInside, HiveDiagram, LastNourishedDay, NextNutritionDay, SwarmPickedUp, HiveName)
                        myhive.id = MyHive.id
                        if !Hives.isEmpty{
                            let index = Hives.firstIndex(where: {$0.id == MyHive.id})
                            Hives.remove(at:index!)
                        }
                        RemoveHives(keyToRemove: "MyHives")
                        saveHive(myHive: myhive, InputKey: "MyHives")
                        Hives.append(myhive)
                        MyHive = myhive
                        saveHivesArray(myArray: Hives, keyToFind: "HivesArray")
                        self.presentationMode.wrappedValue.dismiss()
                    }label: {
                        Label("Confirm",systemImage: "checkmark").labelStyle(.iconOnly).accentColor(Color.black)
                    }.disabled(HiveName.isEmpty)
                }
            }).navigationTitle(MyHive.HiveName)
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

