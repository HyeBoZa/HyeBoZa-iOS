import UIKit
import SnapKit
import Then

class MainVC: BaseVC {
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
    private let pandaImage = UIImageView().then {
        $0.image = UIImage(named: "PANDA")
    }
    private let benefitTableView = UITableView().then {
    }

    override func addView() {
        searchBar.addSubview(magnifyButton)
        [
            logoImage,
            searchBar,
            pandaImage
        ] .forEach {
            view.addSubview($0)
        }
    }

    override func setLayout() {
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(55)
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
        pandaImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(680)
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview().inset(150)
            $0.right.equalToSuperview()
        }
    }
}
