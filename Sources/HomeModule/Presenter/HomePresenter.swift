//
//  HomePagePresenter.swift
//
//
//  Created by Arda Onat on 20.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
    
final class HomePresenter: HomePresenterProtocol {

    // MARK: Internal properties
    var view: HomeViewProtocol?
    let interactor: HomeInteractorProtocol
    let wireframe: HomeNavigation
    let viewOperationHandler: HomeViewOperationHandler?
    
    var weatherData: WeatherInformationResponse?
    var weatherInformationList: [[CountryWeatherInformation]] = []
    var cityName: String = ""

    // MARK: Initializer
    init(interactor: HomeInteractorProtocol,
         wireframe: HomeNavigation,
         viewOperationHandler: HomeViewOperationHandler? = nil) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.viewOperationHandler = viewOperationHandler
    }
    
    // MARK: Life Cycle
    func viewDidLoad() {
        self.view?.changeViewState(.loading)
        self.view?.setupSearchBar()
        self.view?.setupTableView()
        self.view?.setupGeoLocation()
        self.view?.showActivityIndicator(true)
    }
    
    func viewDidLayoutSubviews() {
        self.view?.setupActivityIndicator()
    }
    
    func didUpdateLocations(latitude: Double, longitude: Double) {
        interactor.fetchWeatherData(latitude: latitude, longitude: longitude)
    }
    
    func didSearchBarSearchButtonClicked(cityName: String) {
        self.view?.changeViewState(.loading)
        self.view?.endSearchBarEditing()
        self.view?.showActivityIndicator(true)
        
        interactor.fetchWeatherData(with: cityName)
    }
    
    func scrollViewDidScroll() {
        self.view?.endSearchBarEditing()
    }
    
    func viewSetupCompletedWithFailure(errorMessage: String) {
        viewOperationHandler?.showToast(with: errorMessage)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func onFetchWeatherInformationSuccess(weatherInformationList: [[CountryWeatherInformation]], cityName: String) {
        self.weatherInformationList = weatherInformationList
        self.cityName = cityName
        
        DispatchQueue.main.async {
            self.view?.changeViewState(.success)
            self.view?.showActivityIndicator(false)
        }
    }
    
    func onFetchWeatherInformationFailure(errorMessage: String) {
        DispatchQueue.main.async {
            self.view?.changeViewState(.failure(errorMessage: errorMessage))
            self.view?.showActivityIndicator(false)
        }
    }
}
