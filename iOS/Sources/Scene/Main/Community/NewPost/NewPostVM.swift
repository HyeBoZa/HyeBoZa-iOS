import Foundation
import RxCocoa
import RxSwift

class NewPostVM: BaseVM {
    private let disposeBag = DisposeBag()
    struct Input {
        let title: Driver<String>
        let content: Driver<String>
        let buttonTapped: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        let params = Driver.combineLatest(input.title, input.content)

        input.title.asObservable()
            .withLatestFrom(params)
            .flatMap { title, content in
                api.postNewBoard(title, content)
            }
            .subscribe(onNext: { res in
                switch res {
                case .getOk:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)

        return Output(result: result)
    }
}

