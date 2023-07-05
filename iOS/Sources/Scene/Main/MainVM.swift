import Foundation
import RxCocoa
import RxSwift

class MainVM: BaseVM {
    private let disposeBag = DisposeBag()
    struct Input {
        let getUser: Driver<String>
        let getCategory: Driver<String>
    }
    struct Output {
        let benefits: PublishRelay<[Benefits]>
        let result: PublishRelay<Bool>
    }
    func transform(_ input: Input) -> Output {
        let api = Service()
        let benefits = PublishRelay<[Benefits]>()
        let result = PublishRelay<Bool>()
        let params = Driver.combineLatest(input.getUser, input.getCategory)

        input.getUser.asObservable()
            .withLatestFrom(params)
            .flatMap { user, category in
                api.getBenefits(user, category)
            }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    benefits.accept(data?.benefitList ?? [])
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)

        input.getCategory.asObservable()
            .withLatestFrom(params)
            .flatMap { user, category in
                api.getBenefits(user, category)
            }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    benefits.accept(data?.benefitList ?? [])
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)

        return Output(benefits: benefits, result: result)
    }
}
