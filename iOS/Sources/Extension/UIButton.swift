import UIKit

extension UIButton {
    func setUpMenuButton(_ button: UIButton, _ placeholder: String) {
        button.setTitle("\(placeholder)", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setTitleColor(UIColor(named: "Main2"), for: .normal)
        button.tintColor = UIColor(named: "Main2")
        button.layer.borderColor = UIColor(named: "Main2")?.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 10
    }
}
