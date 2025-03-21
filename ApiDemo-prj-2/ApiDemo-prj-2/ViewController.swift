//
//  ViewController.swift
//  ApiDemo-prj-2
//
//  Created by iPHTech 35 on 20/03/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signinBtn(_ sender: UIButton) {
        let signVC = UIStoryboard(name: "Main", bundle: nil)
        let singinVC = signVC.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(singinVC, animated:true)
    }
    
    @IBAction func createAccountbtn(_ sender: UIButton) {
        let signVC = UIStoryboard(name: "Main", bundle: nil)
        let singinVC = signVC.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(singinVC, animated:true)
    }


}

