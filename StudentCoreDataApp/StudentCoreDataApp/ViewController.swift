//
//  ViewController.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 05/03/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnViewRecords(_ sender: UIButton) {
        let homeVC = UIStoryboard(name: "Main", bundle: nil)
        let stuhomeVC =  homeVC.instantiateViewController(withIdentifier: "StudentHomeVC")
        self.present(stuhomeVC, animated: true, completion:nil)
    }
    
    @IBAction func btnAddaRecord(_ sender: UIButton){
        let addStu = UIStoryboard(name: "Main", bundle: nil)
        let addStudent = addStu.instantiateViewController(withIdentifier: "CreateVC")
       // self.present(addStudent, animated: true, completion: nil)
        self.navigationController?.pushViewController(addStudent, animated:true)
    }
    
        
    
    
}

