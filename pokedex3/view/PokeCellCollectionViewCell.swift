//
//  PokeCellCollectionViewCell.swift
//  pokedex3
//
//  Created by k7user on 14/10/17.
//  Copyright © 2017 k7user. All rights reserved.
//

import UIKit

class PokeCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    //corener radius
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    var pokemon : pokemon!
    func configureCell(pokemon: pokemon){
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named:"\(self.pokemon.pokedexId)")
    }
}
