//
//  HomeModuleWireFrameTests.swift
//  WeatherApp
//
//  Created by Arda Onat on 18.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import HomeModule

import XCTest

class HomeWireFrameTests: XCTestCase {

    // MARK: - Properties
    var wireframe: HomeNavigation!
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        
        wireframe = HomeWireframe(homeNavigation: FakeHomeWireframe())
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
}
