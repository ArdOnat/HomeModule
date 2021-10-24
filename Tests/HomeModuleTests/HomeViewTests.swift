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
    
    func testViewDidLoadCallsPresenterViewDidLoad() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        makeSUT(presenter: &homePresenterSpy)
        
        // Then
        XCTAssertTrue(homePresenterSpy.didViewDidLoadCalled)
    }
     
    func testViewDidLayoutSubViewsCallsPresenterDidLayoutSubviews() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut =  makeSUT(presenter: &homePresenterSpy)

        // When
        sut.viewDidLayoutSubviews()
        
        // Then
        XCTAssertTrue(homePresenterSpy.didViewDidLayoutSubviewsCalled)
    }
    
    func testChangeViewStateToFailureSetsUpView() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        
        // When
        sut.changeViewState(.failure(errorMessage: "Error Message"))
        
        // Then
        XCTAssertFalse(sut.searchBar.isHidden)
        XCTAssertTrue(sut.informationView.isHidden)
        XCTAssertTrue(sut.resultTableView.isHidden)
        XCTAssertTrue(sut.resultTableView.isHidden)
    }
    
    func testChangeViewStateToFailureShowsToast() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        
        // When
        sut.changeViewState(.failure(errorMessage: "Error Message"))
        
        // Then
        XCTAssertTrue(homePresenterSpy.didViewSetupCompletedWithFailureCalled)
    }
    
    func testChangeViewStateToLoadingSetsUpView() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        
        // When
        sut.changeViewState(.loading)
        
        // Then
        XCTAssertTrue(sut.searchBar.isHidden)
        XCTAssertTrue(sut.informationView.isHidden)
        XCTAssertTrue(sut.resultTableView.isHidden)
        XCTAssertTrue(sut.resultTableView.isHidden)
    }
    
    func testChangeViewStateToSuccessSetsUpView() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = self.makeSUT(presenter: &homePresenterSpy)
        
        // When
        sut.changeViewState(.success)
        
        // Then
        XCTAssertFalse(sut.searchBar.isHidden)
        XCTAssertFalse(sut.informationView.isHidden)
        XCTAssertFalse(sut.resultTableView.isHidden)
        XCTAssertFalse(sut.resultTableView.isHidden)
    }
    
    func testLocationNameLabelText() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        
        // When
        sut.changeViewState(.success)
        
        // Then
        XCTAssertEqual("CityName", sut.locationNameLabel.text)
    }
    
    func testLocationWeatherInformationLabelText() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        
        // When
        sut.changeViewState(.success)
        
        // Then
        XCTAssertEqual("NA", sut.locationWeatherInformationLabel.text)
    }
    
    func testNumberOfRowsInTableView() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)

        // When
        sut.changeViewState(.success)
        
        // Then
        XCTAssertEqual(0, sut.resultTableView.numberOfRows(inSection: 0))
    }
    
    func testCurrentTemperatureLabelText() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        
        // When
        sut.changeViewState(.success)
        
        // Then
        XCTAssertEqual("10.0", sut.currentTemperatureLabel.text)
    }
    
    func testLowTemperatureLabelText() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        _ = sut.view
        
        // When
        sut.changeViewState(.success)
        
        // Then
        XCTAssertEqual("10.0", sut.lowTemperatureLabel.text)
    }
    
    func testHighTemperatureLabelText() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        
        // When
        sut.changeViewState(.success)
        
        // Then
        XCTAssertEqual("11.0", sut.highTemperatureLabel.text)
    }
    
    func testHumidityLabelText() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        
        // When
        sut.changeViewState(.success)
        
        // Then
        XCTAssertEqual("12.0", sut.humidityLabel.text)
    }
    
    private func fetchMockData() -> WeatherInformationResponse? {
        var model: WeatherInformationResponse? = nil
        
        LocalApiClient().fetchWeatherDataWithCityName(cityName:  "") {
            result in
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
        _ = viewController.view
        presenter.view = viewController
        return viewController
    }
}
