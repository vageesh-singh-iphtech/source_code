//
//  StudentHomeVC.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 05/03/25.
//

import UIKit
import CoreData

class StudentHomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var arrStudentList = [StudentList]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        loadDataFun()
    }
    
    @IBOutlet weak var tblStudentList: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setUpTableView(){
            
            self.tblStudentList.delegate = self
            self.tblStudentList.dataSource = self
            self.tblStudentList.backgroundColor = UIColor.clear
            self.tblStudentList.separatorStyle = .none
            
           // self.tblPaymentHistoryList.rowHeight = UITableView.automaticDimension
          //  self.tblPaymentHistoryList.estimatedRowHeight = 172
            
            self.tblStudentList.register(UINib(nibName: "StudentCustomCell", bundle: nil), forCellReuseIdentifier: "StudentCustomCell")
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            arrStudentList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:"StudentCustomCell", for: indexPath) as? StudentCustomCell else { return UITableViewCell() }
            
          
            cell.lblname.text =  self.arrStudentList[indexPath.row].name
            cell.lblrollno.text =  self.arrStudentList[indexPath.row].rollno
            cell.lbldept.text =  self.arrStudentList[indexPath.row].department
            cell.lbladdress.text =  self.arrStudentList[indexPath.row].address
            
           
          //  cell.btnRefEdit.addTarget(self, action: #selector(editStudentFun(_:)), for: .touchUpInside)
            cell.btnRefEdit.tag = Int(indexPath.row)
            
          // cell.btnRefDelete.addTarget(self, action: #selector(deleteStudentFun(_:)), for: .touchUpInside)
           cell.btnRefDelete.tag = Int(indexPath.row)
            
            
            cell.selectionStyle = .none
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
            return 160
        }
    
    func loadDataFun() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                  let managedContext = appDelegate.persistentContainer.viewContext
                  let  fetchRequest = NSFetchRequest<StudentList>(entityName: "StudentList")
           
                 
            fetchRequest.returnsObjectsAsFaults = false
                  do {
                       let product = try managedContext.fetch(fetchRequest)
                     // debugPrint("load values")
                      arrStudentList = product
                      tblStudentList.reloadData()
                  } catch let error as NSError {
                      debugPrint(error)
                  }
           
       }

}
