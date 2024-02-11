//
//  RecentDogImagesVC.swift
//  Simple_Viral_Games_Assignment
//
//  Created by Ayush Singh on 09/02/24.
//

import UIKit

class RecentDogImagesVC: UIViewController {

    @IBOutlet weak var dogImagesCollectionView: UICollectionView!
    var dataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadCachefromUserDefaults()
    }
    
    @IBAction func clearBtnTapped(_ sender: UIButton) {
        PersistenceManager.removeImages()
        dataSource.removeAll()
        DispatchQueue.main.async {
            self.dogImagesCollectionView.reloadData()
        }
    }
    
    private func configureUI() {
        dogImagesCollectionView.register(UINib(nibName: "dogImageCell", bundle: nil), forCellWithReuseIdentifier: dogImageCell.reuseID)
    }
    
    private func loadCachefromUserDefaults() {
        let cachedImageKeys = PersistenceManager.retrieveImages()
        self.dataSource = cachedImageKeys
        DispatchQueue.main.async {
            self.dogImagesCollectionView.reloadData()
        }
    }
}

extension RecentDogImagesVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dogImageCell.reuseID, for: indexPath) as? dogImageCell else { return UICollectionViewCell() }
        let imageKey = dataSource[indexPath.item]
        cell.set(imageKey: imageKey)
        return cell
    }
}

extension RecentDogImagesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
