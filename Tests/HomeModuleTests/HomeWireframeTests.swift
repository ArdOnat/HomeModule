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
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    func testRouteToDetailCallsNavigationHandlerRouteToDetail() {
        // Given
        let fakeHomeNavigationHandler = FakeHomeWireframe()
        let sut = makeSUT(homeNavigationHandler: fakeHomeNavigationHandler)
        
        // When
        sut.routeToDetail()
        
        // Then
        XCTAssertTrue(fakeHomeNavigationHandler.didRouteToDetail)
    }
    
    // MARK: - Helpers
    private func makeSUT(homeNavigationHandler: HomeNavigation) -> HomeWireframe {
        let sut = HomeWireframe(homeNavigationHandler: homeNavigationHandler)
        return sut
    }
}
