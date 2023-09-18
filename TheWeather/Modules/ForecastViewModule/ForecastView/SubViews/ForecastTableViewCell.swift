//
//  ForecastTableViewCell.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {

    private lazy var weatherImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        view.image = UIImage(systemName: "wind")
        return view
    }()

    private lazy var weatherTemp: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "19.1°"
        view.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return view
    }()

    private lazy var weatherDay: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "May 24, Wed, 11:24 AM"
        view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return view
    }()

    private lazy var deviderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        weatherDay.text = ""
        weatherTemp.text = ""
        weatherImage.image = nil
    }

    private func configure() {
        addSubViews()
        setConstraints()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }

    private func addSubViews() {
        contentView.addSubview(weatherDay)
        contentView.addSubview(weatherImage)
        contentView.addSubview(weatherTemp)
        contentView.addSubview(deviderView)
    }

    private func setConstraints() {
        weatherDay.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.height.equalTo(30)
            $0.left.equalToSuperview().inset(16)
        }

        weatherImage.snp.makeConstraints {
            $0.left.equalTo(weatherDay.snp.right).offset(6)
            $0.height.width.equalTo(30)
            $0.top.bottom.equalToSuperview().inset(6)
        }

        weatherTemp.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.left.equalTo(weatherImage.snp.right).offset(16)
            $0.centerY.equalToSuperview()
        }

        deviderView.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}

extension ForecastTableViewCell {

    func setData(model: WeatherForecast) {
        let imageName = model.weather?.getIcon()

        weatherImage.image = UIImage(systemName: imageName ?? "")
        weatherTemp.text = "\(model.temp ?? 0)°"
        weatherDay.text = Date().formateDate(timestamp: model.ts ?? 0)

    }
}
