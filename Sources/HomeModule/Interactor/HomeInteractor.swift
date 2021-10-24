//
//  HomePageInteractor.swift
//  
//
//  Created by Arda Onat on 20.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import CoreModule

final class HomeInteractor: HomeInteractorProtocol {
    
    let service: HomeServiceProtocol
    var output: HomeInteractorOutputProtocol?
    
    // MARK: Initializers
    init(service: HomeServiceProtocol) {
        self.service = service
    }
    
    func fetchWeatherData(with cityName: String) {
        service.fetchWeatherData(cityName: cityName)
    }
    
    func fetchWeatherData(latitude: Double, longitude: Double) {
        service.fetchWeatherData(latitude: latitude, longitude: longitude)
    }
    
    /// Splits weather information data into different days.
    /// - Parameter weatherInformationModelArray: Information array to be split.
    /// - Returns: Array of information model arrays.
    private func prepareWeatherInformationData(weatherInformationModelArray:[CountryWeatherInformation]) -> [[CountryWeatherInformation]]  {
        var splittedItems: [[CountryWeatherInformation]] = []
        var days: [Int] = []
        
        for weatherInformationModel in weatherInformationModelArray {
            guard let day = weatherInformationModel.dt_txt.dayFromString() else { return [] }
            
            if !days.contains(day) { days.append(day) }
        }
        
        for i in 0..<days.count {
            let filteredData = weatherInformationModelArray.filter {
                guard let day = $0.dt_txt.dayFromString() else { return false }
                
                return days[i] == day
            }
            splittedItems.append(filteredData)
        }
        return splittedItems
    }
}

extension HomeInteractor: HomeServiceOutputProtocol {
    
    func onFetchWeatherInformationSuccess(response: WeatherInformationResponse) {
        output?.onFetchWeatherInformationSuccess(weatherInformationList: prepareWeatherInformationData(weatherInformationModelArray: response.list), cityName: response.city.name)
    }
    
    func onFetchWeatherInformationFailure(error: Error) {
        output?.onFetchWeatherInformationFailure(errorMessage: error.localizedDescription)
    }
}

extension WeakRef: HomeInteractorOutputProtocol where T: HomeInteractorOutputProtocol {
    
    func onFetchWeatherInformationSuccess(weatherInformationList: [[CountryWeatherInformation]], cityName: String) {
        object?.onFetchWeatherInformationSuccess(weatherInformationList: weatherInformationList, cityName: cityName)
    }
    
    func onFetchWeatherInformationFailure(errorMessage: String) {
        object?.onFetchWeatherInformationFailure(errorMessage: errorMessage)
    }
}
