//
//  HomePageModuleBuilder.swift
//  
//
//  Created by Arda Onat on 20.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
import CoreModule

public final class HomePageModuleBuilder {
    
    public static func generate(homeApi: HomeApi, homeNavigation: HomeNavigation, viewOperationHandler: HomeViewOperationHandler) -> HomeViewController {
        let wireframe: HomeNavigation = HomeWireframe(homeNavigation: homeNavigation)
        var service: HomeServiceProtocol = HomeService(homeApi: homeApi)
        let interactor: HomeInteractor = HomeInteractor(service: service)
        let presenter: HomePresenter = HomePresenter(interactor: interactor, wireframe: wireframe, viewOperationHandler: viewOperationHandler)
        let view: HomeViewController = HomeViewController(presenter: presenter)
            
        presenter.view = WeakRef(view)
        interactor.output = WeakRef(presenter)
        service.output = WeakRef(interactor)
        
        return view
    }
}

