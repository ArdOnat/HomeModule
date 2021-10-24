//
//  HomePageWireframe.swift
//  WeatherApp
//
//  Created by Arda Onat on 20.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HomeWireframe: HomeNavigation {

    private let homeNavigationHandler: HomeNavigation
    
    init(homeNavigationHandler: HomeNavigation) {
        self.homeNavigationHandler = homeNavigationHandler
    }
    
    func routeToDetail() {
        homeNavigationHandler.routeToDetail()
    }
}
