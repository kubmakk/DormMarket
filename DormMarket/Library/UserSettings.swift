//
//  UserSettings.swift
//  DormMarket
//
//  Created by kubmakk on 04.04.2026.
//

import Foundation
import UIKit

class UserSettings {
    static let shared = UserSettings()

    private let defaults = UserDefaults.standard

    private enum Keys {
        static let isDarkModeEnabled = "isDarkModeEnabled"
        static let fontSize = "fontSize"
        static let isLogin = "isLogin"
    }

    var isDarkModeEnabled: Bool {
        get { return defaults.bool(forKey: Keys.isDarkModeEnabled) }
        set { defaults.set(newValue, forKey: Keys.isDarkModeEnabled) }
    }

    var fontSize: Double {
        get {
            return defaults.double(forKey: Keys.fontSize) == 0 ? 14 : defaults.double(forKey: Keys.fontSize)
        }
        set {
            defaults.set(newValue, forKey: Keys.fontSize)
        }
    }
    
    var isLogin: Bool{
        get{
            return defaults.bool(forKey: Keys.isLogin)
        }
        set{
            defaults.set(newValue, forKey: Keys.isLogin)
        }
    }

}

protocol ThemeUpdatable {
    func updateInterface()
}

extension ThemeUpdatable where Self: UIViewController {
    func updateInterface() {
        let isDark = UserSettings.shared.isDarkModeEnabled
        let bgColor: UIColor = isDark ? .black : .white

        view.backgroundColor = bgColor

        if let tableView = view.subviews.first(where: { $0 is UITableView }) as? UITableView {
            tableView.backgroundColor = bgColor
            tableView.reloadData()
        }
    }
}
