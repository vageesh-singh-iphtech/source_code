//
//  ApiVC.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 17/03/25.
//

import UIKit

struct Todo:Codable{
    let userId:Int
    let id:Int
    let title:String
    let completed:Bool
}

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
    
    
    }                             */

class ApiVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var userIdLabel:UILabel!
    @IBOutlet weak var completedLabel:UILabel!
    @IBOutlet weak var loadingIndicatr:UIActivityIndicatorView!
    @IBOutlet weak var tableView:UITableView!
    
    private var todos:[Todo] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Register your custom cell! VERY IMPORTANT
                tableView.register(UINib(nibName: "ApiCell", bundle: nil), forCellReuseIdentifier: "ApiCell")  // Use UINib for custom cells

                loadingIndicatr.hidesWhenStopped = true
                loadingIndicatr.startAnimating()
        
        tableView.delegate=self
        tableView.dataSource=self
        
        fetchData()
        
    }
    // MARK: - BTN - Func - Navigation
    
  /*  @IBAction func fetchButtonTapped(_ sender: UIButton){
        loadingIndicatr.startAnimating()
        
        titleLabel.text = ""
        userIdLabel.text = ""
        completedLabel.text = ""
        titleLabel.isHidden = true
        userIdLabel.isHidden = true
        completedLabel.isHidden=true
        
        DispatchQueue.global().async{
            self.fetchData()
        }
    }  */
    
    // MARK: - API Call

    func fetchData() {
        loadingIndicatr.startAnimating()
        todos = []

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
            print("Invalid URL")
            loadingIndicatr.stopAnimating()
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async { [self] in
                self.loadingIndicatr.stopAnimating()
                
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
                    let fetchedTodos = try decoder.decode([Todo].self, from: data)
                    self.todos = fetchedTodos // Assign the fetched data to the class variable
                    
                    // Debugging: Print fetched todos array
                    print("Fetched Todos: \(self.todos)")
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
            return todos.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue the custom cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ApiCell", for: indexPath) as? ApiCell else {
            fatalError("Could not dequeue ApiCell")
        }
        
        // Fetch the correct Todo object for this index
        
        let todo = todos[indexPath.row]
        cell.lblid.text = "\(todo.id)"
        cell.lbltitle.text = todo.title
        cell.lbluserID.text = "\(todo.userId)"
        cell.lblcompleted.text = "\(todo.completed)"
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell
    }


        // MARK: - UITableViewDelegate (Optional)

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedTodo = todos[indexPath.row]
            print("Selected Todo: \(selectedTodo)")
            tableView.deselectRow(at: indexPath, animated: true) // Deselect the row
        }

        // MARK: - Error Handling (Alert)
        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
