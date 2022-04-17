//
//  ObservableList.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 14/04/22.
//

import Foundation


class ObservableList: ObservableObject{
    init(){
        self.items = LoadHivesKey(keyToFind: "HivesKey")
    }
    @Published var items = LoadHivesKey(keyToFind: "HivesKey")
}
