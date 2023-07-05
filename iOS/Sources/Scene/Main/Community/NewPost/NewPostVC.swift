import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class NewPostVC: BaseVC {
    private let viewModel = NewPostVM()
    private let user = BehaviorRelay<String>(value: "")
    private let category = BehaviorRelay<String>(value: "")

    private let logoImage = UIImageView().then {
        $0.image = UIImage(named: "LOGO_SMALL")
    }
    private let titleTextField = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "제목을 입력해주세요.")
        $0.layer.cornerRadius = 10
        $0.addPaddingToTextField(20, 20)
        $0.layer.shadow(color: UIColor(named: "Shadow")!, alpha: 0.15, x: 0, y: 1, blur: 10, spread: 0)
    }
    private let contentTextView = UITextView().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(named: "Sub")?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
        $0.textColor = UIColor(named: "Content")
    }
    private let userMenuButton = UIButton().then {
        $0.setUpMenuButton($0, "대상자  ")
    }
    private let categoryMenuButton = UIButton().then {
        $0.setUpMenuButton($0, "카테고리  ")
    }
    private var userMenuItems: [UIAction] {
        return [
            UIAction(title: "어린이", handler: { (_) in
                self.user.accept("CHILD")
                self.userMenuButton.setTitle("어린이  ", for: .normal)
            }),
            UIAction(title: "청소년", handler: { (_) in
                self.user.accept("TEEN")
                self.userMenuButton.setTitle("청소년  ", for: .normal)
            }),
            UIAction(title: "청년", handler: { (_) in
                self.user.accept("YOUTH")
                self.userMenuButton.setTitle("청년  ", for: .normal)
            }),
            UIAction(title: "임산부", handler: { (_) in
                self.user.accept("PREGNANT")
                self.userMenuButton.setTitle("임산부  ", for: .normal)
            }),
            UIAction(title: "노인", handler: { (_) in
                self.user.accept("OLD")
                self.userMenuButton.setTitle("노인  ", for: .normal)
            })
        ]
    }
    private var categoryMenuItems: [UIAction] {
        return [
            UIAction(title: "카드", handler: { (_) in
                self.category.accept("CARD")
                self.categoryMenuButton.setTitle("카드  ", for: .normal)
            }),
            UIAction(title: "혜택", handler: { (_) in
                self.category.accept("BENEFIT")
                self.categoryMenuButton.setTitle("혜택  ", for: .normal)
            }),
            UIAction(title: "제도", handler: { (_) in
                self.category.accept("ROYAL")
                self.categoryMenuButton.setTitle("제도  ", for: .normal)
            }),
            UIAction(title: "정책", handler: { (_) in
                self.category.accept("BOOK")
                self.categoryMenuButton.setTitle("정책  ", for: .normal)
            })
        ]
    }
    private var userMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: [], children: userMenuItems)
    }
    private var categoryMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: [], children: categoryMenuItems)
    }
    private let sendButton = UIButton().then {
        $0.setTitle("게시하기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = UIColor(named: "Main2")
        $0.layer.borderColor = UIColor(named: "Main2")?.cgColor
        $0.layer.borderWidth = 1.5
        $0.layer.cornerRadius = 10
    }

    // swiftlint : disable function_body_length
    override func bind() {
        let input = NewPostVM.Input(
            title: titleTextField.rx.text.orEmpty.asDriver(),
            content: contentTextView.rx.text.orEmpty.asDriver(),
            buttonTapped: sendButton.rx.tap.asSignal()
        )
        let output = self.viewModel.transform(input)
        output.result.asObservable()
            .subscribe(onNext: { res in
                if res == true {
                    self.dismiss(animated: true)
                }
            }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            logoImage,
            titleTextField,
            userMenuButton,
            categoryMenuButton,
            sendButton
        ] .forEach {
            view.addSubview($0)
        }
    }
    override func configureVC() {
        view.layer.contents = UIImage(imageLiteralResourceName: "Template").cgImage
        userMenuButton.menu = userMenu
        userMenuButton.showsMenuAsPrimaryAction = true
        categoryMenuButton.menu = categoryMenu
        categoryMenuButton.showsMenuAsPrimaryAction = true
    }
    override func setLayout() {
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.left.equalToSuperview().inset(30)
            $0.width.height.equalTo(50)
        }
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        userMenuButton.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(18)
            $0.left.equalToSuperview().inset(30)
            $0.height.equalTo(35)
            $0.width.equalTo(90)
        }
        categoryMenuButton.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(18)
            $0.left.equalTo(userMenuButton.snp.right).offset(14)
            $0.height.equalTo(35)
            $0.width.equalTo(106)
        }
        contentTextView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(30)
            $0.top.equalTo(titleTextField.snp.bottom).offset(65)
            $0.bottom.equalToSuperview().inset(190)
        }
        sendButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(30)
            $0.top.equalTo(contentTextView.snp.bottom).offset(24)
        }
    }
}
