//
//  MessageTextField.swift
//  Hit
//
//  Created by Catarina Serrano on 06/03/23.
//

import UIKit
import RxSwift

final class MessageTextField: UIView, ViewCodable {
    // MARK: Properties

    private let disposeBag = DisposeBag()

    public lazy var textField: UITextField = {
        let textField = UITextField()
        textField.addPadding(.both(15))
        textField.backgroundColor = .white
        textField.textColor = .white
        textField.tintColor = .white
        textField.backgroundColor = AppColor.darkerGray.color
        textField.layer.cornerRadius = 6
        textField.becomeFirstResponder()
        return textField
    }()
    public lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(AppAsset.paperPlane.image, for: .normal)
        button.imageView?.tintColor = AppColor.lightGray.color
        return button
    }()
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textField, sendButton])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.backgroundColor = AppColor.darkerGray.color
        stack.layer.cornerRadius = 6
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOffset = .zero
        stack.layer.shadowOpacity = 0.5
        stack.layer.shadowRadius = 5.0
        stack.layer.masksToBounds = false

        return stack
    }()

    // MARK: - Init

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
    }

    func setupConstraints() {
        sendButton.snp.makeConstraints {
            $0.width.equalTo(50)
        }

        hStack.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }

    func setupExtraConfigurations() {
        self.textField.rx.controlEvent([.editingDidEndOnExit])
            .asObservable()
            .subscribe(onNext: { _ in
                // TODO: Add also button action
            })
            .disposed(by: disposeBag)
    }
}
