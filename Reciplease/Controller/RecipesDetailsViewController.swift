//
//  SearchRecipesDetailsViewController.swift
//  Reciplease
//
//  Created by Cedric on 25/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import UIKit

class RecipesDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recipeLikesAndTimeView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeLikesLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var shadowView: UIView!

    var recipe: RecipeAdded?
    var recipeImage: UIImage?
    var buttonActive = false

    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.addShadow(yValue: 5, height: 55, color: #colorLiteral(red: 0.2141435742, green: 0.1995913982, blue: 0.1954106987, alpha: 1))
        recipeLikesAndTimeView.addViewBorder(borderColor: #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), borderWith: 1.0, borderCornerRadius: 4)
        getDirectionsButton.addBorder(borderCornerRadius: 4)
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        ifRecipeIsFavorite()
    }

    @IBAction func didTapFavoriteButton(_ sender: Any) {
        guard let recipe = recipe else {
            print("recipe error")
            return
        }
        if buttonActive {
            print("deleting recipe")
            favoriteButton.setBackgroundImage(UIImage(named: "StarIcon"), for: .normal)
            FavoriteRecipes.shared.deleteFavoriteRecipe(recipe: recipe)
        } else {
            print("saving recipe")
            favoriteButton.setBackgroundImage(UIImage(named: "StarFavoriteIcon"), for: .normal)
            FavoriteRecipes.shared.saveFavoriteRecipe(recipe: recipe)
        }
        buttonActive = !buttonActive
    }

    @IBAction func didPressGetDirectionsButton(_ sender: Any) {
            UIApplication.shared.open((URL(string: recipe!.originalRecipeUrl) ?? URL(string:
                                        "https://www.google.com/"))!, options: [:], completionHandler: nil)
    }

    private func ifRecipeIsFavorite() {
        guard let recipe = recipe else {
            return
        }
        if FavoriteRecipes.shared.getFavoriteRecipes().contains(recipe) {
            favoriteButton.setBackgroundImage(UIImage(named: "StarFavoriteIcon"), for: .normal)
            buttonActive = true
        } else {
            favoriteButton.setBackgroundImage(UIImage(named: "StarIcon"), for: .normal)
            buttonActive = false
        }
    }

    private func configure() {
        if let recipeImage = recipeImage {
            recipeImageView.image = recipeImage
        }
        if let recipe = recipe {
            recipeTitle.text = recipe.name
            recipeLikesLabel.text = String(recipe.numberOfLikes)
            recipeTimeLabel.text = String(recipe.preparationTime) + "m"
        }
    }
}

extension RecipesDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let ingredients = recipe?.ingredientsDetails {
            return ingredients.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)

        if let ingredientsForRecipe = recipe?.ingredientsDetails[indexPath.row] {
            cell.textLabel?.text = ingredientsForRecipe
        }
        return cell
    }
}
