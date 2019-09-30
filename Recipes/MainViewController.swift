//
//  MainViewController.swift
//  Recipes
//
//  Created by Austin Potts on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    let recipesNetworkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet{
            filterRecipes()
        }
    }
    
    
    
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    
    
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
            
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesNetworkClient.fetchRecipes { (recipe, error) in
            if let error = error {
                NSLog("error:\(error)")
                return
            } else {
                guard let recipe = recipe else{return}
                self.allRecipes = recipe
            }
            
            
        }

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func searchField(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes(){
        guard let searchTerm = searchTextField.text else {return}
            filteredRecipes = allRecipes
        
            
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableSegue" {
            guard let segueVC = segue.destination as? RecipesTableViewController else{return}
            
          //segueVC.recipes = recipesTableViewController
        }
    
        
    }
    

}
