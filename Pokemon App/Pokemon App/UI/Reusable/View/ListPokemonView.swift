//
//  ListPokemonUIView.swift
//  Pokemon App
//
//  Created by Mohammad Azri on 21/11/22.
//

import UIKit

class ListPokemonView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var pokemonCollectionView: UICollectionView!
    @IBOutlet private weak var errorStackView: UIStackView!
    @IBOutlet private weak var loadingIndicatorView: UIActivityIndicatorView!
    
    private let minItemWidth: CGFloat = 170
    private var listPokemon : [Pokemon] = []
    private var isPullToRefresh = false
    
    var refreshData : (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func bindResult(_ result: ListPokemonResult) {
        switch result {
            
        case .loading(let isLoading):
            showLoading(isLoading)
            
        case .success(let listPokemon):
            if isPullToRefresh {
                self.listPokemon = []
            }
            self.listPokemon.append(contentsOf: listPokemon)
            DispatchQueue.main.async {
                self.isShowError(false)
                self.pokemonCollectionView.reloadData()
            }
        case .failure(_):
            isShowError(true)
        }
    }
}


private extension ListPokemonView {
    
    func commonInit() {
        Bundle.main.loadNibNamed("ListPokemonView", owner: self)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        
        configureCollectionView()
        configureRefreshControl()
    }
    
    
    func configureCollectionView() {
        pokemonCollectionView.delegate = self
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        pokemonCollectionView.register(PokemonCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
    }
    
    func configureRefreshControl() {
        pokemonCollectionView.refreshControl = UIRefreshControl()
        pokemonCollectionView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    @objc func pullToRefresh() {
        isPullToRefresh = true
        refreshData?()
    }
    
    func isShowError(_ isError: Bool) {
        errorStackView.isHidden = !isError
        pokemonCollectionView.isHidden = isError
    }
    
    func showLoading(_ isLoading: Bool) {
        if isPullToRefresh {
            loadingIndicatorView.isHidden = true
            if isLoading {
                pokemonCollectionView.refreshControl?.beginRefreshing()
            } else {
                pokemonCollectionView.refreshControl?.endRefreshing()
            }
        } else {
            loadingIndicatorView.isHidden = !isLoading
            if isLoading {
                loadingIndicatorView.startAnimating()
            } else {
                loadingIndicatorView.stopAnimating()
            }
        }
    }
}

extension ListPokemonView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pokemonCollectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ListPokemonView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell
        
        cell.configure(with: listPokemon[indexPath.row].images.small)
        
        return cell
    }
}

extension ListPokemonView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: estimateWidth(), height: estimateWidth() * 1.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
    
    func estimateWidth() -> CGFloat {
        let cellCount = floor(CGFloat(self.frame.width / minItemWidth))
        let margin = CGFloat(8 * 2)
        let width = ((self.frame.width - margin * (cellCount - 1) - margin) / cellCount)
        
        return width
    }
}
