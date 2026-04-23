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
        tableView.register(DormTableCell.self, forCellReuseIdentifier: "cell")
        setupUI()
        
    }
    // MARK: Functions

    func fetch() {
        guard !isLoading else {return}
        isLoading = true
        
        Task {
            do {
                let fetchData: [Products] = try await NetworkManager.shared.fetchData(endpoint: .posts)
                
                await MainActor.run {
                    self.product = fetchData
                    self.isLoading = false
                    self.tableView.reloadData()
                }
            } catch {
                print("loadContent error: \(error)")
                self.isLoading = false
            }
        }
    }

    func loadMore() {
        guard !isLoading else {return}
        isLoading = true
        
        Task {
            do {
                let fetchData: [Products] = try await NetworkManager.shared.fetchData(endpoint: .posts)
                
                await MainActor.run {
                    self.product.append(contentsOf: fetchData)
                    self.isLoading = false
                    self.tableView.reloadData()
                }
            } catch {
                print("loadContent error: \(error)")
                self.isLoading = false
            }
        }
    }

    func setupUI() {
        let screenWidth = view.window?.windowScene?.screen.bounds.width ?? 0
        let headerWidth = view.frame.width > 0 ? view.frame.width : screenWidth
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: headerWidth, height: 200))
        headerView.backgroundColor = .systemBlue 
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.tableHeaderView = headerView
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DormTableCell
        let products = product[indexPath.row]
        cell.configure(with: products.title)
//        let isDark = UserSettings.shared.isDarkModeEnabled
//        cell.backgroundColor = isDark ? .black : .white
//        cell.textLabel?.textColor = isDark ? .white : .black
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
