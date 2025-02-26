//
//  StudentListVC.swift
//  TableDemo1001
//
//  Created by Rajat Ghosh on 25/02/25.
//

import UIKit

class StudentListVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var arrStudentList :[[String:String]] =  [[String:String]]()
    @IBOutlet weak var tblStudentList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        studentList()
        setUpTableView()
    }
    
    func studentList(){
        
      /*  arrStudentList =  UserDefaults.standard.value(forKey:"keyStudentList") as? [[String:String]] ?? []
        
       */
         
        arrStudentList = [
                           [
                            "name" : "Sujoy Bose",
                            "rollNo" : "Reg3001",
                            "Dept" :   "IT",
                            "Address" :   "Kolkta"
                           ],
                           [
                            "name" : "Ajoy Nandi",
                            "rollNo" : "Reg5001",
                            "Dept" : "CSE",
                            "Address" : "Lucknow"
                           ],
                           [
                            "name" : "Subham Saha",
                            "rollNo" : "Reg6001",
                            "Dept" : "ECE",
                            "Address" : "Delhi"
                           ],
                           [
                            "name" : "Manas Mukherjee",
                            "rollNo" : "Reg6001",
                            "Dept" : "IT",
                            "Address" : "Mumbai"
                           ]
                   
                        ]
        
         
    }
    
    func setUpTableView(){
        
        self.tblStudentList.delegate = self
        self.tblStudentList.dataSource = self
        self.tblStudentList.backgroundColor = UIColor.clear
        self.tblStudentList.separatorStyle = .none
        
       // self.tblPaymentHistoryList.rowHeight = UITableView.automaticDimension
      //  self.tblPaymentHistoryList.estimatedRowHeight = 172
        
        self.tblStudentList.register(UINib(nibName: "CustCellStudentInfo", bundle: nil), forCellReuseIdentifier: "CustCellStudentInfo")
    }
    
   
    
    // MARK:  UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrStudentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"CustCellStudentInfo", for: indexPath) as? CustCellStudentInfo else { return UITableViewCell() }
        
      
        cell.lblStudentName.text =  self.arrStudentList[indexPath.row]["name"]
        cell.lblStudentRollNo.text =  self.arrStudentList[indexPath.row]["rollNo"]
        cell.lblStudentDept.text =  self.arrStudentList[indexPath.row]["Dept"]
        cell.lblStudentAddress.text =  self.arrStudentList[indexPath.row]["Address"]
        
       
      //  cell.lblFruitsName.text =  self.arrFruitsName[indexPath.row]
        
      // cell.btnRefRemove.addTarget(self, action: #selector(deleteFruitFun(_:)), for: .touchUpInside)
     //  cell.btnRefRemove.tag = Int(indexPath.row)
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 160
    }
    

}
