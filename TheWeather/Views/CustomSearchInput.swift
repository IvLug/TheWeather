//
//  CustomSearchInput.swift
//  TheWeather
//
//  Created by Иван Луганцов on 24.05.2023.
//

import UIKit

final class CustomSearchInput: UIView {

    private var searchTappedVoid: EmptyClosure?
    private var onTextEditingChange: TextFieldVoid?

    private lazy var searchInput: UITextField = {
        let view = UITextField()
        view.backgroundColor = .clear
        view.tintColor = .white
        view.textColor = .white
        view.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        return view
    }()

    private lazy var searchButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        view.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        view.tintColor = .white
        return view
    }()

    private lazy var deviderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    convenience init(
        placeholder: String,
        onTextEditingChange: TextFieldVoid? = nil,
        searchTapped: EmptyClosure? = nil
    ) {
        self.init(frame: .zero)
        searchInput.placeholder = placeholder
        searchInput.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        backgroundColor = .brandTintColorGray.withAlphaComponent(0.4)
        layer.cornerRadius = 12
        self.onTextEditingChange = onTextEditingChange
        self.searchTappedVoid = searchTapped
        configure()
    }

    private func configure() {
        addSubViews()
        setConstraints()
    }

    private func addSubViews() {
        addSubview(searchInput)
        addSubview(searchButton)
        addSubview(deviderView)
    }

    private func setConstraints() {
        searchInput.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.width.equalTo(230)
            $0.top.equalToSuperview()
            $0.right.equalTo(searchButton.snp.left)
            $0.bottom.equalTo(deviderView).inset(4)
            $0.left.equalToSuperview().inset(12)
        }

        searchButton.snp.makeConstraints {
            $0.height.width.equalTo(35)
            $0.right.equalToSuperview().inset(12)
            $0.bottom.equalTo(deviderView).inset(4)
            $0.top.equalToSuperview()
        }

        deviderView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(12)
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview()
        }
    }

    @objc func searchTapped() {
        searchInput.text = ""
        searchTappedVoid?()
    }

    @objc func textFieldDidChange(sender: UITextField) {
        onTextEditingChange?(searchInput.text)
    }
}
