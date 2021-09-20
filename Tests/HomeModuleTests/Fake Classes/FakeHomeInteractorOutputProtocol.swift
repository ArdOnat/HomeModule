//
//  FakeHomeModuleInteractorOutput.swift
//  WeatherApp
//
//  Created by Arda Onat on 18.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import HomeModule

import Foundation

class FakeHomeInteractorOutput: HomeInteractorOutputProtocol {
    
    // MARK: - Test Properties
    var didOnFetchWeatherInformationSuccessCalled: Bool = false
    var didOnFetchWeatherInformationFailureCalled: Bool = false
    
    // MARK: - Initializer
    init() {
        
    }
    
    func onFetchWeatherInformationSuccess(weatherInformationList: [[CountryWeatherInformationModel]], cityName: String) {
        self.didOnFetchWeatherInformationSuccessCalled = true
    }
    
    func onFetchWeatherInformationFailure(errorMessage: String) {
        self.didOnFetchWeatherInformationFailureCalled = true
    }
    
    // MARK: - Helpers
    func resetFlags() {
        self.didOnFetchWeatherInformationSuccessCalled = false
        self.didOnFetchWeatherInformationFailureCalled = false
    }
}
