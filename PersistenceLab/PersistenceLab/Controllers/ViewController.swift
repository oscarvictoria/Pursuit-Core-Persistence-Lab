//
//  ViewController.swift
//  PersistenceLab
//
//  Created by Oscar Victoria Gonzalez  on 1/17/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import ImageKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var pictures = [Hits]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
//        searchBar.delegate = self
        loadPhotos()
    }

    func loadPhotos() {
        PhotosAPIClient.getPhotos(searchQuery: "new york") { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let photos):
                self.pictures = photos
            }
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photosCell", for: indexPath) as? PhotoCell else {
            fatalError("could not get cell")
        }
        let photo = pictures[indexPath.row]
        cell.photoImageView.getImage(with: photo.largeImageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
