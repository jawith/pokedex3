//
//  ViewController.swift
//  pokedex3
//
//  Created by k7user on 04/10/17.
//  Copyright © 2017 k7user. All rights reserved.
//

import UIKit
import  AVFoundation
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var colletion: UICollectionView!
    var pokemons  = [pokemon]()
    var filteredPokemon = [pokemon]()
    var musicPlayer : AVAudioPlayer!
     var inSearchMode = false
    override func viewDidLoad() {
        super.viewDidLoad()
        colletion.dataSource = self
        colletion.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSV()
        initAudio()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            musicPlayer = try  AVAudioPlayer(contentsOf: URL(string:path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokeCellCollectionViewCell{
            
            let poke : pokemon!
            if inSearchMode{
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
            }else{
                poke = pokemons[indexPath.row]
                cell.configureCell(pokemon: poke)
            }
            return cell
        }else {
            return UICollectionViewCell()
        }
        
    }
    func parsePokemonCSV()   {
        let Path = Bundle.main.path(forResource:"pokemon", ofType:"csv")!
        do{
            let csv = try CSV(contentsOfURL:Path)
            let rows =  csv.rows
            print(rows)
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = pokemon(name: name, pokedexId: pokeId)
                pokemons.append(poke)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: pokemon!
        if inSearchMode{
            poke = filteredPokemon[indexPath.row];
        }
        else{
            poke = pokemons[indexPath.row]
        }
        performSegue(withIdentifier: "PokemondeteilVC", sender: poke)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredPokemon.count
        }
        return pokemons.count;
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            sender.alpha = 0.2
        }
        else{
            musicPlayer.play()
            sender.alpha = 0.1

        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            colletion.reloadData()
            view.endEditing(true)
        } else{
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemons.filter({$0.name.range(of: lower) != nil})
            colletion.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemondeteilVC" {
            if let detailVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? pokemon{
                    detailVC.pokemon = poke
                }
            }
        }
    }
}


