//
//  HomeModuleViewTests.swift
//  WeatherApp
//
//  Created by Arda Onat on 18.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import HomeModule
import CoreModule

import XCTest

class HomeViewTests: XCTestCase {
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()

    }
    // MARK: - Tests
    func testInitFromCoder() {
        let view = HomeViewController(coder: NSCoder())
        XCTAssertNil(view)
    }
    
    func testLocationNameLabelText() {
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = self.makeSUT(presenter: &homePresenterSpy)
        _ = sut.view
        sut.changeViewState(.success)
        XCTAssertEqual("CityName", sut.locationNameLabel.text)
    }
    
    func testLocationWeatherInformationLabelText() {
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = self.makeSUT(presenter: &homePresenterSpy)
        _ = sut.view
        sut.changeViewState(.success)
        XCTAssertEqual("NA", sut.locationWeatherInformationLabel.text)
    }
    
    func testNumberOfRowsInTableView() {
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = self.makeSUT(presenter: &homePresenterSpy)
        _ = sut.view
        sut.changeViewState(.success)
        XCTAssertEqual(0, sut.resultTableView.numberOfRows(inSection: 0))
    }
    
    func testCurrentTemperatureLabelText() {
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = self.makeSUT(presenter: &homePresenterSpy)
        _ = sut.view
        sut.changeViewState(.success)
        XCTAssertEqual("10.0", sut.currentTemperatureLabel.text)
    }
    
    func testLowTemperatureLabelText() {
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = self.makeSUT(presenter: &homePresenterSpy)
        _ = sut.view
        sut.changeViewState(.success)
        XCTAssertEqual("10.0", sut.lowTemperatureLabel.text)
    }
    
    func testHighTemperatureLabelText() {
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = self.makeSUT(presenter: &homePresenterSpy)
        _ = sut.view
        sut.changeViewState(.success)
        XCTAssertEqual("11.0", sut.highTemperatureLabel.text)
    }
    
    func testHumidityLabelText() {
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = self.makeSUT(presenter: &homePresenterSpy)
        _ = sut.view
        sut.changeViewState(.success)
        XCTAssertEqual("12.0", sut.humidityLabel.text)
    }
    
    private func fetchMockData() -> WeatherInformationResponseModel? {
        var model: WeatherInformationResponseModel? = nil
        
        LocalApiClient().fetchWeatherDataWithCityName(cityName:  "") { result in
            switch result {
            case .success(let response):
                model = response
            case .failure(_):
                fatalError()
            }
         }
        return model
    }
    
    private func makeSUT(presenter: inout FakeHomePresenter) -> HomeViewController {
        let viewController = HomeViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
