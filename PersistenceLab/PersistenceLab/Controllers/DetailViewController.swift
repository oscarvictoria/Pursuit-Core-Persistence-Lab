//
//  DetailViewController.swift
//  PersistenceLab
//
//  Created by Oscar Victoria Gonzalez  on 1/20/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var favoriteLabel:UIButton!
    
    var pictures: Hits?
    
    var testNumber = 1
    
    func testing() {
        if testNumber == 0 {
            favoriteLabel.isHidden = true
            favoriteLabel.isEnabled = false
        }
    }
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        favoriteLabel.isEnabled = true
        testing()
    }
    
    
    func updateUI() {
        
        guard let photos = pictures else {
            fatalError("could not get cell")
        }
        
        likesLabel.text = "Likes: \(photos.likes.description)"
        tagsLabel.text = "Tags: \(photos.tags)"
        detailImageView.getImage(with: photos.largeImageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("app error \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.detailImageView.image = image
                }
            }
        }
    }
    
    
    
    @IBAction func favorite(_ sender: UIButton) {
        if testNumber >= 1 {
            guard let theImage = pictures else {
                return
            }
            do {
                try PersistanceHelper.save(pictures: theImage)
                print("succesfully saved image")
            } catch {
                print("error saving event with error \(error)")
            }
        } else {
            favoriteLabel.isHidden = true
            favoriteLabel.isEnabled = false 
        }
        
        
    }
    
}
