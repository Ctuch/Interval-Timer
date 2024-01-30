//
//  SoundPicker.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/30/24.
//

import SwiftUI

struct SoundPicker: View {
    @Binding var selection: Interval.Sound
    var body: some View {
        Picker("Sound", selection: $selection) {
            ForEach(Interval.Sound.allCases, id: \.self) { sound in
                Text(sound.rawValue)
                    .tag(sound)
            }
        }
        .pickerStyle(.wheel)
    }
}

#Preview {
    SoundPicker(selection: .constant(.ring))
}
