//
//  Hive.swift
//  Progratto_Team_G
//
//  Created by Gianfranco on 12/04/22.
//

import Foundation



struct Hive:Identifiable{

    let id = UUID()

    var QueenChange:Date = Date()

    var RoyalCellInserted:Date = Date()

    var QueenInserted:Date = Date()

    var OrphanHive:Bool = false

    var LoomsInside: Int = 4

    var HiveDiagram: Bool = false

    var LastNourishedDay:Date = Date()

    var NextNutritionDay:Date = Date()

    var SwarmPickedUp:Date = Date()

}
