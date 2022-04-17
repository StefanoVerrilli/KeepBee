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
    public var stringToDisplay: String
    var body: some View {
        DatePicker(stringToDisplay,selection: $dateToTrack,displayedComponents: .date)
            .listRowBackground(Color("CustomOrange"))
            .padding(.vertical)
            .datePickerStyle(.compact)
    }
}


struct CustomToggle: View {
    @Binding var toggleVar: Bool
    public var stringToDisplay: String
    var body: some View {
        Toggle(isOn: $toggleVar){
            Text(stringToDisplay)
        }.padding(.vertical)
            .listRowBackground(Color("CustomOrange"))
    }
}

struct CustomPicker: View {
    public var stringToDisplay: String
    @Binding var pickerValue: Int
    var body: some View {
        Picker(stringToDisplay, selection: $pickerValue) {
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

struct alternativeTextInput: View{
    public var stringToDisplay: String
    @Binding var valueNeeded : String
    var body: some View{
        HStack{
            Text(stringToDisplay)
            Spacer()
            TextField(stringToDisplay,text: $valueNeeded).multilineTextAlignment(.trailing).autocapitalization(.none)
        }.padding(.vertical)
            .listRowBackground(Color("CustomOrange"))
            .foregroundColor(Color.black)
    }
}
