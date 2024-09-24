//
//  ViewController.swift
//  Movie App
//
//  Created by Bthloo on 24/09/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    @IBOutlet weak var userNameVL: UILabel!
    @IBOutlet weak var passwordVL: UILabel!
    
    
   
    
    @IBAction func loginBtn(_ sender: Any) {
        
        
        let alertDialog = UIAlertController(title: "Error", message: "Wrong user name or password", preferredStyle: .alert)
        
        alertDialog.addAction(UIAlertAction(title: "OK", style: .default))
                        
    
        
        if login(){
            
            if userNameTF.text == "bthloo" && passwordTF.text == "123456"{
                
                
            }else{
                self.present(alertDialog, animated: true)
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameVL.text = ""
        passwordVL.text = ""
        // Do any additional setup after loading the view.
    }
    
    
    func login() -> Bool{
        
        userNameVL.text = ""
        passwordVL.text = ""
        
      //  userNameTF.borderStyle
        
       let passwordCheck = checkPassword(password: passwordVL?.text)
       let userNameCheck = checkUserName(userName:  userNameVL?.text)
        
        if passwordCheck == false || userNameCheck == false {
            return false
        }
        
        return true
    }
        
    
    func checkUserName(userName : String?)->Bool{
        
        guard let userName = userNameTF?.text, !userName.isEmpty else {
            userNameVL.text = "The username must be at least 4 characters"
            return false
        }
        if userName.count < 4 {
            userNameVL.text = "The username must be at least 4 characters"
            return false
        }
        
        return true
        
    }
    
    
    func checkPassword(password : String?)->Bool{
        
        guard let password = passwordTF?.text, !password.isEmpty else {
            passwordVL.text = "The password must be at least 6 characters"
            return false
        }
        
        if password.count < 6 {
            passwordVL.text = "The password must be at least 6 characters"
            return false
        }
        
        return true
        
    }


}

