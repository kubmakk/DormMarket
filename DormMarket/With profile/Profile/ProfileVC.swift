//
//  ProfileVC.swift
//  DormMarket
//
//  Created by kubmakk on 18/2/26.
//
import UIKit
import SnapKit

class ProfileViewController: UIViewController, ThemeUpdatable {
    
    var isLoading = false
    
    weak var coordinator: ProfileCoordinator?
    var product: [Products] = []
    //MARK: - Objects
    
    private let userAvatar: UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "dormmarket")
        avatar.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        avatar.layer.cornerRadius = 25
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        return avatar
    }()
    
    private let profileButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "UserName"
        config.image = UIImage(named: "chevron.right")
        config.imagePlacement = .trailing
        config.imagePadding = 5
        config.contentInsets = .zero
        config.baseForegroundColor = .black
        let bth = UIButton(configuration: config)
        return bth
    }()
        
    
    private let settingsBth = UIButton(configuration: .dormMarketCapsule(systemName: "gear"))
    
    private let categories: UIStackView = {
       var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        
        return stack
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInterface()
        fetch()
        title = "Hi There"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()
    }
    // MARK: Functions

    func createOrthogonalSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(200)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous

        return section
    }

    func fetch() {
        fetchData {[weak self] downloadProducts in
            DispatchQueue.main.async {
                self?.product = downloadProducts
                self?.tableView.reloadData()
            }
        }
    }

    func loadMore() {
        guard !isLoading else {return}
        isLoading = true

        fetchData {[weak self] newItems in
            self?.product.append(contentsOf: newItems)
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.tableView.reloadData()
            }

        }
    }

    func setupUI() {
    }

    @objc private func buttonTapped() {
        HapticVibro.vibrate(style: .rigid)
        coordinator?.onLogout()
    }

}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let products = product[indexPath.row]
        cell.textLabel?.text = products.title
        let isDark = UserSettings.shared.isDarkModeEnabled
        cell.backgroundColor = isDark ? .black : .white
        cell.textLabel?.textColor = isDark ? .white : .black
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticVibro.vibrate(style: .light)
        print(product[indexPath.row])
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == product.count - 1 {
            loadMore()
        }
    }

}
