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

    let requestService = RequestService()

    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTextField.setUnderLine()
        setPlaceholder()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ingredientsList.reloadData()
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        removeKeyboard()
    }

    @IBAction func tappedAddButton() {
        removeKeyboard()
        if ingredientTextField.text == "" {
            ingredientTextField.text = "Add an ingredient "
        } else {
            guard let name = ingredientTextField.text else {
                return
            }
            let ingredient = Ingredient(name: name)

            IngredientsService.shared.add(ingredient: ingredient)

            ingredientsList.reloadData()
        }
    }

    @IBAction func tappedClearButton() {
        IngredientsService.shared.removeAll()
        ingredientsList.reloadData()
    }

    @IBAction func tappedSearchForRecipesButton(_ sender: UIButton) {
        requestService.request()
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
