//
//  ContentView.swift
//  Prayersapp
//
//  Created by Mohamad Hleihel on 2023-11-17.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = "Landskrona"
        let city = ["Landskrona", "Malmö", "Lund", "Stockholm", "Kiruna"]

    @State private var prayerTimings: Timings?
    let service = PrayerTimesService()
    
    var currentDate: Date {
        return Date() // Get the current date
    }

    var body: some View {
        VStack{
            Spacer()
            VStack {
                
            }
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/ , height: 100)
            .background(.yellow)
            
        VStack {
            VStack{
                Picker("Select a city", selection: $selection) {
                    ForEach(city, id: \.self) {
                        Text($0)
                        
                        
                    }
                }
                .pickerStyle(.wheel)
            }
            .background(.green)
            if let timings = prayerTimings {
                Spacer()
                Text("Fajr: \(timings.Fajr)")
                Spacer()
                Text("Sunrise: \(timings.Sunrise)")
                Spacer()
                Text("Dhuhr: \(timings.Dhuhr)")
                Spacer()
                Text("Asr: \(timings.Asr)")
                Spacer()
                Text("Sunset: \(timings.Sunset)")
                Spacer()
                Text("Maghrib: \(timings.Maghrib)")
                Spacer()
                Text("Isha: \(timings.Isha)")
                Spacer()
                Text("Midnight: \(timings.Midnight)")
            } else {
                Text("Loading...")
                    .onAppear {
                        fetchPrayerTimes()
                    }
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ , maxHeight: .infinity)
        .background(.blue)
        .onChange(of: selection) { _ in fetchPrayerTimes()}
    }
    }

    func fetchPrayerTimes() {
        service.fetchPrayerTimes(date: currentDate, address: "\(selection), Sweden", method: 8) { result in
            switch result {
            case .success(let prayerTimings):
                DispatchQueue.main.async {
                    self.prayerTimings = prayerTimings.data.timings
                }
            case .failure(let error):
                print("Failed to fetch data: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
