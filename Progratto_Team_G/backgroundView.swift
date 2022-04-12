//
//  backgroundView.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 10/04/22.
//

import Foundation
import SwiftUI

struct BackgroundView: View{
    var body: some View{
//        ZStack{
//            Color(red: 251/255, green: 230/255, blue: 155/255)
//            Image("Background").scaledToFit().edgesIgnoringSafeArea(.top)
//        }
        
        Image("hexagonalBackground")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
        
    }
}
