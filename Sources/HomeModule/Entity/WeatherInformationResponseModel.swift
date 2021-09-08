//
//  WeatherInformationResponseModel.swift
//  WeatherApp
//
//  Created by Arda Onat on 20.08.2021.
//

import Foundation

public struct WeatherInformationResponseModel: Codable {
    let list: [CountryWeatherInformationModel]
    let city: CityInformationModel
}

public struct CountryWeatherInformationModel: Codable {
    let main: MainformationModel
    let weather: [WeatherInformationModel]
    let dt_txt: String
}

public struct MainformationModel: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

public struct WeatherInformationModel: Codable {
    let main: String
    let icon: String
}

public struct CityInformationModel: Codable {
    let name: String
}
