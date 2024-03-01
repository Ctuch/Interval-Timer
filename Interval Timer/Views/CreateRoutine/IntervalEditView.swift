//
//  IntervalEditView.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/30/24.
//

import SwiftUI

struct IntervalEditView: View {
    @Binding var interval: Interval
    
    var body: some View {
        List {
            HStack {
                Text("Duration")
                Spacer()
                    .frame(width: 50)
                TimePicker(currentMins: $interval.minutes, currentSecs: $interval.seconds)
            }.frame(height: 150)
            HStack {
                Text("Color")
                Spacer()
                    .frame(width: 80)
                ColorPicker(selection: $interval.color)
            }.frame(height: 100)
            HStack {
                Text("Sound")
                Spacer()
                    .frame(width: 80)
                SoundPicker(selection: $interval.sound)
            }.frame(height: 100)
            HStack {
                Text("Playlist")
                Spacer()
                    .frame(width: 80)
                PlaylistPicker(playlist: $interval.playlist)
            }.frame(height: 100)
        }
    }
}

#Preview {
    IntervalEditView(interval: .constant(Interval.defaultInterval))
}
