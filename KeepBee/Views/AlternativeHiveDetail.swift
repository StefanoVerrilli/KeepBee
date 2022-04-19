import Foundation
import SwiftUI


struct AlternativeHiveDetail: View{
    var defaultHive: Hive
    private var newView: Bool
    @State private var queenChange: Date
    @State private var royalCellInserted: Date
    @State private var queenInserted: Date
    @State private var orphanHive: Bool
    @State private var lastNourishedDay:Date
    @State private var nextNutritionDay:Date
    @State private var swarmPickedUp:Date
    @State private var loomsInside: Int
    @State private var hiveDiagram: Bool
    @State private var hiveWheight: String
    @State private var hiveName:String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var globalList: ObservableList
    init(InputHive: Hive,MyPersonalList: ObservableList){
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor : UIColor(Color("CustomBlack"))]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor(Color("CustomBlack"))]
        navBarAppearance.backgroundColor = UIColor(Color("CustomOrange"))
        navBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().barTintColor = UIColor(Color("CustomOrange"))
        UINavigationBar.appearance().tintColor = UIColor(Color("CustomBlack"))
        
        defaultHive = InputHive
        
        _queenChange = State(initialValue: InputHive.queenChange)
        _hiveName = State(initialValue: InputHive.hiveName)
        _hiveWheight = State(initialValue: InputHive.hiveWheight)
        _royalCellInserted = State(initialValue: InputHive.royalCellInserted)
        _queenInserted = State(initialValue: InputHive.queenInserted)
        _orphanHive = State(initialValue: InputHive.orphanHive)
        _lastNourishedDay = State(initialValue: InputHive.lastNourishedDay)
        _nextNutritionDay = State(initialValue: InputHive.nextNutritionDay)
        _swarmPickedUp = State(initialValue: InputHive.swarmPickedUp)
        _loomsInside = State(initialValue: InputHive.loomsInside)
        _hiveDiagram = State(initialValue: InputHive.hiveDiagram)
        
        globalList = MyPersonalList
        newView = false
        }
    
    init(MyPersonalList: ObservableList){
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor : UIColor(Color("CustomBlack"))]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor : UIColor(Color("CustomBlack"))]
        navBarAppearance.backgroundColor = UIColor(Color("CustomOrange"))
        navBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().barTintColor = UIColor(Color("CustomOrange"))
        UINavigationBar.appearance().tintColor = UIColor(Color("CustomBlack"))
        
        defaultHive = Hive()
        
        _queenChange = State(initialValue: defaultHive.queenChange)
        _hiveName = State(initialValue: defaultHive.hiveName)
        _hiveWheight = State(initialValue: defaultHive.hiveWheight)
        _royalCellInserted = State(initialValue: defaultHive.royalCellInserted)
        _queenInserted = State(initialValue: defaultHive.queenInserted)
        _orphanHive = State(initialValue: defaultHive.orphanHive)
        _lastNourishedDay = State(initialValue: defaultHive.lastNourishedDay)
        _nextNutritionDay = State(initialValue: defaultHive.nextNutritionDay)
        _swarmPickedUp = State(initialValue: defaultHive.swarmPickedUp)
        _loomsInside = State(initialValue: defaultHive.loomsInside)
        _hiveDiagram = State(initialValue: defaultHive.hiveDiagram)
        
        globalList = MyPersonalList
        newView = true
        }
    
    @State private var navigateBack = false
    var body: some View{
        NavigationView{
        Form{
            generalInformationHiveView(loomsInside: $loomsInside, hiveDiagram: $hiveDiagram,hiveName: $hiveName,hiveWheight: $hiveWheight)
            hiveHealthView(firstDate: $lastNourishedDay, secondDate: $nextNutritionDay, thirdDate: $swarmPickedUp)
            queenBeeDetailsView(queenChange: $queenChange, royalCellInserted: $royalCellInserted, queenInserted: $queenInserted, isHorphan: $orphanHive)
        }.background(BackgroundView())
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        self.presentationMode.wrappedValue.dismiss()
                    }label: {
                        Label("cancel",systemImage: "xmark").labelStyle(.iconOnly)
                            .foregroundColor(Color("CustomBlack"))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        navigateBack = true
                        var hiveToSave=Hive(queenChange, royalCellInserted, queenInserted, orphanHive, loomsInside, hiveDiagram, lastNourishedDay, nextNutritionDay, swarmPickedUp, hiveName,hiveWheight)
                        hiveToSave.id = defaultHive.id
                        if (newView == false){
                            if hiveToSave == defaultHive{self.presentationMode.wrappedValue.dismiss()}
                            let index = globalList.items.firstIndex(where: {$0.id == defaultHive.id})
                            if(index != nil){globalList.items.remove(at:index!)}
                            SaveFiles(HiveToSave: hiveToSave, KeyToInsert: defaultHive.id.uuidString)
                        }else{
                            SaveFiles(HiveToSave: hiveToSave, KeyToInsert: defaultHive.id.uuidString)
                        }
                        globalList.items.insert(hiveToSave, at: 0)
                        SaveArrayOfHives(HivesToSave: globalList.items)
                        self.presentationMode.wrappedValue.dismiss()
                    }label: {
                        Label("Confirm",systemImage: "checkmark").labelStyle(.iconOnly).accentColor(Color("CustomBlack"))
                    }.disabled(hiveName.isEmpty || (globalList.items.filter{hiveName.range(of: $0.hiveName,options: .caseInsensitive) != nil}.count == 1 && newView == true))
                }
            }).navigationTitle(hiveName).foregroundColor(Color("CustomBlack"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct generalInformationHiveView: View {
    @Binding var loomsInside: Int
    @Binding var hiveDiagram: Bool
    @Binding var hiveName: String
    @Binding var hiveWheight: String
    var body: some View {
        Section(header:HStack{
            Image(systemName: "archivebox.fill").foregroundColor(Color("CustomBlack"))
            Text("General information").foregroundColor(Color("CustomBlack"))
        }){
            alternativeTextInput(stringToDisplay: "Hive Name", valueNeeded: $hiveName)
            alternativeTextInput(stringToDisplay: "Hive Wheight", valueNeeded: $hiveWheight)
            CustomPicker(stringToDisplay: "Looms inside", pickerValue: $loomsInside)
            CustomToggle(toggleVar: $hiveDiagram, stringToDisplay: "Hive Diagram")
        }
    }
}

struct queenBeeDetailsView: View {
    @Binding var queenChange:Date
    @Binding var royalCellInserted:Date
    @Binding var queenInserted:Date
    @Binding var isHorphan:Bool
    var body: some View {
        Section(header:HStack{
            Image(systemName: "crown.fill").foregroundColor(Color("CustomBlack"))
            Text("Queen bee details").foregroundColor(Color("CustomBlack"))
        }){
            CustomToggle(toggleVar: $isHorphan,stringToDisplay: "Orphan: ")
            CustomDatePicker(dateToTrack: $royalCellInserted, stringToDisplay: "Royal cell inserted")
            CustomDatePicker(dateToTrack: $queenChange,stringToDisplay: "Need to be changed")
            CustomDatePicker(dateToTrack: $queenInserted,stringToDisplay: "Queen inserted")
        }
    }
    
}

struct hiveHealthView: View {
    @Binding var firstDate:Date
    @Binding var secondDate:Date
    @Binding var thirdDate:Date
    var body: some View {
        Section(header:HStack{
            Image(systemName: "heart.fill").foregroundColor(Color("CustomBlack"))
            Text("Hive Health").foregroundColor(Color("CustomBlack"))
        }){
            CustomDatePicker(dateToTrack: $firstDate, stringToDisplay: "Last nourished day")
            CustomDatePicker(dateToTrack: $secondDate, stringToDisplay: "Next nutrition day")
            CustomDatePicker(dateToTrack: $thirdDate, stringToDisplay: "Swarm picked up")
        }.accentColor(Color("CustomBlack"))
    }
}

