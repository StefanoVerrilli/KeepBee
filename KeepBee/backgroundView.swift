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
            Image("background-1")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}
