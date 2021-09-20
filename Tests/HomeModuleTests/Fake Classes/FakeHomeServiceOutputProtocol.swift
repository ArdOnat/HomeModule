//
//  FakeHomeServiceOutputProtocol.swift
//  
//
//  Created by Arda Onat on 18.09.2021.
//

@testable import HomeModule

import Foundation

class FakeHomeServiceOutputProtocol: HomeServiceOutputProtocol {
    
    // MARK: - Test Properties
    var didOnFetchWeatherInformationSuccessCalled: Bool = false
    var didOnFetchWeatherInformationFailureCalled: Bool = false
    
    // MARK: - Initializer
    init() {
        
    }
    
    func onFetchWeatherInformationSuccess(response: WeatherInformationResponseModel) {
        self.didOnFetchWeatherInformationSuccessCalled = true
    }
    
    func onFetchWeatherInformationFailure(error: Error) {
        self.didOnFetchWeatherInformationFailureCalled = true
    }
    
    // MARK: - Helpers
    func resetFlags() {
        self.didOnFetchWeatherInformationSuccessCalled = false
        self.didOnFetchWeatherInformationFailureCalled = false
    }
}
