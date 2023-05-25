//
//  ForecastViewController.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit

protocol ForecastViewProtocol: View {
    func updateData()
}

class ForecastViewController: BaseViewController {
    
    var presenter: ForecastPresenterProtocol!
    
    private lazy var locationView: LocationView = {
        let view = LocationView()
        return view
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "morning")
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .brandTintColorGray.withAlphaComponent(0.4)
        view.layer.cornerRadius = 12
        view.separatorStyle = .none
        view.register(cellWithClass: ForecastTableViewCell.self)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isScrollEnabled = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter.viewDidLoad()
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
    }
    
    private func addSubViews() {
        view.addSubview(backgroundImage)
        view.addSubview(locationView)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        locationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.left.equalToSuperview().inset(16)
        }
        
        let height = 7 * 42
        tableView.snp.makeConstraints {
            $0.width.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(120)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(height)
        }
    }
}

//TODO: UITableViewDelegate
extension ForecastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//TODO: UITableViewDataSource
extension ForecastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.forecastWeatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ForecastTableViewCell = tableView.dequeueCell(at: indexPath)
        
        let model = presenter.forecastWeatherData[indexPath.row]
        cell.setData(model: model)
        return cell
    }
}

extension ForecastViewController: ForecastViewProtocol {
    
    func updateData() {
        tableView.reloadData()
    }
}
