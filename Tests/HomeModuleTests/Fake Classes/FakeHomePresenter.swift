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
    var weatherInformationList: [[CountryWeatherInformationModel]]
    var cityName: String
    
    // MARK: - Test Properties
    var didViewDidLoadCalled: Bool = false
    var didUpdateLocationsCalled: Bool = false
    var didSearchbarSearchButtonClickedCalled: Bool = false
    var didScrollViewDidScrollCalled: Bool = false
    var didOnFetchWeatherInformationSuccessCalled: Bool = false
    var didOnFetchWeatherInformationFailureCalled: Bool = false
    
    // MARK: - Initializers
    required init(interactor: HomeInteractorProtocol, wireframe: HomeNavigation) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.weatherInformationList = []
        self.cityName = ""
    }
    
    init(weatherInformationList: [[CountryWeatherInformationModel]] = [], cityName: String = "") {
        self.interactor = FakeHomeInteractor()
        self.wireframe = FakeHomeWireframe()
        self.weatherInformationList = weatherInformationList
        self.cityName = cityName
    }
    
    func viewDidLoad() {
        self.didViewDidLoadCalled = true
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
    
    func onFetchWeatherInformationSuccess(weatherInformationList: [[CountryWeatherInformationModel]], cityName: String) {
        self.didOnFetchWeatherInformationSuccessCalled = true
    }
    
    func onFetchWeatherInformationFailure(errorMessage: String) {
        self.didOnFetchWeatherInformationFailureCalled = true
    }
    
    // MARK: - Helpers
    func resetFlags() {
        self.didViewDidLoadCalled = false
        self.didUpdateLocationsCalled = false
        self.didSearchbarSearchButtonClickedCalled = false
        self.didScrollViewDidScrollCalled = false
        self.didOnFetchWeatherInformationSuccessCalled = false
        self.didOnFetchWeatherInformationFailureCalled = false
    }
}
