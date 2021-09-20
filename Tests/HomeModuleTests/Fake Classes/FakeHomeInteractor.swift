//
//  FakeHomeModuleInteractor.swift
//  WeatherApp
//
//  Created by Arda Onat on 18.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import HomeModule

class FakeHomeInteractor: HomeInteractorProtocol {
    var service: HomeServiceProtocol
    
    // MARK: - Properties
    var output: HomeInteractorOutputProtocol?
    
    // MARK: - Test Properties
    var didFetchWeatherDataWithCityNameCalled: Bool = false
    var didFetchWeatherDataWithCoordinatesCalled: Bool = false
    
    // MARK: - Initializers
    init() {
        self.service = FakeHomeService()
        self.output = FakeHomeInteractorOutput()
    }
    
    func fetchWeatherData(with cityName: String) {
        self.didFetchWeatherDataWithCityNameCalled = true
    }
    
    func fetchWeatherData(latitude: Double, longitude: Double) {
        self.didFetchWeatherDataWithCoordinatesCalled = true
    }
    
    // MARK: - Helpers
    func resetFlags() {
        self.didFetchWeatherDataWithCityNameCalled = false
        self.didFetchWeatherDataWithCoordinatesCalled = false
    }
}
