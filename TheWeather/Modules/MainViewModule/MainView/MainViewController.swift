//
//  MainViewController.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

protocol MainViewProtocol: View {
    
}

class MainViewController: BaseViewController {
    
    var presenter: MainPresenterProtocol!
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()
        label.text = "Hello"
        
        view.backgroundColor = .white
        
        showAlert(title: "123", okAction: { action in
            print(123)
        })
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configure() {
        addSubViews()
    }
    
    private func addSubViews() {
        view.addSubview(label)
    }
    
    private func setConstraints() {
        
    }

}

extension MainViewController: MainViewProtocol {
    
}
