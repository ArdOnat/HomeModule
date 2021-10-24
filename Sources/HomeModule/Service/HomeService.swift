//
//  HomePageService.swift
//
//
//  Created by Arda Onat on 20.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import CoreModule

public protocol HomeApi {
    func fetchWeatherDataWithCityName(cityName: String, completion: @escaping (Result<WeatherInformationResponse, NetworkError>) -> Void)
    func fetchWeatherDataWithCoordinates(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherInformationResponse, NetworkError>) -> Void)
}

final class HomeService: HomeServiceProtocol {
    
    let homeApi: HomeApi
    var output: HomeServiceOutputProtocol?
    
    init(homeApi: HomeApi) {
        self.homeApi = homeApi
    }
    
    func fetchWeatherData(cityName: String) {
        homeApi.fetchWeatherDataWithCityName(cityName: cityName) { result in
            switch result {
            case .success(let response):
                self.output?.onFetchWeatherInformationSuccess(response: response)
            case .failure(let error):
                self.output?.onFetchWeatherInformationFailure(error: error)
            }
        }
    }

    func fetchWeatherData(latitude: Double, longitude: Double) {
        homeApi.fetchWeatherDataWithCoordinates(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let response):
                self.output?.onFetchWeatherInformationSuccess(response: response)
            case .failure(let error):
                self.output?.onFetchWeatherInformationFailure(error: error)
            }
        }
    }
}

extension WeakRef: HomeServiceOutputProtocol where T: HomeServiceOutputProtocol {
    
    func onFetchWeatherInformationSuccess(response: WeatherInformationResponse) {
        object?.onFetchWeatherInformationSuccess(response: response)
    }
    
    func onFetchWeatherInformationFailure(error: Error) {
        object?.onFetchWeatherInformationFailure(error: error)
    }
}
