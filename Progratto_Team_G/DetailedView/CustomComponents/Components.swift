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
            .listRowBackground(Color(red: 237/255, green: 194/255, blue: 93/255))
            .padding(.vertical)
            .datePickerStyle(.compact)
    }
    func RetriveDate()-> Date{
        return dateToTrack
    }
}


struct CustomToggle: View {
    @State var toggleVar:Bool = false
    public var StringToDisplay: String
    var body: some View {
        Toggle(isOn: $toggleVar){
            Text(StringToDisplay)
        }.padding(.vertical)
            .listRowBackground(Color(red: 237/255, green: 194/255, blue: 93/255))
    }
    func RetriveBool()-> Bool{
        return toggleVar
    }
}

struct customPicker: View {

    @State private var pickerValue: Int
    var body: some View {
        Picker("Looms inside", selection: $pickerValue) {
            ForEach(0..<10){
                Text("\($0)")
            }
        }.padding(.vertical).listRowBackground(Color(red: 237/255, green: 194/255, blue: 93/255)).foregroundColor(Color.black)
    }
}
