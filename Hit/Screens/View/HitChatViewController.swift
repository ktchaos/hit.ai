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
        tableView.register(on: MessageCell.self)
        tableView.backgroundColor = .clear
        return tableView
    }()

    var viewModel: HitChatViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.setupSubviews()
        self.setupConstraints()
        self.setupActions()
        self.setupColors()
        setupKeyboardAppeances()
    }

    func bindViewModel() {
        viewModel?.output.chat.asDriver()
            .debug("[DEBUG]")
            .drive(onNext: { _ in })
            .disposed(by: disposeBag)
    }

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
            $0.top.equalTo(tableView.snp.bottom)
            $0.trailing.leading.equalToSuperview().inset(12)
        }
    }

    func setupColors() {
       view.backgroundColor = AppColor.darkestGray.color
    }

    func setupActions() {
        messageTextField.sendButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel?.input.sendMessage(input: self?.messageTextField.textField.text ?? "")
            })
            .disposed(by: disposeBag)
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

    // TODO: Improve UX for keyboard

    @objc func keyboardWillShow(sender: NSNotification) {
//        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
//            return
//        }
//
//
//        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
//        let convertedTextFieldFrame = view.convert(messageTextField.frame, to: messageTextField.superview)
//        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
//
//        let textBoxY = convertedTextFieldFrame.origin.y
//        let newFrameY = (textBoxY - keyboardTopY / 2) * -1
//
//        view.frame.origin.y = newFrameY

//        self.messageTextField.frame.origin.y = messageTextField.frame.origin.y - 200
        view.frame.origin.y = view.frame.origin.y - 300
    }

    @objc func keyboardWillHide(sender: NSNotification) {
//        self.messageTextField.frame.origin.y = 0
        view.frame.origin.y = 0
    }
}
