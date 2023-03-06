//
//  HitChatViewController.swift
//  Hit
//
//  Created by Catarina Serrano on 04/03/23.
//

import UIKit
import SnapKit

final class HitChatViewController: UIViewController, ViewModelBindable {
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .blue
        return textField
    }()
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("", for: .normal)
        return button
    }()
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textField, sendButton])
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()

    var viewModel: HitChatViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.setupSubviews()
        self.setupConstraints()

        self.viewModel?.input.sendMessage(input: "Who is the president of Hawaii?")
    }

    func bindViewModel() {

    }

    func setupSubviews() {
        self.view.addSubview(hStack)
    }

    func setupConstraints() {
        sendButton.snp.makeConstraints {
            $0.width.equalTo(36)
        }

        hStack.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().inset(42)
        }
    }
}
