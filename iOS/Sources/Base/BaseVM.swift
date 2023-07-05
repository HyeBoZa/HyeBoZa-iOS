import Foundation
import RxSwift
import RxCocoa

protocol BaseVM {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) -> Output
}
