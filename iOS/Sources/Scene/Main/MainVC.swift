import UIKit
import SnapKit
import Then

class MainVC: BaseVC {
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }

    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(<#T##view: UIView##UIView#>)
    }
}
