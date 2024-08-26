//
//  ContentView.swift
//  Weather
//
//  Created by Hemant on 24/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = manager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView().task {
                        do {
                            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                        } catch {
                            print("Error while getting data \(error)")
                        }
                    }
                }
            } else {
                if manager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView().environmentObject(manager)
                }
            }
        }
        .background(Color(hue: 0.55, saturation: 0.912, brightness: 0.543))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
