//
//  DoctorCell.swift
//  MobileTest(SeowYungHoe)
//
//  Created by Seow Yung Hoe on 29/03/2017.
//  Copyright © 2017 Seow Yung Hoe. All rights reserved.
//

import UIKit

class DoctorCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorAreaLabel: UILabel!
    @IBOutlet weak var doctorSpecialityLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    
    
    
    
    
    static let cellIdentifier = "DoctorCell"
    static let cellNib = UINib(nibName: "DoctorCell", bundle: Bundle.main)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
