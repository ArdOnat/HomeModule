//
//  FakeHomeModuleService.swift
//  WeatherApp
//
//  Created by Arda Onat on 18.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import HomeModule

class FakeHomeService: HomeServiceProtocol {
   
    // MARK: - Properties
    var homeApi: HomeApi
    var output: HomeServiceOutputProtocol?
    
    // MARK: - Test Properties
    var didFetchWeatherDataWithCityNameCalled: Bool = false
    var didFetchWeatherDataWithCoordinatesCalled: Bool = false
    
    // MARK: - Initializer
    init() {
        homeApi = LocalApiClient()
    }
    
    func fetchWeatherData(cityName: String) {
        self.didFetchWeatherDataWithCityNameCalled = true
        homeApi.fetchWeatherDataWithCityName(cityName: cityName) {
            result in
            switch result {
            case .success(let response):
                self.output?.onFetchWeatherInformationSuccess(response: response)
            case .failure(let error):
                self.output?.onFetchWeatherInformationFailure(error: error)
            }
        }
    }
    
    func fetchWeatherData(latitude: Double, longitude: Double) {
        self.didFetchWeatherDataWithCoordinatesCalled = true
        homeApi.fetchWeatherDataWithCoordinates(latitude: latitude, longitude: longitude) { [self]
            result in
            switch result {
            case .success(let response):
                self.output?.onFetchWeatherInformationSuccess(response: response)
            case .failure(let error):
                self.output?.onFetchWeatherInformationFailure(error: error)
            }
        }
    }
    
    // MARK: - Helpers
    func resetFlags() {
        self.didFetchWeatherDataWithCityNameCalled = false
        self.didFetchWeatherDataWithCoordinatesCalled = false
    }
}
