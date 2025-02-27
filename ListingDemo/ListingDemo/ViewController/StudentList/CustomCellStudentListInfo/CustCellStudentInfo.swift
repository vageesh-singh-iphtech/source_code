//
//  CustCellStudentInfo.swift
//  TableDemo1001
//
//  Created by Rajat Ghosh on 25/02/25.
//

import UIKit

class CustCellStudentInfo: UITableViewCell {
    
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblStudentName: UILabel!
    @IBOutlet weak var lblStudentRollNo: UILabel!
    @IBOutlet weak var lblStudentDept: UILabel!
    @IBOutlet weak var lblStudentAddress: UILabel!
    
    @IBOutlet weak var btnRefEdit: UIButton!
    @IBOutlet weak var btnRefDelete: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        viewContent.layer.cornerRadius  = 5
        viewContent.layer.borderColor = UIColor.black.cgColor
        viewContent.layer.borderWidth = 1
        viewContent.layer.masksToBounds = true
        
        btnRefEdit.layer.cornerRadius = 5
        btnRefDelete.layer.cornerRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
