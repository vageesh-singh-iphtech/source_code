//
//  ProfileVC.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 18/03/25.
//

import UIKit

class ProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var lblprofileUsername: UILabel!
    
    @IBOutlet weak var lblprofileEmail: UILabel!
    
    
    var userId: Int?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //profilePic.layer.borderWidth=2
            //profilePic.layer.cornerRadius=0.5
            profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
            profilePic.clipsToBounds = true
            profilePic.layer.borderWidth=5
            profilePic.layer.borderColor = UIColor.lightGray.cgColor
            
            //labels---->>>
          //  lblprofileEmail.layer.borderWidth=1
          //  lblprofileUsername.layer.borderWidth=1
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profilePicTapped))
            profilePic.isUserInteractionEnabled = true
            profilePic.addGestureRecognizer(tapGesture)
            loadProfileImage()
    
            guard let userId = self.userId else {
                    showAlert(title: "Error", message: "User ID is missing.")
                    return
                }
                fetchUserProfile(userId: userId)
        }
        
    
        // MARK: - API Call to Fetch Profile
    
    
        func fetchUserProfile(userId: Int) {
           
            guard let url = URL(string: "http://localhost:8080/api/auth/user/\(userId)") else {
                showAlert(title: "Error", message: "Invalid URL")
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                // Handle network error------->>>>
                
                if let error = error {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error", message: error.localizedDescription)
                    }
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error", message: "Invalid HTTP Response")
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
                   
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let dataDict = jsonResponse["data"] as? [String: Any],
                       let username = dataDict["username"] as? String,
                       let email = dataDict["email"] as? String {
                        
                        DispatchQueue.main.async {
                            self.lblprofileUsername.text = username
                            self.lblprofileEmail.text = email
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.showAlert(title: "Error", message: "Invalid user data")
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error", message: "Error parsing response: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
        
        // MARK: - Image Selection and Saving
        
        @objc func profilePicTapped() {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                //save----------->>>>
                if let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                    let fileName = UUID().uuidString + ".jpg"
                    let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
                    do {
                        try imageData.write(to: fileURL)
                        
                        UserDefaults.standard.set(fileName, forKey: "profileImageFileName")
                       
                        self.profilePic.image = selectedImage
                    } catch {
                        print("Error saving image: \(error)")
                        self.showAlert(title: "Error", message: "Could not save the image.")
                    }
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        
        func loadProfileImage() {
            if let fileName = UserDefaults.standard.string(forKey: "profileImageFileName") {
                let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
                if let savedImage = UIImage(contentsOfFile: fileURL.path) {
                    self.profilePic.image = savedImage
                } else {
                    print("Could not load image from path: \(fileURL.path)")
                }
            }
        }
        
      
        func getDocumentsDirectory() -> URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
        
        // MARK: - Alert Helper
        func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
