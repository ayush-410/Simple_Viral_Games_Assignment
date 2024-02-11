//
//  ViewController.swift
//  Simple_Viral_Games_Assignment
//
//  Created by Ayush Singh on 08/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dogGeneratorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func generateDogImageBtnTapped(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "GenerateDogImageVC") as? GenerateDogImageVC else {
            return
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func recentDogImagesBtnTapped(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RecentDogImagesVC") as? RecentDogImagesVC else {
            return
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

