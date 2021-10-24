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
    
    func testSearchBarButtonClickedCallsSearchButtonClicked() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        sut.setupSearchBar()
        
        // When
        sut.searchBar.delegate?.searchBarSearchButtonClicked?(sut.searchBar)
        
        // Then
        XCTAssertTrue(homePresenterSpy.didSearchbarSearchButtonClickedCalled)
    }
    
    func testTableViewRendersNoCellDataWithZeroWeatherInformation() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [], cityName: "2021-06-20")
        let sut = makeSUT(presenter: &homePresenterSpy)
        sut.setupTableView()
        
        // When
        sut.changeViewState(.success)
        
        // Then
        XCTAssertEqual(0, sut.resultTableView.numberOfRows(inSection: 0))
    }
    
    func testTableViewRendersOneDataWithOneWeatherInformation() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        sut.setupTableView()
        
        // When
        sut.changeViewState(.success)
        
        // Then
        XCTAssertEqual(1, sut.resultTableView.numberOfRows(inSection: 0))
    }
    
    func testTableViewRendersCellDateLabelText() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        sut.setupTableView()
        
        // When
        let cell: WeatherInformationUITableViewCell = sut.resultTableView.cell(at: 0) as! WeatherInformationUITableViewCell
        
        // Then
        XCTAssertEqual("2021-06-20", cell.dateLabel.text)
    }
    
    func testCollectionViewInsideTableViewCellRendersOneOptionWithOneWeatherInformation() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        sut.setupTableView()
        
        // When
        let cell: WeatherInformationUITableViewCell = sut.resultTableView.cell(at: 0) as! WeatherInformationUITableViewCell
        
        // Then
        XCTAssertEqual(1, cell.hoursCollectionView.numberOfItems(inSection: 0))
    }
    
    func testCollectionViewInsideTableViewCellRendersHourLabel() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        sut.setupTableView()
        
        // When
        let tableViewCell: WeatherInformationUITableViewCell = sut.resultTableView.cell(at: 0) as! WeatherInformationUITableViewCell
        let collectionViewCell: HourlyDataCollectionViewCell = tableViewCell.hoursCollectionView.item(at: 0) as! HourlyDataCollectionViewCell
        
        // Then
        XCTAssertEqual("15", collectionViewCell.hourLabel.text)
    }
    
    func testCollectionViewInsideTableViewCellRendersHighTemperatureLabel() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        sut.setupTableView()
        
        // When
        let tableViewCell: WeatherInformationUITableViewCell = sut.resultTableView.cell(at: 0) as! WeatherInformationUITableViewCell
        let collectionViewCell: HourlyDataCollectionViewCell = tableViewCell.hoursCollectionView.item(at: 0) as! HourlyDataCollectionViewCell
        
        // Then
        XCTAssertEqual("11.0", collectionViewCell.highTemperatureLabel.text)
    }
    
    func testCollectionViewInsideTableViewCellRendersLowTemperatureLabel() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        sut.setupTableView()
        
        // When
        let tableViewCell: WeatherInformationUITableViewCell = sut.resultTableView.cell(at: 0) as! WeatherInformationUITableViewCell
        let collectionViewCell: HourlyDataCollectionViewCell = tableViewCell.hoursCollectionView.item(at: 0) as! HourlyDataCollectionViewCell
        
        // Then
        XCTAssertEqual("10.0", collectionViewCell.lowTemperatureLabel.text)
    }
    
    func testScrollViewDidScroll() {
        // Given
        var homePresenterSpy: FakeHomePresenter = FakeHomePresenter(weatherInformationList: [fetchMockData()!.list], cityName: fetchMockData()!.city.name)
        let sut = makeSUT(presenter: &homePresenterSpy)
        sut.setupTableView()
        
        // When
        sut.scrollViewDidScroll(sut.resultTableView)
        
        // Then
        XCTAssertTrue(homePresenterSpy.didScrollViewDidScrollCalled)
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

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func select(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        selectRow(at: indexPath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: indexPath)
    }
}

private extension UICollectionView {
    func item(at row: Int) -> UICollectionViewCell? {
        return dataSource?.collectionView(self, cellForItemAt: IndexPath(row: row, section: 0))
    }
}
