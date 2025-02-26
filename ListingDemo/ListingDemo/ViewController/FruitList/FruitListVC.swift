//
//  FruitListVC.swift
//  ListingDemo
//
//  Created by iPHTech 35 on 25/02/25.
//

import UIKit

class FruitListVC: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
let fruits = ["apple","banana","guava"
              ,"grapes","mango","Strawberry",
              "cherry","water-melon","melon",
              "dragon-fruit","coconut","chest-nut",
              "Pommegranate","Blue-berries","tomato"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
    
    @IBOutlet weak var tblfruitlist: UITableView!
    
    // MARK: - UI-Table with datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"CustCellFruitInfoTableViewCell", for: indexPath) as? CustCellFruitInfoTableViewCell else { return UITableViewCell() }
               
                cell.fruitInfo.text =  self.fruits[indexPath.row]
        return cell
    }
    
    func setUpTableView(){
            
         //   self.tblfruitlist.delegate = self
         //   self.tblfruitlist.dataSource = self
            self.tblfruitlist.backgroundColor = UIColor.clear
            self.tblfruitlist.separatorStyle = .none
            
            
            self.tblfruitlist.register(UINib(nibName: "CustCellFruitInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "CustCellFruitInfoTableViewCell")
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
            return 45
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
