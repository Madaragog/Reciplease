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

    var recipes = RecipeRequestService.shared.sharedRecipeList
    var recipe: RecipeAdded?
    var recipeImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension SearchRecipesListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell",
                                                for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }

        let recipe = recipes[indexPath.row]

        cell.configure(recipe: recipe)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ListTableViewCell else {
            return
        }
        recipe = recipes[indexPath.row]
        recipeImage = cell.recipeImage
        self.performSegue(withIdentifier: "RecipeDetailSegue", sender: nil)
    }
// swiftlint:disable force_cast
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeDetailSegue" {
            let destinationVC = segue.destination as! RecipesDetailsViewController
            if let recipeImage = self.recipeImage {
                destinationVC.recipeImage = recipeImage
            }
            if let recipe = self.recipe {
                destinationVC.recipe = recipe
            }
        }
    }
}
