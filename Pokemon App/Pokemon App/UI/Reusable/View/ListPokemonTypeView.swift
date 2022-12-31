//
//  ListPokemonTypeView.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 23/11/22.
//

import UIKit

class ListPokemonTypeView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var pokemonTypeCollectionView: UICollectionView!
    @IBOutlet private weak var errorStackView: UIStackView!
    @IBOutlet private weak var loadingIndicatorView: UIActivityIndicatorView!
    
    private var listPokemonType: [PokemonType] = []
    private var isTypeSelected = false
    
    var tapToRetry: (() -> Void)?
    var tapPokemonType: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func bindResult(_ result: ListPokemonTypeResult) {
        switch result {
        case .loading(let isLoading):
            showLoading(isLoading)
            
        case .success(let listPokemonType):
            self.listPokemonType = listPokemonType
            DispatchQueue.main.async {
                self.isShowError(false)
                self.pokemonTypeCollectionView.reloadData()
            }
            
        case .failure(_):
            isShowError(true)
        }
    }
    
    func resetListPokemonType() {
        if !isTypeSelected {
            return
        }
        
        for (index, var pokemonType) in listPokemonType.enumerated() {
            if pokemonType.isFavorite {
                pokemonType.isFavorite = false
                listPokemonType[index] = pokemonType
            }
        }
        
        isTypeSelected = false
        
        DispatchQueue.main.async {
            self.pokemonTypeCollectionView.reloadData()
        }
    }
}

private extension ListPokemonTypeView {
    func commonInit() {
        Bundle.main.loadNibNamed("ListPokemonTypeView", owner: self)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        pokemonTypeCollectionView.delegate = self
        pokemonTypeCollectionView.dataSource = self
        pokemonTypeCollectionView.register(PokemonTypeCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonTypeCollectionViewCell.identifier)
        pokemonTypeCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func showLoading(_ isLoading: Bool) {
        loadingIndicatorView.isHidden = !isLoading
        errorStackView.isHidden = isLoading
        pokemonTypeCollectionView.isHidden = isLoading
        if isLoading {
            loadingIndicatorView.startAnimating()
        } else {
            loadingIndicatorView.stopAnimating()
        }
    }
    
    func isShowError(_ isError: Bool) {
        errorStackView.isHidden = !isError
        pokemonTypeCollectionView.isHidden = isError
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapToRetry))
        
        if isError {
            errorStackView.addGestureRecognizer(tapGesture)
        } else {
            errorStackView.removeGestureRecognizer(tapGesture)
        }
    }
    
    @objc func onTapToRetry() {
        tapToRetry?()
    }
    
    func updateCollectionViewCell(index: Int) {
        for (index, var pokemonType) in listPokemonType.enumerated() {
            if pokemonType.isFavorite {
                pokemonType.isFavorite = false
                listPokemonType[index] = pokemonType
            }
        }

        listPokemonType[index].isFavorite = true
        DispatchQueue.main.async {
            self.pokemonTypeCollectionView.reloadData()
        }
    }
}


extension ListPokemonTypeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateCollectionViewCell(index: indexPath.row)
        tapPokemonType?(listPokemonType[indexPath.row].title)
        isTypeSelected = true
    }
}

extension ListPokemonTypeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPokemonType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonTypeCollectionViewCell.identifier, for: indexPath) as! PokemonTypeCollectionViewCell
        
        cell.configure(type: listPokemonType[indexPath.row])
        
        return cell
    }
}
