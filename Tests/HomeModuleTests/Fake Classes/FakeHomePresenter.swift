//
//  FakeHomeModulePresenter.swift
//  WeatherApp
//
//  Created by Arda Onat on 18.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import HomeModule

class FakeHomePresenter: HomePresenterProtocol, HomeInteractorOutputProtocol {

    // MARK: - Properties
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol
    var wireframe: HomeNavigation
    var weatherInformationList: [[CountryWeatherInformation]]
    var cityName: String
    
    // MARK: - Test Properties
    var didViewDidLoadCalled: Bool = false
    var didViewDidLayoutSubviewsCalled: Bool = false
    var didUpdateLocationsCalled: Bool = false
    var didSearchbarSearchButtonClickedCalled: Bool = false
    var didScrollViewDidScrollCalled: Bool = false
    var didOnFetchWeatherInformationSuccessCalled: Bool = false
    var didOnFetchWeatherInformationFailureCalled: Bool = false
    var didViewSetupCompletedWithFailureCalled: Bool = false
    
    // MARK: - Initializers
    required init(interactor: HomeInteractorProtocol, wireframe: HomeNavigation) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.weatherInformationList = []
        self.cityName = ""
    }
    
    init(weatherInformationList: [[CountryWeatherInformation]] = [], cityName: String = "") {
        self.interactor = FakeHomeInteractor()
        self.wireframe = FakeHomeWireframe()
        self.weatherInformationList = weatherInformationList
        self.cityName = cityName
    }
    
    func viewDidLoad() {
        self.didViewDidLoadCalled = true
    }
    
    func viewDidLayoutSubviews() {
        self.didViewDidLayoutSubviewsCalled = true
    }
    
    func didUpdateLocations(latitude: Double, longitude: Double) {
        self.didUpdateLocationsCalled = true
    }
    
    func didSearchBarSearchButtonClicked(cityName: String) {
        self.didSearchbarSearchButtonClickedCalled = true
    }
    
    func scrollViewDidScroll() {
        self.didScrollViewDidScrollCalled = true
    }
    
    func onFetchWeatherInformationSuccess(weatherInformationList: [[CountryWeatherInformation]], cityName: String) {
        self.didOnFetchWeatherInformationSuccessCalled = true
    }
    
    func onFetchWeatherInformationFailure(errorMessage: String) {
        self.didOnFetchWeatherInformationFailureCalled = true
    }
    
    func viewSetupCompletedWithFailure(errorMessage: String) {
        didViewSetupCompletedWithFailureCalled = true
    }
    
    // MARK: - Helpers
    func resetFlags() {
        self.didViewDidLoadCalled = false
        self.didViewDidLayoutSubviewsCalled = false
        self.didUpdateLocationsCalled = false
        self.didSearchbarSearchButtonClickedCalled = false
        self.didScrollViewDidScrollCalled = false
        self.didOnFetchWeatherInformationSuccessCalled = false
        self.didOnFetchWeatherInformationFailureCalled = false
        didViewSetupCompletedWithFailureCalled = false
    }
}
