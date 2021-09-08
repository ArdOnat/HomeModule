//
//  HomePageRequest.swift
//
//
//  Created by Arda Onat on 6.09.2021.
//

import CoreModule

public struct HomePageRequest: Request {
    
    public enum Request {
        case fetchWeatherDataWithCityName(cityName: String)
        case fetchWeatherDataWithCoordinates(latitude: Double, longitude: Double)
    }
    
    public var request: HomePageRequest.Request
    public var apiEnvironment: ApiEnvironment
    
    public init (request: HomePageRequest.Request, apiEnvironment: ApiEnvironment) {
        self.request = request
        self.apiEnvironment = apiEnvironment
    }
    
    public var path: String {
        switch request {
        case .fetchWeatherDataWithCityName(_):
            return "forecast"
        case .fetchWeatherDataWithCoordinates(_, _):
            return "forecast"
        }
    }
    
    public var httpMethod: HTTPMethods {
        return .get
    }
    
    public var urlParameters: Parameters? {
        switch request {
        case .fetchWeatherDataWithCityName(let cityName):
            var urlParameters: Parameters = Parameters()
            urlParameters["q"] = cityName
            urlParameters["units"] = "metric"
            
            return urlParameters
        case .fetchWeatherDataWithCoordinates(let latitude, let longitude):
            var urlParameters: Parameters = Parameters()
            urlParameters["lat"] = "\(latitude)"
            urlParameters["lon"] = "\(longitude)"
            urlParameters["units"] = "metric"
            
            return urlParameters
        }
    }
    
    public var bodyParameters: Parameters? {
        return nil
    }
    
    public var httpHeaders: HTTPHeaders? {
        return nil
    }
}
