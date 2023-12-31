import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

extension UITextField {
    func addPaddingToTextField(_ left: CGFloat, _ right: CGFloat) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
        self.leftView = leftPaddingView
        self.rightView = rightPaddingView
        self.leftViewMode = ViewMode.always
        self.rightViewMode = ViewMode.always
    }
    func setTextField(forTextField: UITextField, placeholderText: String) {
        forTextField.attributedPlaceholder = NSAttributedString(
            string: "\(placeholderText)", attributes: [
                .foregroundColor: UIColor(named: "Sub") ?? "",
                .font: UIFont.systemFont(ofSize: 15, weight: .regular)
            ]
        )
        forTextField.backgroundColor = .white
        forTextField.layer.borderWidth = 2
        forTextField.layer.borderColor = UIColor(named: "Main")?.cgColor
        forTextField.textColor = UIColor(named: "Main2")
        forTextField.font = .systemFont(ofSize: 15, weight: .regular)
    }
}
