//
//  Struct.swift
//  Prayersapp
//
//  Created by Mohamad Hleihel on 2023-11-17.
//



struct PrayerTimings: Codable {
    let data: TimingsData
}

struct TimingsData: Codable {
    let timings: Timings
}

struct Timings: Codable {
    let Fajr: String
    let Sunrise: String
    let Dhuhr: String
    let Asr: String
    let Sunset: String
    let Maghrib: String
    let Isha: String
    let Imsak: String
    let Midnight: String
}
