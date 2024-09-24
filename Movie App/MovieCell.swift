//
//  MovieCell.swift
//  Movie App
//
//  Created by Bthloo on 24/09/2024.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
        self.layer.cornerRadius = 10
       
       // self.layer.borderWidth = 0.5
        
        
       // self.layer.borderColor = UIColor.systemPurple.cgColor
    
    }
    
    
    
    
}
