//
//  GenerateDogImageVC.swift
//  Simple_Viral_Games_Assignment
//
//  Created by Ayush Singh on 08/02/24.
//

import UIKit

class GenerateDogImageVC: UIViewController {

    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loaderView.isHidden = true
    }
    
    @IBAction func generateBtnTapped(_ sender: UIButton) {
        showLoadingView()
        NetworkManager.shared.getDogImage { [weak self] response in
            guard let self else { return }
           
            
            switch response {
            case .success(let dogImageUrl):
                self.loadDogImage(urlString: dogImageUrl.message)
                PersistenceManager.updateWith(dogImageUrl: dogImageUrl.message)
            case .failure(let error):
                self.alertOnMainThread(error: error)
            }
        }
    }
    
    private func loadDogImage(urlString: String) {
        NetworkManager.shared.downloadImage(urlString: urlString) { [weak self] image in
            guard let self else { return }
            DispatchQueue.main.async {
                self.dismissLoadingView()
                self.dogImageView.image = image
            }
        }
    }
    
    private func alertOnMainThread(error: APIError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error Occured!", message: error.rawValue, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    private func showLoadingView() {
        loaderView.isHidden = false
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 0.8
        }
        loaderView.startAnimating()
    }
    
    private func dismissLoadingView() {
        loaderView.isHidden = true
        view.alpha = 1
    }
}
