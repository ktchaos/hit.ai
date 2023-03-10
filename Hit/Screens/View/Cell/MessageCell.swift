//
//  MessageCell.swift
//  Hit
//
//  Created by Catarina Serrano on 09/03/23.
//

import Foundation
import UIKit

final class MessageCell: UITableViewCell, Identifiable, ViewModelBindable, ViewCodable {
    private lazy var icon: UIView = {
        let imageView = UIView()//UIImageView(image: AppAsset.user.image)
        imageView.backgroundColor = .blue
        return imageView
    }()

    private lazy var messageText: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Arial", size: 15)
        label.backgroundColor = .red
        return label
    }()

    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [icon, messageText])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.backgroundColor = .green
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
    }

    func setupSubviews() {
        addSubview(hStack)
    }

    func setupConstraints() {
        icon.snp.makeConstraints {
            $0.width.equalTo(50)
        }
        hStack.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}
