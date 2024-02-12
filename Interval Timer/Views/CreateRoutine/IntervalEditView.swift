//
//  IntervalEditView.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/30/24.
//

import SwiftUI

struct IntervalEditView: View {
    @Binding var interval: Interval
    @Binding var minutes: Int
    @Binding var seconds: Int
    
    var body: some View {
        List {
            HStack {
                Text("Duration")
                Spacer()
                    .frame(width: 50)
                TimePicker(currentMins: $minutes, currentSecs: $seconds)
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
        .onDisappear {
            interval.time = minutes * 60 + seconds
        }
    }
}

#Preview {
    IntervalEditView(interval: .constant(Interval.defaultInterval), minutes: .constant(Interval.defaultInterval.time / 60), seconds: .constant(Interval.defaultInterval.time % 60))
}
