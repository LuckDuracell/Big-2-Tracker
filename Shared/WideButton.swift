//
//  WideButton.swift
//  Big 2 Tracker
//
//  Created by Luke Drushell on 5/31/21.
//

import SwiftUI

struct WideButton: View {
    
    var text: String
    var textColor: Color
    var backgroundColor: Color
    
    
    var body: some View {
        Text(text)
            .frame(width: UIScreen.main.bounds.width * 0.7466, height: 0.1333 * UIScreen.main.bounds.width)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(10)
    }
}
