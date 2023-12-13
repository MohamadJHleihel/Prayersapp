//
//  Functions.swift
//  Prayersapp
//
//  Created by Mohamad Hleihel on 2023-11-17.
//

import Foundation
class PrayerTimesService {
    func fetchPrayerTimes(date: Date, address: String, method: Int, completion: @escaping (Result<PrayerTimings, Error>) -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateString = formatter.string(from: date)
        
        let urlString = "https://api.aladhan.com/v1/timingsByAddress/\(dateString)?address=\(address)&method=\(method)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data found"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(PrayerTimings.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
