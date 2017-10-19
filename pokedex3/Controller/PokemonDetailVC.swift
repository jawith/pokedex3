//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by k7user on 17/10/17.
//  Copyright © 2017 k7user. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var namelbl: UILabel!

    var pokemon: pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
namelbl.text = pokemon.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
