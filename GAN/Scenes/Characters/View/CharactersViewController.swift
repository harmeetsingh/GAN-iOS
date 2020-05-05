//
//  ViewController.swift
//  GAN
//
//  Created by Harmeet Singh on 03/05/2020.
//  Copyright © 2020 Harmeet Singh. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

class CharactersViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet var filterLabel: UILabel!
    @IBOutlet var resultsCountLabel: UILabel!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var seasonsCollectionView: UICollectionView!
    @IBOutlet var charactersCollectionView: UICollectionView!

    var viewModel: CharactersViewModelType!
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        bind(viewModel.outputs)
        bind(viewModel.inputs)
        viewModel.inputs.load()
    }

    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search characters"
        navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }

    // MARK: - UI

    func bind(_ outputs: CharactersViewModelOutputs) {

        outputs.isLoading
            .bind(to: loadingView.reactive.isVisible)
            .dispose(in: disposeBag)
        
        outputs.errorAlert
            .bind(to: reactive.alertViewModel)
            .dispose(in: disposeBag)

        outputs.characterCellViewModels
            .bind(to: charactersCollectionView) { viewModels, indexPath, collectionView in
                let cell = collectionView.dequeueCell(of: CharacterCollectionViewCell.self, for: indexPath)
                cell.viewModel = viewModels[indexPath.row]
                return cell
            }.dispose(in: disposeBag)
        
        outputs.seasonsCellViewModels
            .bind(to: seasonsCollectionView) { viewModels, indexPath, collectionView in
                let cell = collectionView.dequeueCell(of: SeasonsCollectionViewCell.self, for: indexPath)
                cell.viewModel = viewModels[indexPath.row]
                return cell
            }.dispose(in: disposeBag)

        outputs.filter
            .bind(to: filterLabel.reactive.text)
            .dispose(in: disposeBag)
        
        outputs.resultsCount
            .bind(to: resultsCountLabel.reactive.text)
            .dispose(in: disposeBag)
    }
    
    func bind(_ inputs: CharactersViewModelInputs) {
        
        seasonsCollectionView.reactive.selectedItemIndexPath.observeNext { indexPath in
            inputs.filter(with: indexPath.row)
        }.dispose(in: disposeBag)
        
        charactersCollectionView.reactive.selectedItemIndexPath.observeNext { indexPath in
            inputs.select(indexPath.row)
        }.dispose(in: disposeBag)
        
        filterButton.reactive.tap
            .observeNext { _ in
                inputs.resetFilter()
            }.dispose(in: disposeBag)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
        indexPath: IndexPath) -> CGSize {
    
        let width = (UIScreen.main.bounds.width / 2) - 5
        return CGSize(width: width, height: 200)
    }
}

// MARK: - UISearchControllerDelegate

extension CharactersViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.inputs.search(searchController.searchBar.text)
    }
}
