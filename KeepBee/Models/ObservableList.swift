
import Foundation


class ObservableList: ObservableObject{
    init(){
        self.items = LoadHivesKey(keyToFind: "HivesKey")
    }
    @Published var items = LoadHivesKey(keyToFind: "HivesKey")
}
