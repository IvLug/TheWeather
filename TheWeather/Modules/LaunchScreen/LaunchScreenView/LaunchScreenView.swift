//
//  LaunchScreenView.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

protocol LaunchScreenViewProtocol: View {
    
}

final class LaunchScreenView: BaseViewController {
    
    var presenter: LaunchScreenPresenterProtocol!
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var sunImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "1d")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var cloudView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "5n")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setConstraints()
    }
    
    override func loadView() {
        super.loadView()
        startAnimate()
    }
    
    private func configure() {
        addSubViews()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
    }
    
    private func addSubViews() {
        view.addSubview(containerView)
        containerView.addSubview(sunImageView)
        containerView.addSubview(cloudView)
    }
    
    private func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        cloudView.snp.makeConstraints { make in
            make.height.equalTo(247)
            make.width.equalTo(307)
            make.edges.equalToSuperview()
        }
        sunImageView.snp.makeConstraints { make in
            make.height.equalTo(196)
            make.width.equalTo(216)
            make.leading.equalTo(105)
            make.top.equalToSuperview()
            make.trailing.equalTo(14)
        }
    }
}

extension LaunchScreenView {
    
    func startAnimate() {
        sunImageView.rotate()
    }
    
    func stopAnimate() {
        sunImageView.layer.removeAllAnimations()
    }
}

extension LaunchScreenView: LaunchScreenViewProtocol {
    
}
