//
//  SettingsVC.swift
//  ApiDemo-prj-2
//
//  Created by iPHTech 35 on 20/03/25.
//

import UIKit

class SettingsVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func profileTapped(_ sender: UIButton) {
            
            guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
                self.showAlert(title: "Error", message: "User ID not found. Please log in again.")
                return
            }
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
                profileVC.userId = userId
                self.navigationController?.pushViewController(profileVC, animated: true)
            } else {
                self.showAlert(title: "Error", message: "Unable to load the Profile screen.")
            }
        }
        
     
        @IBAction func logoutTapped(_ sender: UIButton) {
            let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
                
                UserDefaults.standard.removeObject(forKey: "userId")
               
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if storyboard.instantiateViewController(withIdentifier: "LoginVC") is LoginVC {
                    self.navigationController?.popToRootViewController(animated: true)
                   // self.navigationController?.setViewControllers([loginVC], animated: true)
                } else {
                    self.showAlert(title: "Error", message: "Unable to load the Login screen.")
                }
            }))
            
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
   
        func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
