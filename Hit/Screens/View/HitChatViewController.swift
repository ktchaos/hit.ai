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

    private lazy var headerView = ChatHeaderView()
    private lazy var messageTextField = MessageTextField()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()

    var viewModel: HitChatViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        setupSubviews()
        setupConstraints()
        setupActions()
        setupColors()
        setupKeyboardAppeances()
    }

    func bindViewModel() {
        viewModel?.output.cellViewModels
            .drive(tableView.rx.items(
                cellIdentifier: MessageCell.identifier,
                cellType: MessageCell.self
            )) { [weak self] _, item, cell in
                cell.bind(to: item)
                self?.tableView.scrollToBottom()
            }
            .disposed(by: self.disposeBag)
    }

    // MARK: Setup

    func setupSubviews() {
        view.addSubview(messageTextField)
        view.addSubview(tableView)
        view.addSubview(headerView)
    }

    func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(52)
        }

        tableView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalToSuperview().inset(100)
        }

        messageTextField.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(12)
            $0.trailing.leading.equalToSuperview().inset(12)
        }
    }

    func setupColors() {
       view.backgroundColor = AppColor.darkestGray.color
    }

    func setupActions() {
        messageTextField.sendButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.didTapOnSendButton()
            })
            .disposed(by: disposeBag)
    }

    func didTapOnSendButton() {
        viewModel?.input.sendMessage(input: messageTextField.textField.text ?? "")
        messageTextField.textField.text = ""
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.view.frame.origin.y = 0
            self?.view.endEditing(true)
        })
    }

    func setupKeyboardAppeances() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardWillShow(sender: NSNotification) {
        view.frame.origin.y = view.frame.origin.y - 345
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y = 0
    }
}
