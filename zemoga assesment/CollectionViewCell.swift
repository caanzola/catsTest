//
//  CollectionViewCell.swift
//  zemoga assesment
//
//  Created by Camilo Anzola on 11/11/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var intelligence: UILabel!
    @IBOutlet weak var affection: UILabel!
    @IBOutlet weak var origin: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    func setCell(i: String, n: String,o: String,a: String){
        self.intelligence.text = i
        self.affection.text = a
        self.origin.text = o
        self.name.text = n
        
        
        
    }
    
    
}
