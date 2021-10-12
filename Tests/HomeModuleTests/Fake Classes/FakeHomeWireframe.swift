//
//  FakeHomeModuleWireframe.swift
//  WeatherApp
//
//  Created by Arda Onat on 18.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import HomeModule

class FakeHomeWireframe: HomeNavigation {
    
    
    // MARK: - Properties
    
    // MARK: - Test Properties
    var didRouteToDetail: Bool = false
    
    // MARK: - Initializer
    init() {
        
    }
    
    // MARK: - Helpers
    func resetFlags() {
        didRouteToDetail = false
    }
    
    func routeToDetail() {
        didRouteToDetail = true
    }
}
