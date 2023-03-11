//
//  LoadingStateView.swift
//  Hit
//
//  Created by Catarina Serrano on 11/03/23.
//

import Foundation
import UIKit

class LoadingStateView: UIView, ViewCodable {
    // MARK: Properties
    private lazy var firstDot: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private lazy var secondDot: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private lazy var thirdDot: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstDot, secondDot, thirdDot])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .equalSpacing
        return stack
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.setup()
    }

    // MARK: Setup

    func setupSubviews() {
        self.addSubview(hStack)
        self.backgroundColor = .clear
    }

    func setupConstraints() {
        firstDot.snp.makeConstraints {
            $0.width.equalTo(10)
        }
        secondDot.snp.makeConstraints {
            $0.width.equalTo(10)
        }
        thirdDot.snp.makeConstraints {
            $0.width.equalTo(10)
        }
        hStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().inset(300)
        }
    }

    func setupExtraConfigurations() {
        hStack.subviews.forEach {
            $0.layer.cornerRadius = 5
        }
    }

    // MARK: Actions

    func startLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.firstDot.fadeOut()
            self?.firstDot.fadeIn()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.secondDot.fadeOut()
            self?.secondDot.fadeIn()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.thirdDot.fadeOut()
            self?.thirdDot.fadeIn()
        }
    }
}
