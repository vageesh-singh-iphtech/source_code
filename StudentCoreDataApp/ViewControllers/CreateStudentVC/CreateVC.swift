//
//  CreateVC.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 05/03/25.
//

import UIKit
import CoreData

class CreateVC: UIViewController, UITextViewDelegate,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        
        name.delegate=self
        rollno.delegate=self
        dept.delegate=self
        address.delegate=self
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        name.layer.cornerRadius=13
        name.layer.borderWidth=2
        
        rollno.layer.cornerRadius=13
        rollno.layer.borderWidth=2
        
        dept.layer.cornerRadius=13
        dept.layer.borderWidth=2
        
        address.layer.cornerRadius=13
        address.layer.borderWidth=2
    }
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var rollno: UITextField!
    
    @IBOutlet weak var dept: UITextField!
    
    @IBOutlet weak var address: UITextField!
    
    
    @IBOutlet weak var submitbtn: UIButton!
    
    @IBAction func submitBtnRef(_ sender: Any) {
        addStudentFun()
    }
    
    
    
    /*
    // MARK: - Navigation and all functions

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func addStudentFun(){
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            guard let  appDelegate = appDelegate else{return}
            let managedContext = appDelegate.persistentContainer.viewContext
            let studentObj  =   StudentList(context: managedContext)
            
            studentObj.name  =  self.name.text ??  ""
            studentObj.rollno  =  self.rollno.text ??  ""
            studentObj.department  =  self.dept.text ??  ""
            studentObj.address  =  self.address.text ??  ""
            
            do {
                try managedContext.save()
                   debugPrint("Data saved")
            } catch let error as NSError {
                debugPrint(error)
            }
            
        }

}
