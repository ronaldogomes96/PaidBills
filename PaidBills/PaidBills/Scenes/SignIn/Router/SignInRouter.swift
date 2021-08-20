//
//  SignInRouter.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 18/08/21.
//

import UIKit

protocol SignInRouterLogic {
    func showInitialScreen()
}

class SignInRouter: SignInRouterLogic {
    weak var controller: SignInViewController?
    
    init(controller: SignInViewController?) {
        self.controller = controller
    }
    
    func showInitialScreen() {
        let storyboard = UIStoryboard(name: "InitialTabBar", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            fatalError()
        }

        sceneDelegate.window?.rootViewController = vc
    }
}
