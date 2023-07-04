import UIKit
import SnapKit
import Then

class MainVC: BaseVC {
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .red
    }

    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
        }
    }
}
