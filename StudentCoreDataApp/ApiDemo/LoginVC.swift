//
//  LoginVC.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 13/03/25.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var loginUserNameTxt: UITextField!
    
    @IBOutlet weak var loginPassWordTxt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func gotoSignupPage(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signupVC = storyboard.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(signupVC, animated:true)
    }
    
    
    
    
    
    @IBAction func loginBtnClick(_ sender: Any) {
        guard let username = loginUserNameTxt.text, !username.isEmpty,
              let password = loginPassWordTxt.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Please enter both username and password.")
            return
        }
        
        guard let url = URL(string: "http://localhost:8080/api/auth/login") else {
            showAlert(title: "Error", message: "Invalid URL")
            return
        }
        
        Loader.shared.show()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let json: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            request.httpBody = jsonData
        } catch {
            showAlert(title: "Error", message: "Error creating JSON data")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
       
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: error.localizedDescription)
                }
                return
            }
            
          
            guard let data = data else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "No data received")
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let loginResponse = try decoder.decode(LoginRes.self, from: data)
                
                DispatchQueue.main.async {
                    if loginResponse.isSuccess {
                        guard let loginData = loginResponse.data,
                              let userId = loginData.id
                        else{
                            self.showAlert(title: "Error",message: "Invalid user id received.")
                            return
                        }
                        self.handleSuccessfulLogin(with: userId)
                        
                        Loader.shared.hide()
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let apiVC = storyboard.instantiateViewController(withIdentifier: "ApiVC") as? ApiVC {
                        
                            self.navigationController?.pushViewController(apiVC, animated: true)
                        } else {
                            Loader.shared.hide()
                            self.showAlert(title: "Navigation Error", message: "Unable to find Profile page.")
                        }
                    } else {
                        Loader.shared.hide()
                        self.showAlert(title: "Login Error", message: loginResponse.message)
                    }
                }
            }catch{
                DispatchQueue.main.async {
                    Loader.shared.hide()
                    self.showAlert(title: "Error", message: "error in parsing the response \(error.localizedDescription)")
                }
            }
        }
            task.resume()
    }
    func handleSuccessfulLogin(with userId: Int) {
            UserDefaults.standard.set(userId, forKey: "userId")
            UserDefaults.standard.synchronize() // Important to synchronize
            print("User ID saved: \(userId)") // Add this line for debugging
        }
    
    
        func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
}
