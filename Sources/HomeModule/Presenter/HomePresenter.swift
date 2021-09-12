//
//  HomePagePresenter.swift
//
//
//  Created by Arda Onat on 20.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol { get }
    var wireframe: HomeWireframeProtocol { get }
    
    var weatherInformationList: [[CountryWeatherInformationModel]] { get set }
    var cityName: String { get set }
    
    func viewDidLoad()
    func didUpdateLocations(latitude: Double, longitude: Double)
    func didSearchBarSearchButtonClicked(cityName: String)
    func scrollViewDidScroll()
}
    
final class HomePresenter: HomePresenterProtocol {

    // MARK: Internal properties
    var view: HomeViewProtocol?
    let interactor: HomeInteractorProtocol
    let wireframe: HomeWireframeProtocol
    var weatherData: WeatherInformationResponseModel?
    
    var weatherInformationList: [[CountryWeatherInformationModel]] = []
    var cityName: String = ""

    // MARK: Initializer
    init(interactor: HomeInteractorProtocol,
         wireframe: HomeWireframeProtocol) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: Life Cycle
    func viewDidLoad() {
        self.view?.changeViewState(.loading)
        self.view?.setupSearchBar()
        self.view?.setupTableView()
        self.view?.setupGeoLocation()
        self.view?.setupActivityIndicator()
        self.view?.showActivityIndicator(true)
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
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func onFetchWeatherInformationSuccess(weatherInformationList: [[CountryWeatherInformationModel]], cityName: String) {
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
