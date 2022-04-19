import Foundation

struct Hive:Identifiable,Codable,Equatable{
    

    var id = UUID()
    
    var hiveName:String = "New Hive"
    
    var hiveWheight: String = ""

    var queenChange:Date = Date()

    var royalCellInserted:Date = Date()

    var queenInserted:Date = Date()

    var orphanHive:Bool = false

    var loomsInside: Int = 4

    var hiveDiagram: Bool = false

    var lastNourishedDay:Date = Date()

    var nextNutritionDay:Date = Date()

    var swarmPickedUp:Date = Date()
    
    init(_ QueenChange: Date, _ RoyalCellInserted: Date, _ QueenInserted: Date, _ OrphanHive: Bool, _ LoomInside: Int, _ HiveDiagram: Bool, _ LastNourishedDay: Date, _ NextNutritionDay: Date, _ SwarmPickedUp: Date , _ HiveName: String, _ HiveWheight: String){

            self.hiveName = HiveName
        
            self.hiveWheight = HiveWheight
        
            self.queenChange = QueenChange

            self.royalCellInserted = RoyalCellInserted

            self.queenInserted = QueenInserted

            self.orphanHive = OrphanHive

            self.loomsInside = LoomInside

            self.hiveDiagram = HiveDiagram

            self.lastNourishedDay = LastNourishedDay

            self.nextNutritionDay = NextNutritionDay

            self.swarmPickedUp = SwarmPickedUp

        }
    init(){
        self.hiveName = ""
    
        self.queenChange = Date()

        self.royalCellInserted = Date()

        self.queenInserted = Date()

        self.orphanHive = false

        self.loomsInside = 1

        self.hiveDiagram = false

        self.lastNourishedDay = Date()

        self.nextNutritionDay = Date()

        self.swarmPickedUp = Date()
    }
    
    public static func ==(lhive: Hive, rhive: Hive) -> Bool{
            return
        lhive.hiveName == rhive.hiveName &&
        lhive.hiveWheight == rhive.hiveWheight &&
        lhive.queenInserted == rhive.queenInserted &&
        lhive.swarmPickedUp == rhive.swarmPickedUp &&
        lhive.hiveDiagram == rhive.hiveDiagram &&
        lhive.orphanHive == rhive.orphanHive &&
        lhive.lastNourishedDay == rhive.lastNourishedDay &&
        lhive.loomsInside == rhive.loomsInside &&
        lhive.nextNutritionDay == rhive.nextNutritionDay &&
        lhive.queenChange == rhive.queenChange &&
        lhive.royalCellInserted == rhive.royalCellInserted
        }

}

