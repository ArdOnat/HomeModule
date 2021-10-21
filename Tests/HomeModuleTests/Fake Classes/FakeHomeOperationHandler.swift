//
//  File.swift
//  
//
//  Created by Arda Onat on 21.10.2021.
//

import HomeModule

class FakeHomeViewOperationHandler: HomeViewOperationHandler {
    
    var didShowToastCalled: Bool = false
    
    func showToast(with errorMessage: String) {
        didShowToastCalled = true
    }
    
    // MARK: - Helpers
    func resetFlags() {
        self.didShowToastCalled = false
    }
}
