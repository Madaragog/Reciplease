//
//  CacheRecipesListTableViewCell.swift
//  Reciplease
//
//  Created by Cedric on 22/06/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import UIKit

class CacheRecipesListTableViewCell: UITableViewCell {
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

    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
        recipeLikesAndTimeView.addViewBorder(borderColor: #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), borderWith: 1.0, borderCornerRadius: 4)
    }
// swiftlint:disable function_parameter_count
    func configure(recipe: RecipeAdded, recipeTitle: String, recipeDetail: String,
                   recipeLikesNumber: Int, recipeLikesImage: String, recipeTime: Int,
                   recipeTimeImage: String) {
        RecipeRequestService.shared.getImage(imageUrl: recipe.imageUrl) { (downloadedImage) in
            if let downloadedImage = downloadedImage {
                self.recipeImageView.image = UIImage(data: downloadedImage)
            } else {
                self.recipeImageView.image = UIImage(named: "DefaultRecipeImage")
            }
        }
        recipeTitleLabel.text = recipeTitle
        recipeDetailLabel.text = "\(recipeDetail) ..."
        let recipeLikes = String(recipeLikesNumber)
        recipeLikesLabel.text = " \(recipeLikes)"
        recipeLikesIcon.image = UIImage(named: recipeLikesImage)
        let time = String(recipeTime)
        recipeTimeLabel.text = " \(time)m"
        recipeTimeIcon.image = UIImage(named: recipeTimeImage)
    }

    private func addShadow() {
        let colorTop = UIColor.clear.cgColor
        let colorBottom = UIColor.black.cgColor
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 63, width: .max, height: 65)
        layer.colors = [colorTop, colorBottom]
//        layer.locations = [0.0, 0.5]
        recipeImageView.layer.addSublayer(layer)
    }
}

extension UIView {
    public func addViewBorder(borderColor: CGColor, borderWith: CGFloat, borderCornerRadius: CGFloat) {
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = borderCornerRadius

    }
}
