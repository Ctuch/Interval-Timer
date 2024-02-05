//
//  SoundPicker.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/30/24.
//

import SwiftUI

struct SoundPicker: View {
    @Binding var selection: Sound
    var body: some View {
        Picker("Sound", selection: $selection) {
            ForEach(Sound.allCases, id: \.self) { sound in
                Text(sound.name)
                    .tag(sound)
            }
        }
        .pickerStyle(.wheel)
    }
}

#Preview {
    SoundPicker(selection: .constant(.ring))
}
