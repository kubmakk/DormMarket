//
//  ProfileVC.swift
//  DormMarket
//
//  Created by kubmakk on 18/2/26.
//
import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    let plusButton: UIButton = {
        let plusButton = UIButton(type: .contactAdd)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        return plusButton
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
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 250))
        headerView.addSubview(logoutButton)
        headerView.addSubview(plusButton)
        view.addSubview(tableView)

        logoutButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
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
        logoutButton.addTarget(self, action: #selector(buttonTapped), for: .touchDown)

    }
        
    @objc private func buttonTapped(){
        print("Кнопка нажата")
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
        print(items[indexPath.row])
    }
    
    
}
