//
//  HomeModuleServiceTests.swift
//  WeatherApp
//
//  Created by Arda Onat on 18.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import HomeModule

import XCTest
import CoreModule

class HomeServiceTests: XCTestCase {
    
    // MARK: - Properties
    var service: HomeServiceProtocol!
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        
        service = HomeService(homeApi: LocalApiClient())
        service.output = FakeHomeServiceOutputProtocol()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testFetchWeatherDataWithCityNameIsSuccessful() {
        service.fetchWeatherData(cityName: "")
        
        let output = service.output as! FakeHomeServiceOutputProtocol
        
        XCTAssertTrue(output.didOnFetchWeatherInformationSuccessCalled)
        XCTAssertFalse(output.didOnFetchWeatherInformationFailureCalled)
    }
    
    func testFetchWeatherDataWithCoordinatesIsSuccessful() {
        service.fetchWeatherData(latitude: 30, longitude: 30)
        
        let output = service.output as! FakeHomeServiceOutputProtocol
        
        XCTAssertTrue(output.didOnFetchWeatherInformationSuccessCalled)
        XCTAssertFalse(output.didOnFetchWeatherInformationFailureCalled)
    }
}
