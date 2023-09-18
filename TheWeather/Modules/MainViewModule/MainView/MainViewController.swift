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

    private lazy var rectangle: UIView = {
        let view = UIView()

        view.backgroundColor = .black
        return view
    }()

    private lazy var rectangleButton: UIButton = {
        let view = UIButton()
        view.setTitle("Change Position", for: .normal)
        view.addTarget(self, action: #selector(changePosition), for: .touchUpInside)
        return view
    }()

//    private lazy var searchInput: CustomSearchInput = {
//        let view = CustomSearchInput(
//            placeholder: "City Name") { [weak presenter] text in
//                presenter?.searchData = text
//            } searchTapped: { [weak presenter] in
//                presenter?.search()
//            }
//        view.isUserInteractionEnabled = true
//        return view
//    }()

//    private lazy var locationView: LocationView = {
//        let view = LocationView()
//        return view
//    }()
//
//    private lazy var descriptionWeatherView: DescriptionWeatherView = {
//        let view = DescriptionWeatherView()
//        return view
//    }()

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
        backgroundImage.addSubview(rectangle)

        view.addSubview(rectangleButton)
//        view.addSubview(searchInput)
//        view.addSubview(locationView)
//        view.addSubview(descriptionWeatherView)
    }

    private func setConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        rectangle.snp.makeConstraints {
            $0.width.height.equalTo(100)
//            $0.left.equalTo(145)
//            $0.top.equalTo(372)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        rectangleButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(60)

            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(100)
        }

//        searchInput.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
//            $0.leading.equalToSuperview().inset(16)
//        }
//
//        descriptionWeatherView.snp.makeConstraints {
//            $0.top.equalTo(searchInput.snp.bottom).offset(16)
//            $0.left.equalToSuperview().inset(16)
//        }
//
//        locationView.snp.makeConstraints {
//            $0.top.equalTo(descriptionWeatherView.snp.bottom).offset(16)
//            $0.left.equalToSuperview().inset(16)
//        }
    }

    @objc func changePosition() {
        print("bounts \(rectangle.bounds)")
        print("frame \(rectangle.frame)")

        print("parrents frame: \(view.frame) - bouns: \(view.bounds)")
//
//        UIView.animate(withDuration: 0.3) {
//            self.rectangle.transform = CGAffineTransform(rotationAngle: 0.5)
//        } completion: { _ in
//            print("---bounts \(self.rectangle.bounds)")
//            print("---frame \(self.rectangle.frame)")
//        }
    }
}

// MARK: MainViewProtocol
extension MainViewController: MainViewProtocol {

    func updateData() {
//        guard let model = presenter.weatherData else {
//            descriptionWeatherView.setMocData()
//            locationView.setMocData()
//            backgroundImage.image = UIImage(named: "day")
//            return
//        }
//
//        descriptionWeatherView.setData(model: model)
//        locationView.setData(model: model)
//
//        let peripd = Date().getDayPeriod(
//            timezone: model.timezone ?? "",
//            sunrise: model.sunrise ?? "",
//            sunset: model.sunset ?? "")
//        backgroundImage.image = UIImage(named: peripd.rawValue)
    }
}
