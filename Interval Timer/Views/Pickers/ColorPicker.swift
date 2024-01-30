//
//  ColorPicker.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/30/24.
//

import SwiftUI

struct ColorPicker: View {
    @Binding var selection: Theme
    var body: some View {
        Picker("Color", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                Text("     ")
                    .background(theme.mainColor)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .tag(theme)
            }
        }
        .pickerStyle(.wheel)
    }
}

#Preview {
    ColorPicker(selection: .constant(.blue))
}
