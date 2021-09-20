//
//  FakeHomeModuleView.swift
//  WeatherApp
//
//  Created by Arda Onat on 18.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import HomeModule

class FakeHomeView: HomeViewProtocol {
    
    // MARK: - Properties
    var presenter: HomePresenterProtocol
    
    // MARK: - Test Properties
    var didChangeViewStateCalled: Bool = false
    var didSetupSearchBarCalled: Bool = false
    var didSetupTableViewCalled: Bool = false
    var didSetupActivityIndicatorCalled: Bool = false
    var didSetupGeoLocationCalled: Bool = false
    var didEndSearchBarEditingCalled: Bool = false
    var didShowActivityIndicatorTrueCalled: Bool = false
    var didShowActivityIndicatorFalseCalled: Bool = false
    
    // MARK: - Initializers
    required init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
    }
    
    init() {
        self.presenter = FakeHomePresenter()
    }
    
    func changeViewState(_ viewState: ViewState) {
        self.didChangeViewStateCalled = true
    }
    
    func setupSearchBar() {
        self.didSetupSearchBarCalled = true
    }
    
    func setupTableView() {
        self.didSetupTableViewCalled = true
    }
    
    func setupActivityIndicator() {
        self.didSetupActivityIndicatorCalled = true
    }
    
    func setupGeoLocation() {
        self.didSetupGeoLocationCalled = true
    }
    
    func endSearchBarEditing() {
        self.didEndSearchBarEditingCalled = true
    }
    
    func showActivityIndicator(_ shouldShow: Bool) {
        if shouldShow {
            self.didShowActivityIndicatorTrueCalled = true
        } else {
            self.didShowActivityIndicatorFalseCalled = true
        }
    }
    
    // MARK: - Helpers
    func resetFlags() {
        self.didChangeViewStateCalled = false
        self.didSetupSearchBarCalled = false
        self.didSetupTableViewCalled = false
        self.didSetupActivityIndicatorCalled = false
        self.didSetupGeoLocationCalled = false
        self.didEndSearchBarEditingCalled = false
        self.didShowActivityIndicatorTrueCalled = false
        self.didShowActivityIndicatorFalseCalled = false
    }
}
