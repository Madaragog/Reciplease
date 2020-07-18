//
//  IngredientsViewController.swift
//  Reciplease
//
//  Created by Cedric on 28/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import UIKit

class IngredientsViewController: UIViewController {
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var addIngredientsButton: UIButton!
    @IBOutlet weak var clearIngredientsButton: UIButton!
    @IBOutlet weak var searchForRecipes: UIButton!
    @IBOutlet weak var ingredientsList: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTextField.setUnderLine()
        setPlaceholder()
        addIngredientsButton.addBorder(borderCornerRadius: 4)
        clearIngredientsButton.addBorder(borderCornerRadius: 4)
        searchForRecipes.addBorder(borderCornerRadius: 4)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ingredientsList.reloadData()
    }
// calls RemoveKeyboard
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        removeKeyboard()
    }
// add an ingredient to ingredientsList or displays an error message if wrong entry
    @IBAction func tappedAddButton() {
        removeKeyboard()
        if ingredientTextField.text == "" {
            ingredientTextField.placeholder = "Add an ingredient "
        } else if let name = ingredientTextField.text {

            let ingredient = IngredientAdded(name: name)

            IngredientsService.shared.add(ingredient: ingredient)

            ingredientsList.reloadData()
        }
    }
// clears ingredientsList
    @IBAction func tappedClearButton() {
        IngredientsService.shared.removeAll()
        ingredientsList.reloadData()
    }
// calls get recipes the performs a segue or shows an error if the latter occurs
    @IBAction func tappedSearchForRecipesButton(_ sender: UIButton) {
        showActivityIndicatorAndHideButtonOrTheReverse(hideButton: true)
        RecipeRequestService.shared.getRecipes { (recipes) in
            if recipes != nil {
                self.performSegue(withIdentifier: "RecipeListSegue", sender: nil)
            } else {
                self.ingredientTextField.text = ""
                self.ingredientTextField.placeholder = "Error, please retry"
            }
            self.showActivityIndicatorAndHideButtonOrTheReverse(hideButton: false)
        }
    }

    private func showActivityIndicatorAndHideButtonOrTheReverse(hideButton: Bool) {
        searchForRecipes.isHidden = hideButton
        activityIndicator.isHidden = !hideButton
    }

    // Removes the keyboard if displayed
    private func removeKeyboard() {
        if ingredientTextField.isFirstResponder == true {
            ingredientTextField.resignFirstResponder()
        }
    }

    private func setPlaceholder() {
        ingredientTextField.attributedPlaceholder = NSAttributedString(
        string: "Lemon, Cheese, Sausages...",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)])
    }
}

extension UITextField {
//    adds an underline to a UITextField
    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,
                              width: self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension IngredientsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IngredientsService.shared.ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)

        let ingredient = IngredientsService.shared.ingredients[indexPath.row]

        cell.textLabel?.text = ingredient.name

        return cell
    }
}
