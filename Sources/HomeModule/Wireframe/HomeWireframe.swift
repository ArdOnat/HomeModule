//
//  HomePageWireframe.swift
//  WeatherApp
//
//  Created by Arda Onat on 20.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

public protocol HomeNavigation {
    func routeToDetail()
}

final class HomeWireframe: HomeNavigation {

    private let homeNavigation: HomeNavigation
    
    init(homeNavigation: HomeNavigation) {
        self.homeNavigation = homeNavigation
    }
    
    func routeToDetail() {
        homeNavigation.routeToDetail()
    }
}
