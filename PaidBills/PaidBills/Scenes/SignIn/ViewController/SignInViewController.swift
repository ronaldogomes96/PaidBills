//
//  SignInViewController.swift
//  PaidBills
//
//  Created by Ronaldo Gomes on 18/08/21.
//

import UIKit
import AuthenticationServices
import FirebaseAuth
import CryptoKit

protocol SignInInput {
    func sucessLogin()
}

class SignInViewController: UIViewController, SignInInput {
    private var router: SignInRouterLogic?
    fileprivate var currentNonce: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWorkflow()
    }
    
    private func setupWorkflow() {
        //let presenter = ExpensesPresenter()
       // presenter.controller = self
        //interactor = ExpensesInteractor(presenter: presenter)
        router = SignInRouter(controller: self)
    }
    
    override func loadView() {
        super.loadView()
        
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(handlerSignIn), for: .touchUpInside)
        button.center = view.center
        view.addSubview(button)
    }
    
    @objc private func handlerSignIn() {
        let request = createAppleIDRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self as ASAuthorizationControllerPresentationContextProviding
        authorizationController.performRequests()
    }
    
    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDprovider = ASAuthorizationAppleIDProvider()
        let request = appleIDprovider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        return request
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        return hashString
    }
    

    func sucessLogin() {
        
    }
}

extension SignInViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if (error != nil) {
                    print(error!.localizedDescription)
                    return
                }
                self.router?.showInitialScreen()
            }
        }
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func createAppleUserModel(for result: ASAuthorizationAppleIDCredential) {
        router?.showInitialScreen()
    }
}
