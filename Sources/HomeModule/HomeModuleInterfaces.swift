//
//  HomeModuleInterfaces.swift
//  
//
//  Created by Arda Onat on 17.10.2021.
//

protocol HomeViewProtocol: AnyObject {
    func changeViewState(_ viewState: ViewState)
    func setupSearchBar()
    func setupTableView()
    func setupActivityIndicator()
    func setupGeoLocation()
    func endSearchBarEditing()
    func showActivityIndicator(_ shouldShow: Bool)
}

public protocol HomeViewOperationHandler {
    func showToast(with errorMessage: String)
}

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol { get }
    var wireframe: HomeNavigation { get }
    
    var weatherInformationList: [[CountryWeatherInformationModel]] { get set }
    var cityName: String { get set }
    
    func viewDidLoad()
    func didUpdateLocations(latitude: Double, longitude: Double)
    func didSearchBarSearchButtonClicked(cityName: String)
    func scrollViewDidScroll()
}

protocol HomeInteractorProtocol {
    var service: HomeServiceProtocol { get }
    var output: HomeInteractorOutputProtocol? { get set }
    
    func fetchWeatherData(with cityName: String)
    func fetchWeatherData(latitude: Double, longitude: Double)
}

protocol HomeServiceProtocol {
    var homeApi: HomeApi { get }
    var output: HomeServiceOutputProtocol? { get set }
    
    func fetchWeatherData(cityName: String)
    func fetchWeatherData(latitude: Double, longitude: Double)
}

protocol HomeServiceOutputProtocol {
    func onFetchWeatherInformationSuccess(response: WeatherInformationResponseModel)
    func onFetchWeatherInformationFailure(error: Error)
}

public protocol HomeNavigation {
    func routeToDetail()
}
