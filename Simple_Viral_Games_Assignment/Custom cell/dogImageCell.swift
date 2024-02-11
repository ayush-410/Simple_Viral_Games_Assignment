//
//  dogImageCell.swift
//  Simple_Viral_Games_Assignment
//
//  Created by Ayush Singh on 10/02/24.
//

import UIKit

class dogImageCell: UICollectionViewCell {

    static let reuseID = "cell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dogImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(imageKey: String) {
        NetworkManager.shared.downloadImage(urlString: imageKey) { [weak self] image in
            guard let self else { return }
            DispatchQueue.main.async {
                self.dogImageView.image = image
            }
        }
    }
}
