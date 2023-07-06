import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class PostListVC: BaseVC {
    private let viewModel = PostListVM()
    private let getBoards = BehaviorRelay<Void>(value: ())
    private let nextID = BehaviorRelay<Int>(value: 0)

    private let logoImage = UIImageView().then {
        $0.image = UIImage(named: "LOGO_SMALL")
    }
    private let newPostButton = UIButton().then {
        $0.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        $0.tintColor = UIColor(named: "Main2")
        $0.layer.borderColor = UIColor(named: "Sub")?.cgColor
        $0.layer.borderWidth = 1.5
        $0.layer.cornerRadius = 10
    }
    private let searchBar = UITextField().then {
        $0.setTextField(forTextField: $0, placeholderText: "제목을 검색해주세요.")
        $0.layer.cornerRadius = 25
        $0.addPaddingToTextField(20, 60)
        $0.layer.shadow(color: UIColor(named: "Shadow")!, alpha: 0.15, x: 0, y: 1, blur: 10, spread: 0)
    }
    private let magnifyButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let searchImage = UIImage(systemName: "magnifyingglass", withConfiguration: imageConfig.self)
        $0.setImage(searchImage, for: .normal)
        $0.tintColor = UIColor(named: "Main")
    }
    private let postsTableView = UITableView().then {
        $0.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        $0.separatorInset.left = 0
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(named: "Sub")?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
        $0.showsVerticalScrollIndicator = false
    }
    private let backButton = UIButton().then {
        $0.setTitle("홈으로 돌아가기  ", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.setImage(UIImage(systemName: "house.fill"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = UIColor(named: "Main2")
        $0.layer.borderColor = UIColor(named: "Sub")?.cgColor
        $0.layer.borderWidth = 1.5
        $0.layer.cornerRadius = 10
    }

    // swiftlint : disable function_body_length
    override func bind() {
        let input = PostListVM.Input(
            getBoards: getBoards.asDriver(onErrorJustReturn: ()),
            selectedIndex: postsTableView.rx.itemSelected.asSignal(),
            titleInput: searchBar.rx.text.orEmpty.asDriver()
        )
        let output = self.viewModel.transform(input)

        output.posts.bind(to: postsTableView.rx.items(
            cellIdentifier: "PostCell", cellType: PostCell.self)
        ) { _, items, cell in
            cell.selectionStyle = .none
            cell.title.text = items.title
        }.disposed(by: disposeBag)
        output.nextID.asObservable()
            .subscribe(onNext: {
                self.nextID.accept($0)
            }).disposed(by: disposeBag)
        postsTableView.rx.itemSelected
            .subscribe(onNext: { _ in
                let next = PostDetailVC()
                next.postID.accept(self.nextID.value)
                next.modalPresentationStyle = .fullScreen
                self.present(next, animated: false)
            }).disposed(by: disposeBag)
    }
    override func addView() {
        searchBar.addSubview(magnifyButton)
        [
            logoImage,
            newPostButton,
            searchBar,
            postsTableView,
            backButton
        ] .forEach {
            view.addSubview($0)
        }
    }
    override func configureVC() {
        newPostButton.rx.tap
            .subscribe(onNext: {
                let next = NewPostVC()
                next.modalPresentationStyle = .fullScreen
                self.present(next, animated: false)
            }).disposed(by: disposeBag)
        backButton.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
    override func setLayout() {
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.left.equalToSuperview().inset(30)
            $0.width.height.equalTo(50)
        }
        newPostButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(72)
            $0.right.equalToSuperview().inset(30)
            $0.width.height.equalTo(34)
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
        postsTableView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(30)
            $0.top.equalTo(searchBar.snp.bottom).offset(34)
            $0.bottom.equalToSuperview().inset(185)
        }
        backButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(30)
            $0.top.equalTo(postsTableView.snp.bottom).offset(24)
            $0.height.equalTo(40)
        }
    }
}
