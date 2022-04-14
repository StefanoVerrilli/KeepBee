//
//  AlternativeHiveDetail.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 10/04/22.
//

import Foundation
import SwiftUI
//import ParthenoKit

var myInformations = LoadHives(keyToFind: "MyHives")
var MyHive = myInformations[0]

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
    @State private var QueenChange = MyHive.QueenChange
    @State private var RoyalCellInserted = MyHive.RoyalCellInserted
    @State private var QueenInserted = MyHive.QueenInserted
    @State private var OrphanHive: Bool = MyHive.OrphanHive
    @State private var LastNourishedDay:Date = MyHive.LastNourishedDay
    @State private var NextNutritionDay:Date = MyHive.NextNutritionDay
    @State private var SwarmPickedUp:Date = MyHive.SwarmPickedUp
    @State private var LoomsInside: Int = MyHive.LoomsInside
    @State private var HiveDiagram: Bool = MyHive.HiveDiagram
    var body: some View{
        NavigationView{
        Form{
            HiveHealthView(FirstDate: $LastNourishedDay, SecondDate: $NextNutritionDay, ThirdDate: $SwarmPickedUp)
            GeneralInformationHiveView(LoomsInside: $LoomsInside, HiveDiagram: $HiveDiagram)
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
                       let myhive=Hive(QueenChange, RoyalCellInserted, QueenInserted, OrphanHive, LoomsInside, HiveDiagram, LastNourishedDay, NextNutritionDay, SwarmPickedUp)
                        //let hivesToRemove = LoadHives(keyToFind: "MyHives")
                        //var newHives = hivesToRemove
                        //newHives.append(myhive)
                        MyHive = myhive
                        RemoveHives(keyToRemove: "MyHives")
                        let NewArray = [MyHive]
                        save(Hives: NewArray, InputKey: "MyHives")
                        print("new print\n")
                        dump(LoadHives(keyToFind: "MyHives"))
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

