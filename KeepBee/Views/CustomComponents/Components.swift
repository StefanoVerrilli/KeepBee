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
            .colorMultiply(Color("CustomBlack"))
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
            .foregroundColor(Color("CustomBlack"))
            .accentColor(Color("CustomBlack"))
    }
}

struct CustomPicker: View {
    public var stringToDisplay: String
    @Binding var pickerValue: Int
    var body: some View {
        HStack{
            Text(stringToDisplay)
            Spacer()
            Picker(stringToDisplay, selection: $pickerValue) {
                ForEach(0..<10){
                    Text("\($0)")
                }
            }.pickerStyle(.menu).colorMultiply(Color("CustomBlack"))
        }.padding(.vertical).listRowBackground(Color("CustomOrange"))
    }
}

struct alternativeTextInput: View{
    public var stringToDisplay: String
    @Binding var valueNeeded : String
    var body: some View{
        HStack{
            Text(stringToDisplay)
            Spacer()
            TextField(stringToDisplay,text: $valueNeeded).multilineTextAlignment(.trailing).autocapitalization(.none).colorMultiply(Color("CustomBlack"))
        }.padding(.vertical)
            .listRowBackground(Color("CustomOrange"))
            .foregroundColor(Color("CustomBlack"))
            .accentColor(Color("CustomBlack"))
    }
}
