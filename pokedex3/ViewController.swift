//
//  ViewController.swift
//  pokedex3
//
//  Created by k7user on 04/10/17.
//  Copyright © 2017 k7user. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var colletion: UICollectionView!
    var pokemons  = [pokemon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        colletion.dataSource = self
        colletion.delegate = self
        parsePokemonCSV()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokeCellCollectionViewCell{
            
            let pokemons = pokemon(name: "pokemon", pokedexId: indexPath.row)
            cell.configureCell(pokemon: pokemons)
            return cell

        }else {
            return UICollectionViewCell()
        }
        
    }
    func parsePokemonCSV()   {
        let Path = Bundle.main.path(forResource:"pokemon", ofType:"csv")!
        do{
            let csv = try CSV(contentsOfURL:Path)
            let row =  csv.rows
            print(row)
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30;
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
}

