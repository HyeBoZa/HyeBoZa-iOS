import Foundation
import RxCocoa
import RxSwift

class MainVM: BaseVM {
    private let disposeBag = DisposeBag()
    struct Input {
        let getUser: Driver<String>
        let getCategory: Driver<String>
        let selectedIndex: Signal<IndexPath>
        let searchText: Driver<String>
    }
    struct Output {
        let benefits: BehaviorRelay<[Benefits]>
        let nextID: BehaviorRelay<Int>
        let result: PublishRelay<Bool>
    }
    // swiftlint: disable function_body_length
    func transform(_ input: Input) -> Output {
        let api = Service()
        let benefits = BehaviorRelay<[Benefits]>(value: [])
        let nextID = BehaviorRelay<Int>(value: 0)
        let result = PublishRelay<Bool>()
        let params = Driver.combineLatest(input.getUser, input.getCategory, input.searchText)

        input.getUser.asObservable()
            .withLatestFrom(params)
            .flatMap { user, category, title in
                api.searchBenenfit(user, category, title)
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
            .flatMap { user, category, title in
                api.searchBenenfit(user, category, title)
            }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    benefits.accept(data!.benefitList)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)

        input.searchText.asObservable()
            .withLatestFrom(params)
            .flatMap { user, category, title in
                api.searchBenenfit(user, category, title)
            }
            .subscribe(onNext: { data, res in
                switch res {
                case .getOk:
                    benefits.accept(data!.benefitList)
                default:
                    result.accept(false )
                }
            })
            .disposed(by: disposeBag)

        input.selectedIndex.asObservable()
            .subscribe(onNext: { index in
                let value = benefits.value
                nextID.accept(value[index.row].id)
                result.accept(true)
            }).disposed(by: disposeBag)

        return Output(benefits: benefits, nextID: nextID, result: result)
    }
}
