//
//  HomeModulePresenterTests.swift
//  WeatherApp
//
//  Created by Arda Onat on 18.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import HomeModule

import XCTest

class HomePresenterTests: XCTestCase {
    
    // MARK: - Properties
    var presenter: HomePresenterProtocol!
    
    let fakeInteractor = FakeHomeInteractor()
    let fakeWireframe = FakeHomeWireframe()
    let fakeView = FakeHomeView()
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        
        presenter = HomePresenter(interactor: fakeInteractor, wireframe: fakeWireframe)
        presenter.view = fakeView
    }
    
    override func tearDown() {
        super.tearDown()
        
        fakeInteractor.resetFlags()
        fakeWireframe.resetFlags()
        fakeWireframe.resetFlags()
    }
    
    // MARK: - Tests
    func testDidViewDidLoadSetupViewState() {
        presenter.viewDidLoad()
        
        XCTAssertTrue(fakeView.didChangeViewStateCalled)
        XCTAssertTrue(fakeView.didSetupSearchBarCalled)
        XCTAssertTrue(fakeView.didSetupTableViewCalled)
        XCTAssertTrue(fakeView.didSetupGeoLocationCalled)
        XCTAssertTrue(fakeView.didShowActivityIndicatorTrueCalled)
    }
    
    func testDidViewDidLoadSetupActivityIndicator() {
        presenter.viewDidLayoutSubviews()
        
        XCTAssertTrue(fakeView.didSetupActivityIndicatorCalled)
    }
    
    func testDidUpdateLocationsCalledFetchWeatherData() {
        presenter.didUpdateLocations(latitude: 30, longitude: 30)
        
        XCTAssertTrue(fakeInteractor.didFetchWeatherDataWithCoordinatesCalled)
    }
    
    func testDidSearchBarSearchButtonConfiguredView() {
        presenter.didSearchBarSearchButtonClicked(cityName: "CityName")
        
        XCTAssertTrue(fakeView.didChangeViewStateCalled)
        XCTAssertTrue(fakeView.didEndSearchBarEditingCalled)
        XCTAssertTrue(fakeView.didShowActivityIndicatorTrueCalled)
    }
    
    func testDidSearchBarSearchButtonFetchData() {
        presenter.didSearchBarSearchButtonClicked(cityName: "CityName")
        
        XCTAssertTrue(fakeInteractor.didFetchWeatherDataWithCityNameCalled)
    }
    
    func testDidScrollViewScrollCalledEndSearchBarEditing() {
        presenter.scrollViewDidScroll()
        
        XCTAssertTrue(fakeView.didEndSearchBarEditingCalled)
    }
}
