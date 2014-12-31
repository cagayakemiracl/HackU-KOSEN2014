//
//  CustomTableViewCell.swift
//  FoodPin
//
//  Created by Simon Ng on 11/8/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    /*


    cell.nameLabel.text = NameOfMake[indexPath.row]
    cell.makeImageView.image = UIImage(named: ImageOfMake[indexPath.row])
    cell.AuthorLabel.text = AuthorOfMake[indexPath.row]
    cell.UpdateLabel.text = UpdateOfMake[indexPath.row]
    */                  
    @IBOutlet weak var makeImageView: UIImageView!
    @IBOutlet weak var AuthorLabel: UILabel!
    @IBOutlet weak var UpdateLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var favorIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
