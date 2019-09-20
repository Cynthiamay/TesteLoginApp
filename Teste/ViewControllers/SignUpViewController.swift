//
//  SignUpViewController.swift
//  Teste
//
//  Created by Treinamento on 8/28/19.
//  Copyright © 2019 cynthiamayumiwatanabeyamaoto. All rights reserved.
//

import UIKit
//adicionar para o Xcode reconhecer a função de criar usuário
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //esconder o erro por enquanto
        setUpElements()
    }
    func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    //Verifica os campos e valida se os dados estao corretos. Se estiver tudo correto, o metodo retorna nil, se nao, retorna a mensagem de erro
    
    func validateFields() -> String? {
        
        //Verifica se todos os campos estao preenchidos
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Complete todos os campos"
        }
        //Verifica se a senha é segura
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //o código a seguir foi copiado do site https://iosdevcenters.blogspot.com/2017/06/password-validation-in-swift-30.html
        
        func isPasswordValid(_ password : String) -> Bool{
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
            return passwordTest.evaluate(with: password)
        }
        //se a senha for insegura
        if isPasswordValid(cleanedPassword) == false {
            return "Senha fraca, use ao menos 8 caracteres, um caractere especial e um número"
        }
        
        return nil
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        //Validar os campos
        let error = validateFields()
        
        if error != nil {
            
            showError(error!)
        }
        else{
            //Criar o usuario
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //o codigo a seguir é copiado do firebase em Doc, iOS, autenticar senha.
            //é importante que o email e a senha estejam definidos com as palavras certas, caso contrário não criará os dados no firebase, por isso não se deve colocar somente aspas (não definir a palavra-chave)
            Auth.auth().createUser(withEmail: email, password: password){ (result, err) in
             // verifica os erros
                if err != nil {
                    // se houver erros em criar o usuário
                    self.showError("Erro em criar o usuário")
                    
                }
                else {
                    //Usuário criado com sucesso
                    let db = Firestore.firestore()
                    //dt de data, entre chaves são os dicionários com as keys.
                    db.collection("users").addDocument (data: ["firstname": firstName, "lastname": lastName, "uid":result!.user.uid]) {(error)in
                        
                        if error != nil {
                            self.showError("Ocorreu um erro")
                        }
                    }
                }
            }
            
            //Ir para a tela de Home
            self.voltarATelaInicial()
        }
      
    }
    //irá mostra o erro que anteriormente estava invisïvel
    func showError(_ message : String) {
            errorLabel.text = message
            errorLabel.alpha = 1
    
    }
    func voltarATelaInicial() {
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
}
