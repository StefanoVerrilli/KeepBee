//
//  Components.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 12/04/22.
//

import Foundation
import SwiftUI

struct CustomDatePicker: View {
    @Binding var dateToTrack: Date
    public var StringToDisplay: String
    var body: some View {
        DatePicker(StringToDisplay,selection: $dateToTrack,displayedComponents: .date)
            .listRowBackground(Color("CustomOrange"))
            .padding(.vertical)
            .datePickerStyle(.compact)
    }
}


struct CustomToggle: View {
    @Binding var toggleVar: Bool
    public var StringToDisplay: String
    var body: some View {
        Toggle(isOn: $toggleVar){
            Text(StringToDisplay)
        }.padding(.vertical)
            .listRowBackground(Color("CustomOrange"))
    }
}

struct customPicker: View {
    public var StringToDisplay: String
    @Binding var pickerValue: Int
    var body: some View {
        Picker(StringToDisplay, selection: $pickerValue) {
            ForEach(0..<10){
                Text("\($0)")
            }
        }.padding(.vertical).listRowBackground(Color("CustomOrange")).foregroundColor(Color.black)
    }
}

struct customTextInput: View{
    public var stringToDisplay: String
    @Binding var valueNeeded: String
    var body: some View{
        TextField("Insert Hive Name", text: $valueNeeded)
            .padding(.vertical)
            .listRowBackground(Color("CustomOrange"))
            .foregroundColor(Color.black)
    }
}

struct AlternativeTextInput: View{
    public var stringToDisplay: String
    @Binding var valueNeeded : String
    var body: some View{
        HStack{
            Text(stringToDisplay)
            Spacer()
            TextField(stringToDisplay,text: $valueNeeded).multilineTextAlignment(.trailing)
        }.padding(.vertical)
            .listRowBackground(Color("CustomOrange"))
            .foregroundColor(Color.black)
    }
}
