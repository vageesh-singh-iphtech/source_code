//
//  ProfileVC.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 18/03/25.
//

import UIKit

class ProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var lblprofileUsername: UILabel!
    
    @IBOutlet weak var lblprofileEmail: UILabel!
    
    var userId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Enable tapping on the image view to change the profile picture
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profilePicTapped))
                profilePic.isUserInteractionEnabled = true
                profilePic.addGestureRecognizer(tapGesture)
                
                // Load any previously stored profile image
                loadProfileImage()
                
                // Fetch user profile data
                if let userId = userId {
                    fetchUserProfile(userId: userId)
                } else {
                    showAlert(title: "Error", message: "User ID not found")
                }
        setupProfileImageView()
            }
            
            // MARK: - Image Selection
    func setupProfileImageView() {
            profilePic.layer.cornerRadius = profilePic.frame.size.width / 1  // Make it round
            profilePic.clipsToBounds = true // Ensure the image stays within the rounded bounds
            profilePic.layer.borderWidth = 2.0  // Add a border
            profilePic.layer.borderColor = UIColor.white.cgColor // Border color (adjust as needed)
        }
            
            @objc func profilePicTapped() {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .photoLibrary
                present(picker, animated: true, completion: nil)
            }
            
            // Called when the user picks an image
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                if let selectedImage = info[.originalImage] as? UIImage {
                    // Save the image to the Documents directory
                    if let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                        let fileName = UUID().uuidString + ".jpg"
                        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
                        do {
                            try imageData.write(to: fileURL)
                            // Store the file name in UserDefaults
                            UserDefaults.standard.set(fileName, forKey: "profileImageFileName")
                            // Update the profile image view
                            self.profilePic.image = selectedImage
                        } catch {
                            print("Error saving image: \(error)")
                            self.showAlert(title: "Error", message: "Could not save the image.")
                        }
                    }
                }
                picker.dismiss(animated: true, completion: nil)
            }
            
            // Optionally handle cancellation
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true, completion: nil)
            }
            
            // MARK: - Load Saved Image
            
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
            
            // Helper method to get the app's Documents directory
            func getDocumentsDirectory() -> URL {
                return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            }

    // MARK: - Load Saved Image
    
    
    
    
    func fetchUserProfile(userId: Int) {
            // Ensure your backend URL and endpoint match this pattern
            guard let url = URL(string: "http://localhost:8080/api/auth/user/\(userId)") else {
                showAlert(title: "Error", message: "Invalid URL")
                return
            }
            
            // Create the data task
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                // Handle network error
                if let error = error {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error", message: error.localizedDescription)
                    }
                    return
                }
                
                // Ensure we received data
                guard let data = data else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error", message: "No data received")
                    }
                    return
                }
                
                do {
                    // Parse the JSON response
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Full JSON response: \(jsonResponse)")
                        // Extract the "data" dictionary from the response
                        if let dataDict = jsonResponse["data"] as? [String: Any],
                           let username = dataDict["username"] as? String,
                           let email = dataDict["email"] as? String {
                            
                            // Update the UI on the main thread
                            DispatchQueue.main.async {
                                self.lblprofileUsername.text = username
                                self.lblprofileEmail.text = email
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.showAlert(title: "Error", message: "Invalid user data")
                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error", message: "Error parsing response")
                    }
                }
            }
            task.resume()
        }
        
        // A helper method to show alerts from anywhere in this view controller.
        func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
   
