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

    let plusButton: UIButton = {
        var config = UIButton.Configuration.filled()
            config.image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        config.baseBackgroundColor = .systemRed
            config.baseForegroundColor = .white
            config.cornerStyle = .capsule
            config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)

        let button = UIButton(configuration: config)

            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 4)
            button.layer.shadowOpacity = 0.2
            button.layer.shadowRadius = 8
            return button
    }()

    private let logoutButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Exit"
        config.baseBackgroundColor = .systemRed
        config.baseForegroundColor = .black
        config.cornerStyle = .large
        let button = UIButton(configuration: config, primaryAction: nil)

        return button
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

        let headerWidth = view.frame.width > 0 ? view.frame.width : UIScreen.main.bounds.width
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: headerWidth, height: 250))

        headerView.addSubview(logoutButton)
        headerView.addSubview(plusButton)
        view.addSubview(tableView)

        logoutButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }

        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        plusButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }

        let action1 = UIAction(title: "DarkMode", image: UIImage(systemName: "photo")) { _  in
            UserSettings.shared.isDarkModeEnabled = true
            self.updateInterface()
        }
        let action2 = UIAction(title: "WhiteMode", image: UIImage(systemName: "doc")) { _ in
            UserSettings.shared.isDarkModeEnabled = false
            self.updateInterface()
        }

        plusButton.menu = UIMenu(title: "Options", children: [action1, action2])
        plusButton.showsMenuAsPrimaryAction = true

        tableView.tableHeaderView = headerView

        logoutButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

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
