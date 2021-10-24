//
//  HomeModuleInteractorTests.swift
//  WeatherApp
//
//  Created by Arda Onat on 18.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import HomeModule

import XCTest

class HomeInteractorTests: XCTestCase {

    // MARK: - Properties
    var interactor: HomeInteractorProtocol!
    
    let fakeService = FakeHomeService()
    let fakeInteractorOutput = FakeHomeInteractorOutput()
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        
        interactor = HomeInteractor(service: fakeService)
        fakeService.output = interactor as? HomeServiceOutputProtocol
    }
    
    override func tearDown() {
        super.tearDown()
        fakeInteractorOutput.resetFlags()
        fakeService.resetFlags()
    }
    
    // MARK: - Tests
    
    func testDidFetchWeatherDataWithCityNameAndPassData() {
        interactor.output = fakeInteractorOutput
        interactor.fetchWeatherData(with: "CityName")
        
        // Service receives the request
        
        XCTAssertTrue(fakeService.didFetchWeatherDataWithCityNameCalled)
        XCTAssertFalse(fakeService.didFetchWeatherDataWithCoordinatesCalled)
        
        // Service returns the response and interactor passes to interactor ouput
        
        XCTAssertTrue(fakeInteractorOutput.didOnFetchWeatherInformationSuccessCalled)
    }
    
    func testDidFetchWeatherDataWithCoordinatesAndPassData() {
        interactor.output = fakeInteractorOutput
        interactor.fetchWeatherData(latitude: 30, longitude: 30)
        
        // Service receives the request
       
        XCTAssertFalse(fakeService.didFetchWeatherDataWithCityNameCalled)
        XCTAssertTrue(fakeService.didFetchWeatherDataWithCoordinatesCalled)
        
        // Service returns the response and interactor passes to interactor ouput
        
        XCTAssertTrue(fakeInteractorOutput.didOnFetchWeatherInformationSuccessCalled)
    }
    
    func testDidSetCorrectPresenterCityName() {
        let realPresenter = HomePresenter(interactor: FakeHomeInteractor(), wireframe: FakeHomeWireframe())
        interactor.output = realPresenter
        
        interactor.fetchWeatherData(with: "CityName")
        
        XCTAssertEqual(realPresenter.cityName, "CityName")
    }
    
    func testDidSetCorrectWeatherInformationList() {
        let realPresenter = HomePresenter(interactor: interactor, wireframe: FakeHomeWireframe())
        interactor.output = realPresenter
        
        interactor.fetchWeatherData(with: "CityName")
        
        XCTAssertTrue(!realPresenter.weatherInformationList.isEmpty)
    }
}
