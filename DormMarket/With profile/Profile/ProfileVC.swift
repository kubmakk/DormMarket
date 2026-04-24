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
        avatar.layer.cornerRadius = 25
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        avatar.backgroundColor = .systemGray6
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
    
    
    // 1. Экшены остаются lazy (не забудь [weak self])
    lazy var action1 = UIAction(title: "DarkMode", image: UIImage(systemName: "moon")) { [weak self] _ in
        UserSettings.shared.isDarkModeEnabled = true
        self?.updateInterface()
    }

    lazy var action2 = UIAction(title: "WhiteMode", image: UIImage(systemName: "sun.max")) { [weak self] _ in
        UserSettings.shared.isDarkModeEnabled = false
        self?.updateInterface()
    }

    // 2. Кнопку тоже делаем lazy var и инициализируем через замыкание
    lazy var settingsBth: UIButton = {
        let button = UIButton(configuration: .dormMarketCapsule(systemName: "gear"))
        // Теперь здесь можно обращаться к action1 и action2
        button.menu = UIMenu(title: "Options", children: [action1, action2])
        button.showsMenuAsPrimaryAction = true // Чтобы меню открывалось сразу по нажатию
        return button
    }()
    
//    private lazy var settingsBth: UIButton = {
//        let button = UIButton(configuration: .dormMarketCapsule(systemName: "gear"))
//        
//        button.addAction(UIAction { [weak self] _ in
//            // 1. Просто вызываем fetch.
//            // reloadData внутри него сам обновит таблицу, когда данные придут.
//            self?.fetch()
//            print("Fetching started...")
//            HapticVibro.vibrate(style: .light)
//            
//        }, for: .touchUpInside)
//        
//        return button
//    }()

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInterface()
        fetch()
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
                await MainActor.run{
                    self.isLoading = false
                }
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
        headerView.addSubview(settingsBth)
        headerView.addSubview(userAvatar)
        headerView.addSubview(profileButton)
        
        userAvatar.snp.makeConstraints{ make in
            make.top.leading.equalToSuperview().inset(16)
            make.size.equalTo(50)
        }
        
        profileButton.snp.makeConstraints{ make in
            make.centerY.equalTo(userAvatar.snp.centerY)
            make.leading.equalTo(userAvatar.snp.trailing).offset(12)
        }
        settingsBth.snp.makeConstraints{make in
            make.top.trailing.equalToSuperview().inset(16)
        }
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DormTableCell else {
            return UITableViewCell()
        }
        let isDark = UserSettings.shared.isDarkModeEnabled
        let products = product[indexPath.row]
        cell.configure(
                with: products.userId,
                title: products.title,
                bodyText: products.body,
                imageCenter: products.image,
                imageAvatar: products.useridImage, isDark: isDark
            )
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
