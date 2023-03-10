//
//  MessageCell.swift
//  Hit
//
//  Created by Catarina Serrano on 09/03/23.
//

import Foundation
import UIKit

final class MessageCell: UITableViewCell, Identifiable, ViewModelBindable, ViewCodable {
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        return imageView
    }()
    private lazy var helperView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [icon, helperView])
        stack.axis = .vertical
        stack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return stack
    }()

    private lazy var messageText: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Arial", size: 15)
//        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()

    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [vStack, messageText])
        stack.axis = .horizontal
        stack.spacing = 16

        return stack
    }()

    var viewModel: MessageCellViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: "MessageCell")

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func bindViewModel() {
        messageText.text = viewModel?.message
        icon.image = viewModel?.type == .model ? UIImage(named: "openai") : AppAsset.user.image
        backgroundColor = viewModel?.type == .model ? AppColor.darkerGray.color : .clear
    }

    func setupSubviews() {
        addSubview(hStack)
        selectionStyle = .none
    }

    func setupConstraints() {
        icon.snp.makeConstraints {
            $0.width.equalTo(42)
            $0.height.equalTo(42)
        }
        helperView.snp.makeConstraints {
            $0.height.equalTo(24)
        }
        hStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(12)
        }
    }
}
