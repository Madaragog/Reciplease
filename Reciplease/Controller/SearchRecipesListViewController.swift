//
//  SearchRecipesListViewController.swift
//  Reciplease
//
//  Created by Cedric on 22/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import UIKit

class SearchRecipesListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
}

extension SearchRecipesListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeRequestService.shared.sharedRecipeList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CacheRecipeCell",
                                                for: indexPath) as? CacheRecipesListTableViewCell else {
            return UITableViewCell()
        }

        let recipe = RecipeRequestService.shared.sharedRecipeList[indexPath.row]

        cell.configure(recipeImage: recipe.imageData, recipeTitle: recipe.name,
                       recipeDetail: recipe.ingredientsDetails[0],
                       recipeLikesNumber: recipe.numberOfLikes,
                       recipeLikesImage: "LikesIcon",
                       recipeTime: recipe.preparationTime, recipeTimeImage: "TimeIcon")

        return cell
    }
}
