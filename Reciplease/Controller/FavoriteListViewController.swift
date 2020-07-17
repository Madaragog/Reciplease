//
//  FavoriteListViewController.swift
//  Reciplease
//
//  Created by Cedric on 28/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import UIKit
import CoreData

class FavoriteListViewController: SearchRecipesListViewController {
    @IBOutlet weak var favoriteTableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipes = FavoriteRecipes.shared.getFavoriteRecipes()
        favoriteTableView.reloadData()
    }
}
