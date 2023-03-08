//
//  ChatHeaderView.swift
//  Hit
//
//  Created by Catarina Serrano on 06/03/23.
//

import UIKit

final class ChatHeaderView: UIView, ViewCodable {
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "New chat"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = AppColor.lightGray.color
        label.textAlignment = .center
        return label
    }()
    private lazy var menuIcon: UIButton = {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        button.setImage(AppAsset.menu.image, for: .normal)
        button.imageView?.tintColor = AppColor.lightGray.color
        return button
    }()
    private lazy var plusIcon: UIButton = {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        button.setImage(AppAsset.plus.image, for: .normal)
        button.imageView?.tintColor = AppColor.lightGray.color
        return button
    }()
    private lazy var hStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [menuIcon, title, plusIcon])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = AppColor.darkestGray.color
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.setup()
    }

    func setupSubviews() {
        self.addSubview(hStack)
    }

    func setupConstraints() {
        plusIcon.snp.makeConstraints {
            $0.width.equalTo(56)
        }

        menuIcon.snp.makeConstraints {
            $0.width.equalTo(56)
        }

        hStack.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
