//
//  ProfileVC.swift
//  DormMarket
//
//  Created by kubmakk on 18/2/26.
//
import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tableView = UITableView()
    let posts = [
            "Мой первый день в iOS разработке 🚀",
            "Изучаю таблицы. Оказывается, это не так сложно!",
            "Сегодня разобрался с tableHeaderView",
            "Пишу свой собственный Instagram...",
            "Пост номер 5",
            "Пост номер 6",
            "Пост номер 7 (чтобы таблица точно скроллилась)"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "My profile"
        setupTableView()
        setupHeader()
    }
    
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupHeader(){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 250))
        headerView.backgroundColor = .purple
        
        let avatarSize: CGFloat = 100
        let avatarX = (view.frame.width - avatarSize) / 2
        let avatarView = UIView(frame: CGRect(x: avatarX, y: 40, width: avatarSize, height: avatarSize))
        avatarView.backgroundColor = .blue
        avatarView.layer.cornerRadius = avatarSize / 2
        headerView.addSubview(avatarView)
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 150, width: view.frame.width, height: 30))
        nameLabel.text = "Hi there"
        nameLabel.textAlignment = .center
        nameLabel.font = .boldSystemFont(ofSize: 24)
        headerView.addSubview(nameLabel)
        
        tableView.tableHeaderView = headerView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("Пользователь нажал на ячейку \(posts[indexPath.row])")
    }

}
