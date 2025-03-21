//
//  SignupVC.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 17/03/25.
//

import UIKit

class SignupVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var txtusername: UITextField!
    
    @IBOutlet weak var txtemail: UITextField!
    
    @IBOutlet weak var txtpassword: UITextField!
    

    @IBAction func gotoSigninPage(_ sender: UIButton) {
        let login = UIStoryboard(name: "Main", bundle: nil)
        let log = login.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(log, animated:true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtusername.delegate=self
        txtemail.delegate=self
        txtpassword.delegate=self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
            // Validate input fields
            guard let username = txtusername.text, !username.isEmpty,
                  let email = txtemail.text, !email.isEmpty,
                  let password = txtpassword.text, !password.isEmpty else {
                showAlert(title: "Error", message: "All fields are required.")
                return
            }
        
        // Create URL
                guard let url = URL(string: "http://localhost:8080/api/auth/register") else {
                    showAlert(title: "Error", message: "Invalid URL")
                    return
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                // Prepare JSON body for registration
                let json: [String: Any] = [
                    "username": username,
                    "email": email,
                    "password": password
                ]
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                    request.httpBody = jsonData
                } catch {
                    showAlert(title: "Error", message: "Error creating JSON data")
                    return
                }
        Loader.shared.show()
                
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle errors
            if let error = error {
                DispatchQueue.main.async {
                   

                    self.showAlert(title: "Error", message: error.localizedDescription)
                                    }
                return
            }
            
            // Ensure data was received
            guard let data = data else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "No data received")
                }
                return
            }
            
            // Decode JSON using Codable
            do {
                let decoder = JSONDecoder()
                let signupResponse = try decoder.decode(LoginRes.self, from: data)
                DispatchQueue.main.async {
                if signupResponse.isSuccess {
                    Loader.shared.hide()
                                   
                let alert = UIAlertController(title: "Success", message: signupResponse.message, preferredStyle: .alert)
                                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
                                           self.navigationController?.pushViewController(loginVC, animated: true)
                                       } else {
                                           Loader.shared.hide()
                                           self.showAlert(title: "Error", message: "Unable to find Login screen")
                                       }
                                   }))
                                   self.present(alert, animated: true, completion: nil)
                               } else {
                                   Loader.shared.hide()
                                   self.showAlert(title: "Signup Failed", message: signupResponse.message)
                               }
                           }
                       } catch {
                           DispatchQueue.main.async {
                               Loader.shared.hide()
                               self.showAlert(title: "Error", message: "Error parsing response: \(error.localizedDescription)")
                           }
                       }
                   }
                   task.resume()
               }
            
            func showAlert(title: String, message: String) {
                let alertController = UIAlertController(title: title,
                                                        message: message,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }

/*

{
    "data": {
         "userId" : "1001"
        "username": "shivam",
        "email": "shivam@text.ok"
    },
    "message": "Logged in successfully",
    "isSuccess": true
 
    
}
 {
     "data": {
          "userId" : 1003
         "username": "shivam",
         "email": "shivam@text.ok"
     },
     "message": "Logged in successfully",
     "isSuccess": true
  
     
 }


struct LoginRes : Codable{
    let message : String
    let isSuccess : String
    let data : LoginData?
}

struct LoginData : Codable{
  //  let userId : String
    let username : String
    let email : String
}
*/
  
