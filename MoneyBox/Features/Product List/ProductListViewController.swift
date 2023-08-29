//
//  ProductListViewController.swift
//  MoneyBox
//
//  Created by George Woodham on 25/08/23.
//

import Combine
import MoneyBoxUI
import UIKit

class ProductListViewController: UIViewController {
    
    typealias Section = ProductListViewModel.Section
    typealias Item = ProductEntity
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    let viewModel: ProductListViewModel
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    private var dataSource: DataSource!
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = UIColor(named: "GreyColor")
        collectionView.backgroundColor = UIColor(named: "GreyColor")
        
        createLayout()
        setupCollectionView()
        configureDataSource()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchProducts()
    }
    
    private func createLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loading, .error:
                    break
                case .loaded(let products):
                    self?.updateSnapshot(products: products)
                }
            }
            .store(in: &bindings)
    }
}

// MARK: UICollectionView Setup & Delegate
extension ProductListViewController: UICollectionViewDelegate {
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.register(
            ProductCollectionCell.self,
            forCellWithReuseIdentifier: ProductCollectionCell.identifier
        )
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(60)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.interGroupSpacing = 8
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, viewItem in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ProductCollectionCell.identifier,
                    for: indexPath
                ) as? ProductCollectionCell
                cell?.configure(viewItem: viewItem)
                return cell
            }
        )
    }
    
    private func updateSnapshot(products: [Item]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.products])
        snapshot.appendItems(products)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.products[indexPath.item]
        let destination = ProductDetailViewController(viewModel: .init(product: product))
        navigationController?.pushViewController(destination, animated: true)
    }
}
