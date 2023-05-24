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
    
    private lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "night")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
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
        view.backgroundColor = .clear
    }
    
    private func addSubViews() {
        view.addSubview(backgroundImage)
    }
    
    private func setConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MainViewController: MainViewProtocol {
    
}
