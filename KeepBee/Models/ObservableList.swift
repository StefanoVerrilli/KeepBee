
import Foundation


class ObservableList: ObservableObject{
    init(){
        //self.items = LoadHivesKey(keyToFind: "HivesKey")
        self.items = LoadArrayOfHives(keyToInsert: "HivesKey")
    }
    @Published var items = LoadArrayOfHives(keyToInsert: "HivesKey")
}
