//
//  pokemon.swift
//  pokedex3
//
//  Created by k7user on 13/10/17.
//  Copyright © 2017 k7user. All rights reserved.
//

import Foundation
class pokemon{
    
    private var _name: String!
    private var _pokedexId: Int!
    var name :String {
        return _name
    }
    var pokedexId :Int{
        return _pokedexId
    }
    
    init(name:String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}
