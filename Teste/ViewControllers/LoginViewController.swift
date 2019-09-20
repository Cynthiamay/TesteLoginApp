//
//  LoginViewController.swift
//  Teste
//
//  Created by Treinamento on 8/28/19.
//  Copyright © 2019 cynthiamayumiwatanabeyamaoto. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //esconder o erro por enquanto
        setUpElements()
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "placeholder text",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        
        
    }
    func setUpElements() {
        errorLabel.alpha = 0
    }
 
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        //validar os campos
        
        //Campos de texto
        let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //usernameTextField.attributedPlaceholder = NSAttributedString(string: "placeholder", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
        //entrando com o usuário
        Auth.auth().signIn(withEmail: username, password: password){ (result, error) in
            
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else{
                
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        
    }
    

}

}
