//
//  ApiVC.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 17/03/25.
//

import UIKit
/*
    struct userResponse:Codable{
    let page:Int
    let per_page:Int
    let total:Int
    
    let data: [userInfo]
    
    }
    struct userInfo:Codable{
    let id:Int
    let email:String
    
    
    } */

struct Movie: Codable {
    let name: String
    let genre: String
    let year: Int
    let actors: [String]
    let rating: Double
}

class ApiVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var btnsettings: UIButton!
    
    @IBOutlet weak var tableView:UITableView!
    
    private var movies: [Movie] = []
    
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           tableView.register(UINib(nibName: "ApiCell", bundle: nil), forCellReuseIdentifier: "ApiCell")
           
           tableView.delegate = self
           tableView.dataSource = self
           
           // For testing, we use a fixed row height
           tableView.rowHeight = UITableView.automaticDimension
           tableView.estimatedRowHeight = 100

           
           fetchData()
       }
    
    
    
    @IBAction func settingsbtnTapped(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as? SettingsVC {
            self.navigationController?.pushViewController(settingsVC, animated: true)
        }
    }
    
    
    
    
    
    // MARK: - API Call
    func fetchData() {
            movies = []
            
            guard let url = URL(string: "http://localhost:8080/api/movies") else {
                print("Invalid URL")
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async { [self] in
                    
                    if let error = error {
                        print("Error fetching data: \(error)")
                        self.showAlert(message: "Error fetching data: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        print("Invalid HTTP response")
                        self.showAlert(message: "Error: Invalid HTTP Response")
                        return
                    }
                    
                    guard let data = data else {
                        print("No data received")
                        self.showAlert(message: "Error: No data received")
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let fetchedMovies = try decoder.decode([Movie].self, from: data)
                        self.movies = fetchedMovies
                        print("Fetched Movies: \(self.movies)")
                        self.tableView.reloadData()
                    } catch {
                        print("Error decoding JSON: \(error)")
                        self.showAlert(message: "Error: JSON Decoding Failed. \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
        
        // MARK: - UITableViewDataSource
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movies.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ApiCell", for: indexPath) as? ApiCell else {
                fatalError("Could not dequeue ApiCell")
            }
            
            let movie = movies[indexPath.row]
            print("Setting values for cell at row \(indexPath.row)")
            
           
            cell.lblname.text = "\(movie.name)"
            cell.lbgenre.text = movie.genre
            cell.lblyear.text = "\(movie.year)"
            cell.lblactors.text = movie.actors.joined(separator: ", ")
            cell.lblrating.text = "Rating: \(movie.rating)"
            
            return cell
        }
        
        // MARK: - UITableViewDelegate
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedMovie = movies[indexPath.row]
            print("Selected Movie: \(selectedMovie)")
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        // MARK: - Error Handling (Alert)
        
        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
