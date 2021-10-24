//
//  WeatherInformationResponse.swift
//  WeatherApp
//
//  Created by Arda Onat on 20.08.2021.
//

import Foundation

public struct WeatherInformationResponse: Codable {
    let list: [CountryWeatherInformation]
    let city: CityInformation
}

public struct CountryWeatherInformation: Codable {
    let main: Mainformation
    let weather: [WeatherInformation]
    let dt_txt: String
}

public struct Mainformation: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

public struct WeatherInformation: Codable {
    let main: String
    let icon: String
}

public struct CityInformation: Codable {
    let name: String
}
