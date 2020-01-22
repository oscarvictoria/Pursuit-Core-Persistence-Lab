//
//  FavoritesViewController.swift
//  PersistenceLab
//
//  Created by Oscar Victoria Gonzalez  on 1/20/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var favorites = [Hits]() {
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(true)
       loadData()
     }
    
    func loadData() {
        do {
            favorites = try PersistanceHelper.loadEvents()
        } catch {
            print("error loading events: \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoritesDVC" {
            guard let favoritesDVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {
                    fatalError("could not segue")
            }
            
            let photos = favorites[indexPath.row]
            favoritesDVC.pictures = photos
            favoritesDVC.testNumber = 0
        }
       
    }
    
    
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? PhotoCell else {
            fatalError("could not get cell")
        }
        let pictures = favorites[indexPath.row]
        cell.photoImageView.getImage(with: pictures.largeImageURL) { (result) in
            switch result {
            case .failure(let error):
                print("error: \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
