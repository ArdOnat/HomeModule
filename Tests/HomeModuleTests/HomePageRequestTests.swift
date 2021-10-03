//
//  File.swift
//  
//
//  Created by Arda Onat on 21.09.2021.
//

@testable import HomeModule

import XCTest
import CoreModule

class HomePageRequestTests: XCTestCase {
    
    // MARK: - Properties
    var requestWithCityName: HomePageRequest!
    var requestWithCoordinates: HomePageRequest!
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        requestWithCityName = HomePageRequest(request: HomePageRequest.Request.fetchWeatherDataWithCityName(cityName: "a"), apiEnvironment: ApiEnvironment(environmentType: MockWeatherForecastEnvironment.prod))
        
        requestWithCoordinates = HomePageRequest(request: HomePageRequest.Request.fetchWeatherDataWithCoordinates(latitude: 30, longitude: 32), apiEnvironment: ApiEnvironment(environmentType: MockWeatherForecastEnvironment.prod))
    }
    
    func testCityNameRequestHttpMethod() {
        XCTAssertEqual(requestWithCityName.httpMethod, .get)
    }
    
    func testCityNameRequestParameters() {
        XCTAssertEqual(requestWithCityName.urlParameters!["q"] as! String, "a")
    }
    
    func testCityNameRequestBodyParametersIsNil() {
        XCTAssertNil(requestWithCityName.bodyParameters)
    }
    
    func testCityNameRequestHttpHeadersIsNil() {
        XCTAssertNil(requestWithCityName.httpHeaders)
    }
    
    func testCityNameRequestPathIsCorrect() {
        XCTAssertEqual(requestWithCityName.path, "forecast")
    }
    
    func testCoordinatesRequestHttpMethod() {
        XCTAssertEqual(requestWithCoordinates.httpMethod, .get)
    }
    
    func testCoordinatesRequestParameters() {
        XCTAssertEqual(requestWithCoordinates.urlParameters!["lat"] as! String, "30.0")
        XCTAssertEqual(requestWithCoordinates.urlParameters!["lon"] as! String, "32.0")
    }
    
    func testCoordinatesRequestBodyParametersIsNil() {
        XCTAssertNil(requestWithCoordinates.bodyParameters)
    }
    
    func testCoordinatesRequestHttpHeadersIsNil() {
        XCTAssertNil(requestWithCoordinates.httpHeaders)
    }
    
    func testCoordinatesPathIsCorrect() {
        XCTAssertEqual(requestWithCoordinates.path, "forecast")
    }
}
