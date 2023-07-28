//
//  Style.swift
//  Swift Weather App
//
//  Created by Cameron Robinson on 7/28/23.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder func applyShadow() -> some View {
        self.shadow(radius: 1, x: 2, y: 2)
    }
}
