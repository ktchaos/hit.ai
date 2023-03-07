//
//  HitChatViewController.swift
//  Hit
//
//  Created by Catarina Serrano on 04/03/23.
//

import UIKit
import SnapKit
import RxSwift

final class HitChatViewController: UIViewController, ViewModelBindable {
    private let disposeBag = DisposeBag()

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
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .green
        return tableView
    }()
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        return view
    }()

    var viewModel: HitChatViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.setupSubviews()
        self.setupConstraints()
        self.setupColors()
        self.setupActions()
    }

    func bindViewModel() {
        viewModel?.output.chat.asDriver()
            .drive(onNext: { _ in })
            .disposed(by: disposeBag)
    }

    func setupSubviews() {
        self.view.addSubview(hStack)
        self.view.addSubview(tableView)
        self.view.addSubview(headerView)
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

        headerView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(120)
        }

        tableView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalTo(hStack.snp.top)
        }
    }

    func setupColors() {
        self.view.backgroundColor = .gray
    }

    func setupActions() {
        sendButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel?.input.sendMessage(input: self?.textField.text ?? "")
            })
            .disposed(by: disposeBag)
    }
}
