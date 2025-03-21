//
//  ApiCell.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 17/03/25.
//

import UIKit

class ApiCell: UITableViewCell {
    
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lbgenre: UILabel!
    
    @IBOutlet weak var lblyear: UILabel!
    
    @IBOutlet weak var lblactors: UILabel!
    
    @IBOutlet weak var lblrating: UILabel!
    
    
    @IBOutlet weak var viewBorder: UIView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.2)
        
               lbgenre.textColor = .black
               lblname.textColor = .black
               lblyear.textColor = .black
               lblactors.textColor = .black
               lblactors.textColor = .black
        
        viewBorder.layer.borderWidth=3

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        

    }
}
