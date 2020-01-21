//
//  DetailViewController.swift
//  PersistenceLab
//
//  Created by Oscar Victoria Gonzalez  on 1/20/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pictures: Hits?
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        guard let photos = pictures else {
            fatalError("could not get cell")
        }
        likesLabel.text = photos.likes.description
        tagsLabel.text = photos.tags
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
        
    }
    
}
