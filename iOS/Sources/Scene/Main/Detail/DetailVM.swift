import Foundation
import RxCocoa
import RxSwift

class DetailVM: BaseVM {
    private let disposeBag = DisposeBag()
    struct Input {
        let getDetail: Driver<Void>
        let benefitID: Driver<Int>
    }
    struct Output {
        let benefits: PublishRelay<Benefits>
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let api = Service()
        let benefits = PublishRelay<Benefits>()
        let result = PublishRelay<Bool>()

        input.getDetail.asObservable()
            .withLatestFrom(input.benefitID)
            .flatMap { id in
                api.getDetail(id)
            }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    benefits.accept(data!)
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)

        return Output(benefits: benefits, result: result)
    }
}
