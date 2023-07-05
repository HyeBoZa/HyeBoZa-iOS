import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class MainVC: BaseVC {
    private let viewModel = MainVM()
    private let user = BehaviorRelay<String>(value: "")
    private let category = BehaviorRelay<String>(value: "")
    private let nextID = BehaviorRelay<Int>(value: 0)

    private let logoImage = UIImageView().then {
        $0.image = UIImage(named: "LOGO_SMALL")
    }
    private let searchBar = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "원하시는 혜택을 검색해주세요.")
        $0.addPaddingToTextField(size: 20)
        $0.layer.shadow(color: UIColor(named: "Shadow")!, alpha: 0.15, x: 0, y: 1, blur: 10, spread: 0)
    }
    private let magnifyButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let searchImage = UIImage(systemName: "magnifyingglass", withConfiguration: imageConfig.self)
        $0.setImage(searchImage, for: .normal)
        $0.tintColor = UIColor(named: "Main")
    }
    private let benefitTableView = UITableView().then {
        $0.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        $0.separatorInset.left = 0
//        $0.allowsSelection = false
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(named: "Sub")?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
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

    override func bind() {
        let input = MainVM.Input(
            getUser: user.asDriver(onErrorJustReturn: "CHILD"),
            getCategory: category.asDriver(onErrorJustReturn: "CARD"),
            selectedIndex: benefitTableView.rx.itemSelected.asSignal()
        )
        let output = self.viewModel.transform(input)

        output.benefits.bind(to: benefitTableView.rx.items(
            cellIdentifier: "MainCell", cellType: MainCell.self)
        ) { _, items, cell in
            cell.selectionStyle = .none
            switch items.benefitCategory {
            case "카드":
                cell.categoryImage.image = UIImage(named: "CARD")
            case "혜택":
                cell.categoryImage.image = UIImage(named: "BENEFIT")
            case "제도":
                cell.categoryImage.image = UIImage(named: "ROYAL")
            case "정책":
                cell.categoryImage.image = UIImage(named: "BOOK")
            default:
                print("이미지 선택 불가")
            }
            cell.title.text = items.title
            cell.condition.text = items.control
            cell.content.text = items.content
        }.disposed(by: disposeBag)
        output.nextID.asObservable()
            .subscribe(onNext: {
                self.nextID.accept($0)
            }).disposed(by: disposeBag)
        benefitTableView.rx.itemSelected
            .subscribe(onNext: { _ in
                let next = DetailVC()
                next.benefitID.accept(self.nextID.value)
                next.modalPresentationStyle = .fullScreen
                self.present(next, animated: false)
            }).disposed(by: disposeBag)
    }
    override func addView() {
        searchBar.addSubview(magnifyButton)
        [
            logoImage,
            searchBar,
            userMenuButton,
            categoryMenuButton,
            benefitTableView
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
        searchBar.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom)
            $0.left.right.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        magnifyButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(13)
            $0.right.equalToSuperview().inset(20)
        }
        userMenuButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(18)
            $0.left.equalToSuperview().inset(30)
            $0.height.equalTo(35)
            $0.width.equalTo(90)
        }
        categoryMenuButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(18)
            $0.left.equalTo(userMenuButton.snp.right).offset(14)
            $0.height.equalTo(35)
            $0.width.equalTo(106)
        }
        benefitTableView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(30)
            $0.top.equalTo(searchBar.snp.bottom).offset(65)
            $0.bottom.equalToSuperview().inset(185)
        }
    }
}
