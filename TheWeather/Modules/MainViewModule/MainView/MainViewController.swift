//
//  MainViewController.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

protocol MainViewProtocol: View {
    func updateData()
}

class MainViewController: BaseViewController {
    
    var presenter: MainPresenterProtocol!
    
    private lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "morning")
        return view
    }()
    
    private lazy var searchInput: CustomSearchInput = {
        let view = CustomSearchInput(
            placeholder: "City Name") { text in
                print(text)
            } searchTapped: {
                print("Search")
            }
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var locationView: LocationView = {
        let view = LocationView()
        return view
    }()
    
    private lazy var descriptionWeatherView: DescriptionWeatherView = {
        let view = DescriptionWeatherView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configure()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func configure() {
        addSubViews()
        view.backgroundColor = .clear
        hideKeyboardWhenTappedAround()
    }
    
    private func addSubViews() {
        view.addSubview(backgroundImage)
        view.addSubview(searchInput)
        view.addSubview(locationView)
        view.addSubview(descriptionWeatherView)
    }
    
    private func setConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchInput.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        descriptionWeatherView.snp.makeConstraints {
            $0.top.equalTo(searchInput.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
        }
        
        locationView.snp.makeConstraints {
            $0.top.equalTo(descriptionWeatherView.snp.bottom).offset(16)
            $0.left.equalToSuperview().inset(16)
        }
    }
}

//TODO: MainViewProtocol
extension MainViewController: MainViewProtocol {
    
    func updateData() {
        guard let model = presenter.weatherData else { return }
        
        descriptionWeatherView.setData(model: model)
        locationView.setData(model: model)
        
        let peripd = Date().getDayPeriod(
            timezone: model.timezone ?? "",
            sunrise: model.sunrise ?? "",
            sunset: model.sunset ?? "")
        backgroundImage.image = UIImage(named: peripd.rawValue)
    }
}
