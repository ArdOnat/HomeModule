//
//  HomeModuleViewTests.swift
//  WeatherApp
//
//  Created by Arda Onat on 18.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import HomeModule

import XCTest

class HomeViewTests: XCTestCase {

    // MARK: - Properties
    var view: HomeViewController!
    
    let fakePresenter = FakeHomePresenter()
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        
        self.view = HomeViewController(presenter: fakePresenter)
    }
    
    override func tearDown() {
        super.tearDown()
        
        fakePresenter.resetFlags()
    }
    
    // MARK: - Tests
    func testInitFromCoder() {
        let view = HomeViewController(coder: NSCoder())
        XCTAssertNil(view)
    }
    
    func testViewDidLoad() {
        view.viewDidLoad()
        
        XCTAssertTrue(fakePresenter.didViewDidLoadCalled)
    }
}
