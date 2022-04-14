//
//  Hive.swift
//  Progratto_Team_G
//
//  Created by Gianfranco on 12/04/22.
//

import Foundation



struct Hive:Identifiable,Codable{
    

    var id = UUID()
    
    var HiveName:String = "New Hive"

    var QueenChange:Date = Date()

    var RoyalCellInserted:Date = Date()

    var QueenInserted:Date = Date()

    var OrphanHive:Bool = false

    var LoomsInside: Int = 4

    var HiveDiagram: Bool = false

    var LastNourishedDay:Date = Date()

    var NextNutritionDay:Date = Date()

    var SwarmPickedUp:Date = Date()
    
    init(_ QueenChange: Date, _ RoyalCellInserted: Date, _ QueenInserted: Date, _ OrphanHive: Bool, _ LoomInside: Int, _ HiveDiagram: Bool, _ LastNourishedDay: Date, _ NextNutritionDay: Date, _ SwarmPickedUp: Date , _ HiveName: String){

            self.HiveName = HiveName
        
            self.QueenChange = QueenChange

            self.RoyalCellInserted = RoyalCellInserted

            self.QueenInserted = QueenInserted

            self.OrphanHive = OrphanHive

            self.LoomsInside = LoomInside

            self.HiveDiagram = HiveDiagram

            self.LastNourishedDay = LastNourishedDay

            self.NextNutritionDay = NextNutritionDay

            self.SwarmPickedUp = SwarmPickedUp

        }
    init(){
        self.HiveName = ""
    
        self.QueenChange = Date()

        self.RoyalCellInserted = Date()

        self.QueenInserted = Date()

        self.OrphanHive = false

        self.LoomsInside = 1

        self.HiveDiagram = false

        self.LastNourishedDay = Date()

        self.NextNutritionDay = Date()

        self.SwarmPickedUp = Date()
    }

}

class HiveData<Hive>: ObservableObject {

    

    @Published var  Hives: [Hive]



    init(Hives: [Hive]) {

        self.Hives = Hives

    }

    init(repeating value: Hive, count: Int) {

         Hives = Array(repeating: value, count: count)

      }



    func addHive(oldHive: Hive){
      Hives.append(oldHive)
       }
    }
