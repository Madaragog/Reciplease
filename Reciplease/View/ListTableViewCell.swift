//
//  CacheRecipesListTableViewCell.swift
//  Reciplease
//
//  Created by Cedric on 22/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeInfoStackView: UIStackView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDetailLabel: UILabel!
    @IBOutlet weak var recipeLikesAndTimeView: UIView!
    @IBOutlet weak var recipeLikesAndTimeStackView: UIStackView!
    @IBOutlet weak var recipeLikesStackView: UIStackView!
    @IBOutlet weak var recipeLikesLabel: UILabel!
    @IBOutlet weak var recipeLikesIcon: UIImageView!
    @IBOutlet weak var recipeTimeStackView: UIStackView!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    @IBOutlet weak var recipeTimeIcon: UIImageView!

    var recipeUrl = ""
    var recipeImageUrl = ""
    var recipeImage: UIImage?

    override func awakeFromNib() {
        super.awakeFromNib()
        recipeImageView.addShadow(yValue: 63, height: 65, color: UIColor.black.cgColor)
        recipeLikesAndTimeView.addViewBorder(borderColor: #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), borderWith: 1.0, borderCornerRadius: 4)
    }
// gets the recipe image and prepares the cell
    func configure(recipe: RecipeAdded) {
        RecipeRequestService.shared.getImage(imageUrl: recipe.imageUrl) { (downloadedImage) in
            if let downloadedImage = downloadedImage {
                self.recipeImageView.image = UIImage(data: downloadedImage)
                self.recipeImage = UIImage(data: downloadedImage)
            } else {
                self.recipeImageView.image = UIImage(named: "DefaultRecipeImage")
                self.recipeImage = UIImage(named: "DefaultRecipeImage")
            }
        }
        recipeTitleLabel.text = recipe.name
        recipeDetailLabel.text = "\(recipe.ingredientsDetails[0]) ..."
        let recipeLikes = String(recipe.numberOfLikes)
        recipeLikesLabel.text = " \(recipeLikes)"
        recipeLikesIcon.image = UIImage(named: "LikesIcon")
        let time = String(recipe.preparationTime)
        recipeTimeLabel.text = " \(time)m"
        recipeTimeIcon.image = UIImage(named: "TimeIcon")
        recipeUrl = recipe.originalRecipeUrl
        recipeImageUrl = recipe.imageUrl
    }
}

extension UIView {
//    adds a border with color and ajustable width to a UIView
    public func addViewBorder(borderColor: CGColor, borderWith: CGFloat, borderCornerRadius: CGFloat) {
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = borderCornerRadius

    }
// adds simple border to a UIView
    public func addBorder(borderCornerRadius: CGFloat) {
        self.layer.cornerRadius = borderCornerRadius
    }
// adds a shadow to a UIView
    public func addShadow(yValue: Int, height: Int, color: CGColor) {
        let colorTop = UIColor.clear.cgColor
        let colorBottom = color
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: yValue, width: 500, height: height)
        layer.colors = [colorTop, colorBottom]
        self.layer.addSublayer(layer)
    }
}
