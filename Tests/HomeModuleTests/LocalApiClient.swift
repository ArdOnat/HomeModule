//
//  File.swift
//  
//
//  Created by Arda Onat on 18.09.2021.
//

@testable import HomeModule

import Foundation
import CoreModule

class LocalApiClient {
    func request<T>(_ request: Request, queue: DispatchQueue = .main, completion: @escaping (Result<T, NetworkError>) -> ()) where T : Decodable {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent( "Mock"+request.path+"Response.json")
        
        guard let data = try? Data(contentsOf: URL(resolvingAliasFileAt: resourceURL), options: .mappedIfSafe),
              let response = try? JSONDecoder().decode(T.self, from: data) else {
            completion(.failure(.decodingFailed))
            return
        }
        
        completion(.success(response))
    }
}

extension LocalApiClient: HomeApi {
    func fetchWeatherDataWithCityName(cityName: String, completion: @escaping (Result<WeatherInformationResponse, NetworkError>) -> Void) {
        let request = HomePageRequest(request: .fetchWeatherDataWithCityName(cityName: cityName), apiEnvironment: ApiEnvironment(environmentType: MockWeatherForecastEnvironment.prod))
        self.request(request, completion: completion)
    }
    
    func fetchWeatherDataWithCoordinates(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherInformationResponse, NetworkError>) -> Void) {
        let request = HomePageRequest(request: .fetchWeatherDataWithCoordinates(latitude: latitude, longitude: longitude), apiEnvironment: ApiEnvironment(environmentType: MockWeatherForecastEnvironment.prod))
        self.request(request, completion: completion)
    }
}

enum MockWeatherForecastEnvironment: NetworkEnvironment {
    case prod
    
    var baseURL: String {
        switch self {
        case .prod: return "https://api.openweathermap.org/data/2.5/"
        }
    }
}
