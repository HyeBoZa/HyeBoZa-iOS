import UIKit
import SnapKit
import Then

class BaseTC: UITableViewCell {
    typealias HyeBoZaAsset = HyeBoZaIOSAsset

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureVC()
        self.addView()
        self.setLayout()
        self.backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureVC() {}
    func addView() {}
    func setLayout() {}
}
