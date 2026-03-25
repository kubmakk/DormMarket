//
//  ProfileVC.swift
//  DormMarket
//
//  Created by kubmakk on 18/2/26.
//
import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    
    let plusButton: UIButton = {
        var config = UIButton.Configuration.filled()
            config.image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        config.baseBackgroundColor = .systemRed
            config.baseForegroundColor = .white
            config.cornerStyle = .capsule // Овальная форма сейчас в моде
            config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
            
        let button = UIButton(configuration: config)
            // Добавляем тень для глубины (тренд 2026)
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
        table.backgroundColor = .white
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let items = [
        "item1",
        "item2",
        "item3",
        "item4"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hi There"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        // Fix: Use UIScreen or a safe default width because view.frame.width might be 0 here.
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
        
        let action1 = UIAction(title: "Добавить фото", image: UIImage(systemName: "photo")) { _ in
            print("Action 1")
        }
        let action2 = UIAction(title: "Добавить файл", image: UIImage(systemName: "doc")) { _ in
            print("Action 2")
        }
        
        plusButton.menu = UIMenu(title: "Options", children: [action1, action2])
        plusButton.showsMenuAsPrimaryAction = true
        
        tableView.tableHeaderView = headerView
        
        logoutButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

    }
        
    @objc private func buttonTapped(){
        HapticVibro.vibrate(style: .rigid)
        coordinator?.onLogout()
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticVibro.vibrate(style: .light)
        print(items[indexPath.row])
    }
    
}
